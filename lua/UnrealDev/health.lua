-- lua/UnrealDev/health.lua

local M = {}

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

--- パーサーが実際にロードできるかを Neovim ネイティブ API で確認します。
--- nvim-treesitter / tree-sitter-manager のどちらでインストールしても動作します。
local function check_treesitter_parser(lang, description)
  local ok = pcall(vim.treesitter.language.inspect, lang)
  if ok then
    vim.health.ok(string.format("Tree-sitter parser '%s': Installed (%s)", lang, description))
  else
    vim.health.warn(string.format("Tree-sitter parser '%s': Not installed", lang), {
      string.format("Required for %s.", description),
      string.format("Add '%s' to ensure_installed in your tree-sitter-manager config.", lang),
    })
  end
end

local function check_custom_cpp_parser()
  local test_code = "UCLASS() class AMyActor : public AActor {};"
  local ok_parser, lang_tree = pcall(vim.treesitter.get_string_parser, test_code, "cpp")

  if not ok_parser or not lang_tree then
    vim.health.error("Tree-sitter 'cpp' parser is missing or broken.", {
      "Neovim could not load the cpp parser.",
      "Check that 'cpp' is in ensure_installed of your tree-sitter-manager config.",
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
      "Set the cpp url in tree-sitter-manager to 'https://github.com/taku25/tree-sitter-cpp'.",
      "  cpp = { install_info = { url = 'https://github.com/taku25/tree-sitter-cpp', use_repo_queries = true } }",
    })
    return
  end

  vim.health.ok("Custom Unreal C++ parser (taku25/tree-sitter-cpp) is active.")
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

  -- 3. Tree-sitter Manager
  check_plugin("tree-sitter-manager", "tree-sitter-manager", "Tree-sitter Parser Manager", false)

  check_plugin("USX.nvim", "USX", "Unreal Shader Syntax & Queries", false)

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
  check_treesitter_parser("ushader", "Unreal Shader Highlighting (taku25/tree-sitter-unreal-shader)")
  check_treesitter_parser("verse",   "Verse Language Support (taku25/tree-sitter-verse)")
end

return M
