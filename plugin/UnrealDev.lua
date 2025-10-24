-- plugin/UnrealDev.lua
-- (デフォルト値の処理を UBT.api 側に任せるバージョン)

local builder = require("UNL.command.builder")
local api = require("UnrealDev.api")

-- :UDEV コマンドの定義
builder.create({
  plugin_name = "UnrealDev",
  cmd_name = "UDEV",
  desc = "UDEV: Integrated commands for Unreal Engine development (UBT, UEP, UCM, ULG, USH)",

  subcommands = {
    --
    -- UBT Subcommands
    --
    ["build"] = {
      handler = function(opts) api.build(opts) end, -- (シンプルな呼び出しに戻す)
      desc = "UBT: Build a target. Use 'build!' to open a UI picker.",
      bang = true,
      args = {
        { name = "label", required = false }, -- (default を削除)
      },
    },
    ["gencompiledb"] = {
      handler = function(opts) api.gen_compile_db(opts) end, -- (シンプルな呼び出しに戻す)
      desc = "UBT: Generate compile_commands.json. Use 'gencompiledb!' to open a UI picker.",
      bang = true,
      args = {
        { name = "label", required = false }, -- (default を削除)
      },
    },
    ["genheader"] = {
      handler = function(opts) api.gen_header(opts) end, -- (シンプルな呼び出しに戻す)
      desc = "UBT: Generate headers (UHT). Use 'genheader!' to open a UI picker.",
      bang = true,
      args = {
        { name = "label", required = false }, -- (default を削除)
        { name = "module_name", required = false },
      },
    },
    ["genproject"] = {
      handler = function(opts) api.gen_project(opts) end,
      desc = "UBT: Generate project files.",
      args = {},
    },
    ["lint"] = {
      handler = function(opts) api.lint(opts) end, -- (シンプルな呼び出しに戻す)
      desc = "UBT: Run static analyzer for a target.",
      args = {
        { name = "label", required = false }, -- (default を削除)
        { name = "lintType", required = false }, -- (default を削除)
      },
    },
    ["diagnostics"] = {
      handler = function(opts) api.diagnostics(opts) end,
      desc = "UBT: Show build diagnostics from the last run.",
      args = {},
    },
    ["run"] = {
      handler = function(opts) api.run(opts) end,
      desc = "UBT: Run the project. Default: Editor (-game). Use --standalone to run the binary.",
      bang = true,
      args = {
        { name = "standalone_flag", required = false },
      },
    },

    --
    -- UEP Subcommands (変更なし)
    --
    ["refresh"] = {
      handler = api.refresh,
      bang = true,
      desc = "UEP: Refresh [Game|Engine]",
      args = {
        { name = "type", required = false },
        { name = "force", required = false },
      },
    },
    ["reloadconfig"] = {
      handler = api.reload_config,
      desc = "UEP: Reload the configuration files.",
      args = {},
    },
    ["cd"] = {
      handler = api.cd,
      desc = "UEP: Select a known project and cd to it.",
      args = {},
    },
    ["project_delete"] = {
      handler = api.delete,
      desc = "UEP: Select a project to remove it from the known projects list.",
      args = {},
    },
    ["files"] = {
      handler = api.files,
      bang = true,
      desc = "UEP: Find files [Category] [--no-deps]",
      args = {
        { name = "category", required = false },
        { name = "deps_flag", required = false },
      },
    },
    ["module_files"] = {
      handler = api.module_files,
      bang = true,
      desc = "UEP: Find all files for a specific module.",
      args = {
        { name = "module_name", required = false },
        { name = "dummy_arg", required = false },
      },
    },
    ["tree"] = {
      handler = api.tree,
      desc = "UEP: Open a project-aware filer (neo-tree/nvim-tree)",
      args = {
        { name = "deps_flag", required = false },
      },
    },
    ["module_tree"] = {
      handler = api.module_tree,
      desc = "UEP: Open a project-aware filer (neo-tree/nvim-tree)",
      args = {
        { name = "module_name", required = false },
        { name = "deps_flag", required = false },
      },
    },
    ["grep"] = {
      handler = api.grep,
      bang = true,
      desc = "UEP: Grep [game|engine]",
      args = {
        { name = "category", required = false },
      },
    },
    ["module_grep"] = {
      handler = api.module_grep,
      bang = true,
      desc = "UEP: Grep a specific module {module_name}",
      args = {
        { name = "module_name", required = false },
      },
    },
    ["program_files"] = {
      handler = api.program_files,
      desc = "UEP: Find all files in Programs directories.",
      args = {},
    },
    ["program_grep"] = {
      handler = api.program_grep,
      desc = "UEP: Live grep within all Programs directories.",
      args = {},
    },
    ["find_derived"] = {
      handler = api.find_derived,
      bang = true,
      desc = "UEP: Find all derived classes of a specified base class.",
      args = {
        { name = "class_name", required = false },
      },
    },
    ["find_parents"] = {
      handler = api.find_parents,
      bang = true,
      desc = "UEP: Find the inheritance chain of a specified class.",
      args = {
        { name = "class_name", required = false },
      },
    },
    ["open_file"] = {
      handler = api.open_file,
      desc = "UEP: Open an include file by searching the project cache.",
      args = {
        { name = "path", required = false },
      },
    },
    ["purge"] = {
      handler = api.purge,
      desc = "UEP: Purge the file cache for a specified component (Game/Engine/Plugin).",
      args = {
        { name = "component_name", required = false },
      },
    },
    ["cleanup"] = {
      handler = api.cleanup,
      desc = "UEP: Delete all structural and file caches for the current project.",
      args = {},
    },
    ["add_include"] = {
      handler = api.add_include,
      bang = true,
      desc = "UEP: Finds and inserts the #include directive for the specified class.",
      args = {
        { name = "class_name", required = false },
      },
    },
    ["goto_definition"] = {
      handler = api.goto_definition,
      bang = true,
      desc = "UEP: Jump to true definition (skips forward declarations). Use `!` for class picker.",
      args = {
        { name = "class_name", required = false },
      },
    },

    ["new"] = {
      handler = function(opts) api.new_class(opts) end,
      desc = "UCM: Create a new class, interactively if args are omitted.",
      args = {
        { name = "class_name", required = false },
        { name = "parent_class", required = false },
        { name = "target_dir", required = false },
      },
    },
    ["class_delete"] = {
      handler = function(opts) api.delete_class(opts) end,
      desc = "UCM: Delete a class, interactively if file path is omitted.",
      args = {
        { name = "file_path", required = false },
      },
    },
    ["move"] = {
      handler = function(opts) api.move_class(opts) end,
      desc = "UCM: Move a class, interactively if file path is omitted.",
      args = {
        { name = "file_path ", required = false },
        { name = "target_dir ", required = false },
      },
    },
    ["rename"] = {
      handler = function(opts) api.rename_class(opts) end,
      desc = "UCM: Rename a class, interactively if args are omitted.",
      args = {
        { name = "file_path", required = false },
        { name = "new_class_name", required = false },
      },
    },
    ["switch"] = {
      handler = function()
        local current_file = vim.api.nvim_buf_get_name(0)
        if current_file and current_file ~= "" then
          api.switch_file({ current_file_path = current_file })
        else
          require("UCM.logger").get().warn("No file open in current buffer to switch.")
        end
      end,
      desc = "UCM: Switch between header and source file.",
      args = {},
    },

    --
    -- ULG Subcommands (変更なし)
    --
    ["start_log"] = {
      handler = function(opts) api.start_log(opts) end,
      desc = "ULG: Start tailing a log file. Use 'start_log!' to pick a file.",
      bang = true,
      args = {},
    },
    ["stop_log"] = {
      handler = function() api.stop_log() end,
      desc = "ULG: Stop tailing log files, but keep windows open.",
      args = {},
    },
    ["close_log"] = {
      handler = function() api.close_log() end,
      desc = "ULG: Stop tailing and close all log viewer windows.",
      args = {},
    },
    ["trace_log"] = {
      handler = function(opts) api.trace_log(opts) end,
      desc = "ULG: Analyze a .utrace file. Use 'trace_log!' to open the file picker.",
      bang = true,
      args = {},
    },
    ["crash_log"] = {
      handler = function() api.crash_log() end,
      desc = "ULG: Select and open a crash log file.",
      args = {},
    },
    ["remote"] = {
      handler = function() api.remote() end,
      desc = "ULG: Remote Prompt to Unreal.",
      args = {},
    },
    ["remote_command"] = {
      handler = function(opts) api.remote_command(opts.command) end,
      desc = "ULG: Send a remote command.",
      args = {
        { name = "command", required = true },
      },
    },

    --
    -- USH (UShell) Subcommands (変更なし)
    --
    ["start_session"] = {
      handler = function(opts) api.start_session(opts) end,
      desc = "USH: Start UnrealShell session.",
      args = {},
    },
    ["stop_session"] = {
      handler = function() api.stop_session() end,
      desc = "USH: Stop UnrealShell session.",
      args = {},
    },
    ["ushell_build"] = {
      handler = function(opts) api.ushell_build(opts) end,
      desc = "USH: Run Build command via UnrealShell.",
      args = {},
    },
    ["ushell_cook"] = {
      handler = function(opts) api.ushell_cook(opts) end,
      desc = "USH: Run Cook command via UnrealShell.",
      args = {},
    },
    ["ushell_run"] = {
      handler = function(opts) api.ushell_run(opts) end,
      desc = "USH: Run Run command via UnrealShell.",
      args = {},
    },
    ["sln"] = {
      handler = function(opts) api.sln(opts) end,
      desc = "USH: Open SLN via UnrealShell.",
      args = {},
    },
    ["uat"] = {
      handler = function(opts) api.uat(opts) end,
      desc = "USH: Run UAT command via UnrealShell.",
      args = {},
    },
    ["stage"] = {
      handler = function(opts) api.stage(opts) end,
      desc = "USH: Run Stage command via UnrealShell.",
      args = {},
    },
    ["p4"] = {
      handler = function(opts) api.p4(opts) end,
      desc = "USH: Run P4 command via UnrealShell.",
      args = {},
    },
    ["direct"] = {
      handler = function(opts) api.direct(opts) end,
      desc = "USH: Run a direct command via UnrealShell.",
      args = {},
    },
  }
})

