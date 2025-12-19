-- lua/UnrealDev/health.lua

local M = {}

-- ★ 推奨される tree-sitter-unreal-cpp のリビジョンハッシュ
local RECOMMENDED_CPP_REVISION = "67198f1b35e052c6dbd587492ad53168d18a19a8"

local function check_plugin(name, module_name, description, is_required)
  local ok = pcall(require, module_name)
  if ok then
    vim.health.ok(string.format("%s: Installed (%s)", name, description))
  else
    if is_required then
      vim.health.error(string.format("%s: Not found (Required)", name), { "This is a core dependency.", string.format("Please install '%s'.", name) })
    else
      vim.health.warn(string.format("%s: Not found (Optional)", name), { string.format("Install %s to enable %s features.", name, description) })
    end
  end
end

local function check_executable(name, description)
  if vim.fn.executable(name) == 1 then
    vim.health.ok(string.format("Executable '%s': Found (%s)", name, description))
  else
    vim.health.error(string.format("Executable '%s': Not found (Required)", name), { string.format("Please install '%s'.", name) })
  end
end

-- ★修正: セクションを切らずに項目だけチェックする関数に変更
local function check_sqlite()
  -- 1. プラグイン読み込みチェック
  local has_sqlite, sqlite = pcall(require, "sqlite")
  if not has_sqlite then
    vim.health.error("Plugin 'kkharji/sqlite.lua' not found.", {
      "This is required for database features.",
      "Please install 'kkharji/sqlite.lua'."
    })
    return
  end
  vim.health.ok("Plugin 'kkharji/sqlite.lua' found.")

  -- 2. パス設定の確認 (Windowsのみ)
  if vim.fn.has("win32") == 1 then
    local clib_path = vim.g.sqlite_clib_path
    if clib_path and vim.fn.filereadable(clib_path) == 1 then
      vim.health.ok("Path configured: " .. clib_path)
    else
      vim.health.warn("vim.g.sqlite_clib_path is invalid or not set.", {
        "Windows often requires explicit path setting in init.lua.",
        "Example: vim.g.sqlite_clib_path = vim.fn.expand('~/AppData/.../sqlite3.dll')"
      })
    end
  end

  -- 3. 実動作テスト (メモリDBの開閉)
  local db_ok, err = pcall(function()
    local db = sqlite.new(":memory:")
    db:open()
    db:close()
  end)

  if db_ok then
    vim.health.ok("SQLite is working correctly! (In-memory DB test passed)")
  else
    vim.health.error("SQLite library loaded but failed to open DB.", {
      "Error: " .. tostring(err),
      "Ensure you are using 64-bit sqlite3.dll.",
      "Check paths in init.lua."
    })
  end
end

local function check_treesitter_parser(lang, description)
  local ok, parsers = pcall(require, "nvim-treesitter.parsers")
  if not ok or not parsers or not parsers.has_parser then 
    return 
  end

  if parsers.has_parser(lang) then
    vim.health.ok(string.format("Tree-sitter parser '%s': Installed (%s)", lang, description))
  else
    vim.health.warn(string.format("Tree-sitter parser '%s': Not found", lang), {
      string.format("This parser is required for %s.", description),
      string.format("Run ':TSInstall %s' to install it.", lang)
    })
  end
end

local function check_custom_cpp_parser()
  -- (変更なし)
  local test_code = "UCLASS() class AMyActor : public AActor {};"
  local ok_parser, lang_tree = pcall(vim.treesitter.get_string_parser, test_code, "cpp")

  if not ok_parser or not lang_tree then
    vim.health.error("Tree-sitter 'cpp' parser is missing or broken.", {
      "Neovim could not load the cpp parser.",
      "Please run ':TSInstall cpp' (or update it)."
    })
    return
  end

  local ok_parse, trees = pcall(function() return lang_tree:parse() end)
  if not ok_parse or not trees or #trees == 0 then
    vim.health.error("Failed to parse test code with cpp parser.")
    return
  end

  local root = trees[1]:root()
  local is_unreal_parser = false
  
  for child in root:iter_children() do
    if child:type() == "unreal_class_declaration" then
      is_unreal_parser = true
      break
    end
  end

  if not is_unreal_parser then
    vim.health.warn("Standard C++ parser detected. (Not the Unreal-patched version)", {
      "Features like 'Goto Super', 'Symbols View', and 'Implement Virtual' require the custom parser.",
      "Please update your nvim-treesitter config to use 'taku25/tree-sitter-unreal-cpp'.",
      "Run ':TSUpdate cpp' after updating the config."
    })
    return 
  end

  local has_ts, parsers = pcall(require, "nvim-treesitter.parsers")
  local installed_rev = nil
  
  if has_ts and parsers then
      local configs = (parsers.get_parser_configs and parsers.get_parser_configs()) or parsers
      if configs.cpp then
          local info = configs.cpp.install_info or configs.cpp
          if info and info.revision then
              installed_rev = info.revision
          elseif info and info.url then
               installed_rev = "Local/Custom URL (" .. tostring(info.url) .. ")"
          end
      end
  end

  if installed_rev then
      if installed_rev == RECOMMENDED_CPP_REVISION then
        vim.health.ok(string.format("Custom Unreal C++ parser is active and up-to-date.\n    Revision: %s", installed_rev))
      else
        vim.health.info(string.format("Custom Unreal C++ parser is active (Revision mismatch).", {
          string.format("Installed:   %s", installed_rev),
          string.format("Recommended: %s", RECOMMENDED_CPP_REVISION),
          "Since the parser is working correctly, this is likely fine.",
          "If you encounter issues, consider updating to the recommended revision."
        }))
      end
  else
      vim.health.ok("Custom Unreal C++ parser is active. (Revision info unavailable)")
  end
end

---
-- メインのチェック関数
function M.check()
  vim.health.start("UnrealDev Dependencies")

  -- 1. External Tools
  check_executable("fd", "File finder")
  check_executable("rg", "Ripgrep text searcher")

  -- 2. Core Library
  check_plugin("UNL.nvim", "UNL", "Core Library & Utilities", true)
  
  -- ★ 3. Database (ここにSQLiteチェックを追加)
  check_sqlite()

  -- 4. Tree-sitter Core
  check_plugin("nvim-treesitter", "nvim-treesitter", "Syntax Highlighting & Parsing", true)
  
  check_plugin("USX.nvim", "USX", "Unreal Shader Syntax & Queries", false)

  -- 5. Core Features
  check_plugin("UEP.nvim", "UEP", "Project Analysis & Navigation", false)
  check_plugin("UNX.nvim", "UNX", "Explorer UI", false)

  -- 6. Optional Features
  check_plugin("UBT.nvim", "UBT", "Build Tool Integration", false)
  check_plugin("ULG.nvim", "ULG", "Log Viewer", false)
  check_plugin("UCM.nvim", "UCM", "Class Management", false)
  check_plugin("UEA.nvim", "UEA", "Asset Integration", false)
  check_plugin("USH.nvim", "USH", "UnrealShell Integration", false)
  check_plugin("UDB.nvim", "UDB", "Debugger Integration", false)

  -- 7. Tree-sitter Parsers Check
  vim.health.start("UnrealDev Parsers")
  
  check_custom_cpp_parser() 
  check_treesitter_parser("ushader", "Unreal Shader Highlighting")
  check_treesitter_parser("json", "Project File Parsing")
end

return M
