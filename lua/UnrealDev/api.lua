-- lua/UnrealDev/api.lua (UCM.api を require する形)

-- 各プラグインのAPIを require
local unl_api = require("UNL.api")
local ubt_api = require("UBT.api")
local uep_api = require("UEP.api")
local ulg_api = require("ULG.api")
local ush_api = require("USH.api")
local ucm_api = require("UCM.api") -- ★ UCM.api を追加

local M = {}

--
-- UNL API
--


M.get_progress_component = unl_api.get_progress_component
M.find_project = unl_api.find_project
M.find_module = unl_api.find_module
M.find_engine = unl_api.find_engine
M.find_insights = unl_api.find_insights
M.kismet_command = unl_api.kismet_command
M.is_process_running = unl_api.is_process_running

--
-- UBT API
--
M.build = ubt_api.build
M.gen_compile_db = ubt_api.gen_compile_db
M.gen_header = ubt_api.gen_header
M.gen_project = ubt_api.gen_project
M.lint = ubt_api.lint
M.diagnostics = ubt_api.diagnostics
M.run = ubt_api.run

--
-- UEP API
--
M.refresh = uep_api.refresh
M.reload_config = uep_api.reload_config
M.cd = uep_api.cd
M.delete = uep_api.delete
M.files = uep_api.files
M.module_files = uep_api.module_files
M.tree = uep_api.tree
M.module_tree = uep_api.module_tree
M.grep = uep_api.grep
M.module_grep = uep_api.module_grep
M.program_files = uep_api.program_files
M.program_grep = uep_api.program_grep
M.find_derived = uep_api.find_derived
M.find_parents = uep_api.find_parents
M.open_file = uep_api.open_file
M.purge = uep_api.purge
M.cleanup = uep_api.cleanup
M.add_include = uep_api.add_include

--
-- ULG API
--
M.start_log = ulg_api.start
M.stop_log = ulg_api.stop
M.close_log = ulg_api.close
M.trace_log = ulg_api.trace
M.crash_log = ulg_api.crash
M.remote = ulg_api.remote
M.remote_command = ulg_api.remote_command

--
-- USH (USL) API
--
M.start_session = ush_api.start_session
M.stop_session = ush_api.stop_session
M.ushell_build = ush_api.build
M.ushell_cook = ush_api.cook
M.ushell_run = ush_api.run
M.sln = ush_api.sln
M.uat = ush_api.uat
M.stage = ush_api.stage
M.p4 = ush_api.p4
M.direct = ush_api.direct

--
-- UCM API
--
M.new_class = ucm_api.new_class
M.delete_class = ucm_api.delete_class
M.rename_class = ucm_api.rename_class
M.move_class = ucm_api.move_class
M.switch_file = ucm_api.switch_file

return M
