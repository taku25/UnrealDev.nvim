local M = {}

local function check_plugin(name, module_name, description, is_required)
  local ok = pcall(require, module_name)
  
  if ok then
    vim.health.ok(string.format("%s: Installed (%s)", name, description))
  else
    if is_required then
      vim.health.error(string.format("%s: Not found (Required)", name), {
        "This is a core dependency required for UnrealDev to work.",
        string.format("Please install '%s'.", name)
      })
    else
      vim.health.warn(string.format("%s: Not found (Optional)", name), {
        string.format("Install %s to enable %s features.", name, description)
      })
    end
  end
end

local function check_executable(name, description)
  if vim.fn.executable(name) == 1 then
    vim.health.ok(string.format("Executable '%s': Found (%s)", name, description))
  else
    vim.health.error(string.format("Executable '%s': Not found (Required)", name), {
      string.format("UnrealDev relies on '%s' for fast file searching and grepping.", name),
      string.format("Please install '%s' and ensure it is in your PATH.", name)
    })
  end
end

function M.check()
  vim.health.start("UnrealDev Dependencies")

  -- 1. External Tools (Required)
  check_executable("fd", "File finder")
  check_executable("rg", "Ripgrep text searcher")

  -- 2. Core Library (Required)
  check_plugin("UNL.nvim", "UNL", "Core Library & Utilities", true)

  -- 3. Core Features (Recommended)
  check_plugin("UEP.nvim", "UEP", "Project Analysis & Navigation", false)
  check_plugin("UNX.nvim", "UNX", "Explorer UI", false)

  -- 4. Optional Features
  check_plugin("UBT.nvim", "UBT", "Build Tool Integration", false)
  check_plugin("ULG.nvim", "ULG", "Log Viewer", false)
  check_plugin("UCM.nvim", "UCM", "Class Management", false)
  check_plugin("UEA.nvim", "UEA", "Asset Integration", false)
  check_plugin("USH.nvim", "USH", "UnrealShell Integration", false)
  check_plugin("UDB.nvim", "UDB", "Debugger Integration", false)
end

return M
