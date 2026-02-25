-- lua/UnrealDev/health.lua

local M = {}

-- ★ 推奨される tree-sitter-unreal-cpp のリビジョンハッシュ
local RECOMMENDED_CPP_REVISION = "7bbb85f1fcc6e109c90cea2167e88a5a472910d3"

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

local function check_unl_scanner()
  local has_unl, unl_scanner = pcall(require, "UNL.scanner")
  if not has_unl then
    vim.health.error("Plugin 'taku25/UNL.nvim' not found.", { "Please install 'taku25/UNL.nvim'." })
    return
  end

  local binary = unl_scanner.get_binary_path()
  if binary then
    vim.health.ok(string.format("UNL Scanner: Found (%s)", binary))
  else
    -- どこを探したかを表示するためのヒントを作成
    local source = debug.getinfo(unl_scanner.get_binary_path).source
    if source:sub(1,1) == "@" then source = source:sub(2) end
    local plugin_root = vim.fn.fnamemodify(source, ":p:h:h:h:h")
    local is_win = vim.fn.has("win32") == 1
    local binary_name = is_win and "unl-scanner.exe" or "unl-scanner"
    local expected_path = plugin_root .. (is_win and "\\scanner\\target\\release\\" or "/scanner/target/release/") .. binary_name

    vim.health.error("UNL Scanner binary not found.", {
      string.format("Expected path: %s", expected_path),
      "The Rust-based scanner needs to be compiled.",
      "If you are using lazy.nvim, please check if the build was successful in the :Lazy UI.",
      "You can manually trigger a build by pressing 'b' on UNL.nvim in the :Lazy menu.",
      "Or run the manual build command in a terminal:",
      string.format("  cd %s", plugin_root),
      "  cargo build --release --manifest-path scanner/Cargo.toml"
    })
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
  check_unl_scanner()
  
  -- 3. Tree-sitter Core
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
