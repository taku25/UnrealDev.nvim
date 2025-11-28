-- lua/UnrealDev/health.lua

local M = {}

-- ★ 推奨される tree-sitter-unreal-cpp のリビジョンハッシュ
local RECOMMENDED_CPP_REVISION = "67198f1b35e052c6dbd587492ad53168d18a19a8"

-- ... (check_plugin, check_executable は変更なし) ...
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

---
-- 標準的な Tree-sitter パーサーのインストール状況をチェックするヘルパー
local function check_treesitter_parser(lang, description)
  local ok, parsers = pcall(require, "nvim-treesitter.parsers")
  -- ★修正: parsersモジュール自体と、has_parser関数の存在をチェック
  if not ok or not parsers or not parsers.has_parser then 
    return -- nvim-treesitterが無効な場合は無視
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

---
-- カスタム Unreal C++ パーサーの状態（機能・バージョン）を詳細にチェックする関数
local function check_custom_cpp_parser()
  -- 1. 動作チェック: 実際にNeovimのコアAPIでパースを試みる
  -- これが成功すれば「cppパーサーはインストールされている」とみなせる
  local test_code = "UCLASS() class AMyActor : public AActor {};"
  local ok_parser, lang_tree = pcall(vim.treesitter.get_string_parser, test_code, "cpp")

  if not ok_parser or not lang_tree then
    vim.health.error("Tree-sitter 'cpp' parser is missing or broken.", {
      "Neovim could not load the cpp parser.",
      "Please run ':TSInstall cpp' (or update it)."
    })
    return
  end

  -- 2. 機能チェック: 独自ノード 'unreal_class_declaration' が生成されるか確認
  -- これで「標準パーサー」か「カスタムパーサー」かを判別する
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
    return -- 標準パーサーの場合はリビジョンチェックは行わない
  end

  -- 3. バージョン（リビジョン）チェック
  -- nvim-treesitter.parsers モジュールから設定を取得を試みる
  local has_ts, parsers = pcall(require, "nvim-treesitter.parsers")
  
  if has_ts and parsers then
    -- get_parser_configs 関数がある場合はそれを使い、なければ parsers 自体をテーブルとして扱う
    local configs = (parsers.get_parser_configs and parsers.get_parser_configs()) or parsers
    
    -- cpp の設定を取得
    local config = configs["cpp"]
    
    if config and config.install_info and config.install_info.revision then
      local installed_rev = config.install_info.revision

      if installed_rev == RECOMMENDED_CPP_REVISION then
        vim.health.ok(string.format("Custom Unreal C++ parser is active and up-to-date.\n    Revision: %s", installed_rev))
      else
        vim.health.warn("Custom Unreal C++ parser revision mismatch.", {
          string.format("Installed:   %s", installed_rev),
          string.format("Recommended: %s", RECOMMENDED_CPP_REVISION),
          "If you are experiencing issues, please update the revision in your config and run ':TSUpdate cpp'."
        })
      end
    else
      -- リビジョン情報が取得できない場合（ローカルパス指定など）
      vim.health.ok("Custom Unreal C++ parser is active. (Revision info unavailable)")
    end
  else
    -- nvim-treesitter.parsers が読み込めない場合
    vim.health.ok("Custom Unreal C++ parser is active. (Skipped revision check)")
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
  
  -- 3. Tree-sitter Core
  check_plugin("nvim-treesitter", "nvim-treesitter", "Syntax Highlighting & Parsing", true)

  -- 4. Core Features
  check_plugin("UEP.nvim", "UEP", "Project Analysis & Navigation", false)
  check_plugin("UNX.nvim", "UNX", "Explorer UI", false)

  -- 5. Optional Features
  check_plugin("UBT.nvim", "UBT", "Build Tool Integration", false)
  check_plugin("ULG.nvim", "ULG", "Log Viewer", false)
  check_plugin("UCM.nvim", "UCM", "Class Management", false)
  check_plugin("UEA.nvim", "UEA", "Asset Integration", false)
  check_plugin("USH.nvim", "USH", "UnrealShell Integration", false)
  check_plugin("UDB.nvim", "UDB", "Debugger Integration", false)

  -- 6. Tree-sitter Parsers Check
  vim.health.start("UnrealDev Parsers")
  
  check_custom_cpp_parser() 
  check_treesitter_parser("ushader", "Unreal Shader Highlighting")
  check_treesitter_parser("json", "Project File Parsing")
end

return M
