-- plugin/UnrealDev.lua (Role Clarification Cleanup)

local builder = require("UNL.command.builder")
local api = require("UnrealDev.api")

-- :UDEV コマンドの定義
builder.create({
  plugin_name = "UnrealDev",
  cmd_name = "UDEV",
  desc = "UDEV: Integrated commands for Unreal Engine development (UNL, UBT, UEP, UCM, ULG, USH, UEA, UNX)",

  subcommands = {
    --
    -- UNL Subcommands (コア管理)
    --
    ["setup"] = {
      handler = api.setup,
      desc = "UNL: Setup project environment.",
      args = {},
    },
    ["start"] = {
      handler = api.start_server,
      desc = "UNL: Start RPC server.",
      args = {},
    },
    ["stop"] = {
      handler = api.stop_server,
      desc = "UNL: Stop RPC server.",
      args = {},
    },
    ["refresh"] = {
      handler = api.refresh,
      bang = true,
      desc = "UNL: Refresh project database. Use '!' for full scan.",
      args = {
        { name = "type", required = false },
      },
    },
    ["watch"] = {
      handler = api.watch,
      desc = "UNL: Start file watcher.",
      args = {},
    },
    ["cleanup"] = {
      handler = api.cleanup,
      desc = "UNL: Delete ALL project database records.",
      args = {},
    },
    ["status"] = {
      handler = api.server_status,
      desc = "UNL: Show server and project status.",
      args = {},
    },

    --
    -- UBT Subcommands
    --
    ["build"] = {
      handler = function(opts) api.build(opts) end,
      desc = "UBT: Build a target. Use 'build!' to open a UI picker.",
      bang = true,
      args = { { name = "label", required = false } },
    },
    ["gen_project"] = {
      handler = function(opts) api.gen_project(opts) end,
      desc = "UBT: Generate project files.",
      args = {},
    },
    ["run"] = {
      handler = function(opts) api.run(opts) end,
      desc = "UBT: Run the project. Default: Editor. Use --standalone to run the binary.",
      bang = true,
      args = { { name = "standalone_flag", required = false } },
    },
    ["diagnostics"] = {
      handler = function(opts) api.diagnostics(opts) end,
      desc = "UBT: Show build diagnostics from the last run.",
      args = {},
    },

    --
    -- UEP Subcommands (Unreal Engine 編集支援)
    --
    ["files"] = {
      handler = api.files,
      bang = true,
      desc = "UEP: Find files [Scope] [Mode] [DepsFlag]",
      args = { { name = "scope", required = false }, { name = "mode", required = false }, { name = "deps_flag", required = false } },
    },
    ["module_files"] = {
      handler = api.module_files,
      bang = true,
      desc = "UEP: Find all files for a specific module.",
      args = { { name = "module_name", required = false } },
    },
    ["grep"] = {
      handler = api.grep,
      bang = true,
      desc = "UEP: Grep [Scope] [Mode] [DepsFlag]",
      args = { { name = "scope", required = false }, { name = "mode", required = false }, { name = "deps_flag", required = false } },
    },
    ["add_include"] = {
      handler = api.add_include,
      bang = true,
      desc = "UEP: Finds and inserts the #include directive for the specified class.",
      args = { { name = "class_name", required = false } },
    },
    ["goto_definition"] = {
      handler = api.goto_definition,
      bang = true,
      desc = "UEP: Jump to true definition (skips forward declarations). Use `!` for class picker.",
      args = { { name = "class_name", required = false } },
    },
    ["goto_impl"] = {
      handler = api.goto_impl,
      desc = "UEP: Jump between declaration and implementation.",
      args = {},
    },
    ["classes"] = {
      handler = api.classes,
      bang = true,
      desc = "UEP: Find and jump to a class definition by name.",
      args = {},
    },
    ["structs"] = {
      handler = api.structs,
      bang = true,
      desc = "UEP: Find and jump to a struct definition.",
      args = {},
    },
    ["enums"] = {
      handler = api.enums,
      bang = true,
      desc = "UEP: Find and jump to a enum definition.",
      args = {},
    },
    ["system_open_file"] = {
      handler = function(opts) api.system_open_file(opts) end,
      bang = true,
      desc = "UEP: Open a file in system explorer. Use '!' to pick.",
      args = { { name = "path", required = false } },
    },
    ["implement_virtual"] = {
      handler = api.implement_virtual,
      desc = "UEP: Override a virtual function from the parent class.",
      args = { { name = "class_name", required = false } },
    },
    ["goto_super_def"] = {
      handler = api.goto_super_def,
      desc = "UEP: Jump to the parent class definition.",
      args = {},
    },
    ["build_cs"] = {
      handler = api.build_cs,
      bang = true,
      desc = "UEP: Open Build.cs. Use '!' to list all.",
      args = {},
    },
    ["target_cs"] = {
      handler = api.target_cs,
      bang = true,
      desc = "UEP: Open Target.cs. Use '!' to include Engine targets.",
      args = {},
    },
    ["new_project"] = {
      handler = api.new_project,
      desc = "UEP: Create a new Unreal Engine project from a template.",
      args = {},
    },

    --
    -- UCM Subcommands (Class Manager)
    --
    ["new_class"] = {
      handler = function(opts) api.new_class(opts) end,
      desc = "UCM: Create a new class, interactively if args are omitted.",
      args = { { name = "class_name", required = false }, { name = "parent_class", required = false } },
    },
    ["new_struct"] = {
      handler = function(opts) api.new_struct(opts) end,
      desc = "UCM: Create a new struct, interactively if args are omitted.",
      args = { { name = "struct_name", required = false }, { name = "parent_struct", required = false } },
    },
    ["switch"] = {
      handler = function() local f = vim.api.nvim_buf_get_name(0); if f ~= "" then api.switch_file({ current_file_path = f }) end end,
      desc = "UCM: Switch between header and source file.",
      args = {},
    },
    ["copy_include"] = {
      handler = api.copy_include,
      bang = true,
      desc = "UCM: Copy #include path for current file or selected class.",
      args = { { name = "file_path", required = false } },
    },

    --
    -- ULG Subcommands (Logging)
    --
    ["start_log"] = {
      handler = function(opts) api.start_log(opts) end,
      desc = "ULG: Start tailing a log file. Use 'start_log!' to pick a file.",
      bang = true,
      args = {},
    },
    ["trace_log"] = {
      handler = function(opts) api.trace_log(opts) end,
      desc = "ULG: Analyze a .utrace file. Use 'trace_log!' to open the file picker.",
      bang = true,
      args = {},
    },

    --
    -- USH (UnrealShell) Subcommands
    --
    ["ushell_build"] = {
      handler = function(opts) api.ushell_build(opts) end,
      desc = "USH: Run Build command via UnrealShell.",
      args = {},
    },
    ["ushell_run"] = {
      handler = function(opts) api.ushell_run(opts) end,
      desc = "USH: Run Run command via UnrealShell.",
      args = {},
    },

    --
    -- UEA (Asset Tools) Subcommands
    --
    ["find_bp_usages"] = {
      handler = function(opts) api.find_bp_usages(opts) end,
      bang = true,
      desc = "UEA: Find Blueprint usages of a C++ class. Use '!' for class picker.",
      args = { { name = "class_name", required = false } },
    },
    ["show_in_editor"] = {
      handler = function(opts) api.show_in_editor(opts) end,
      bang = true,
      desc = "UEA: Sync Unreal Editor Content Browser to asset. Use '!' to pick.",
      args = { { name = "asset_path", required = false } },
    },

    --
    -- UNX (Explorer) Subcommands
    --
    ["explorer_open"] = {
      handler = function() api.explorer_open() end,
      desc = "UNX: Open the explorer window.",
      args = {},
    },
    ["explorer_toggle"] = {
      handler = function() api.explorer_toggle() end,
      desc = "UNX: Toggle the explorer window.",
      args = {},
    },
    ["explorer_refresh"] = {
      handler = function() api.explorer_refresh() end,
      desc = "UNX: Refresh the explorer tree.",
      args = {},
    },
    ["favorite_current"] = {
      handler = api.favorite_current,
      desc = "UNX: Toggle the current buffer in Favorites.",
      args = {},
    },
  }
})