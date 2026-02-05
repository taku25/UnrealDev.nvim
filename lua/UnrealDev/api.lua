local M = {}

--
-- UNL API (コアライブラリ・ライフサイクル管理)
--
local unl_ok, unl_api = pcall(require, "UNL.api")
if unl_ok then
  M.setup = unl_api.setup
  M.start_server = unl_api.start
  M.stop_server = unl_api.stop
  M.refresh = unl_api.refresh
  M.watch = unl_api.watch
  M.cleanup = unl_api.cleanup
  M.server_status = unl_api.server_status

  -- プロジェクト管理エイリアス (UEPから移動)
  M.start_project = unl_api.start
  M.stop_project = unl_api.stop
  M.cd = unl_api.cd
  M.delete = unl_api.delete

  M.get_progress_component = unl_api.get_progress_component
  M.find_project = unl_api.find_project
  M.find_module = unl_api.find_module
  M.find_engine = unl_api.find_engine
  M.find_insights = unl_api.find_insights
  M.kismet_command = unl_api.kismet_command
  M.is_process_running = unl_api.is_process_running
end

--
-- UBT API (pcall)
--
local ubt_ok, ubt_api = pcall(require, "UBT.api")
if ubt_ok then
  M.build = ubt_api.build
  M.gen_compile_db = ubt_api.gen_compile_db
  M.gen_header = ubt_api.gen_header
  M.gen_project = ubt_api.gen_project
  M.lint = ubt_api.lint
  M.diagnostics = ubt_api.diagnostics
  M.run = ubt_api.run
end

--
-- UEP API (Unreal Engine 編集支援)
--
local uep_ok, uep_api = pcall(require, "UEP.api")
if uep_ok then
  M.reload_config = uep_api.reload_config
  M.files = uep_api.files
  M.module_files = uep_api.module_files
  
  M.grep = uep_api.grep
  M.module_grep = uep_api.module_grep
  M.find_derived = uep_api.find_derived
  M.find_parents = uep_api.find_parents
  M.open_file = uep_api.open_file
  
  M.add_include = uep_api.add_include
  M.goto_definition = uep_api.goto_definition
  M.goto_impl = uep_api.goto_impl
  M.classes = uep_api.classes
  M.structs = uep_api.structs
  M.enums = uep_api.enums
  M.system_open_file = uep_api.system_open
  M.config_tree = uep_api.config_tree
  M.implement_virtual = uep_api.implement_virtual
  M.goto_super = uep_api.goto_super_def
  M.goto_super_def = uep_api.goto_super_def
  M.goto_super_impl = uep_api.goto_super_impl
  M.build_cs = uep_api.build_cs
  M.target_cs = uep_api.target_cs
  M.web_doc = uep_api.web_doc
  M.shader_files = uep_api.shader_files
  M.class_symbol = uep_api.class_symbol
  M.new_project = uep_api.new_project
  M.open_in_ide = uep_api.open_in_ide
end

--
-- ULG API (pcall)
--
local ulg_ok, ulg_api = pcall(require, "ULG.api")
if ulg_ok then
  M.start_log = ulg_api.start
  M.stop_log = ulg_api.stop
  M.close_log = ulg_api.close
  M.trace_log = ulg_api.trace
  M.crash_log = ulg_api.crash
  M.remote = ulg_api.remote
  M.remote_command = ulg_api.remote_command
end

--
-- USH (USL) API (pcall)
--
local ush_ok, ush_api = pcall(require, "USH.api")
if ush_ok then
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
end

--
-- UCM API (pcall)
--
local ucm_ok, ucm_api = pcall(require, "UCM.api")
if ucm_ok then
  M.new_file = ucm_api.new
  M.new_struct = ucm_api.new_struct
  M.new_class = ucm_api.new_class
  M.delete_class = ucm_api.delete_class
  M.rename_class = ucm_api.rename_class
  M.move_class = ucm_api.move_class
  M.create_decl = ucm_api.create_decl
  M.create_impl = ucm_api.create_impl
  M.switch_file = ucm_api.switch_file
  M.copy_include = ucm_api.copy_include
  M.specifiers = ucm_api.specifiers
  M.copy_implementation = ucm_api.copy_implementation
  M.symbols = ucm_api.symbols
end

--
-- UEA API (pcall)
--
local uea_ok, uea_api = pcall(require, "UEA.api")
if uea_ok then
  M.find_bp_usages = uea_api.find_bp_usages
  M.find_references = uea_api.find_references
  M.grep_string = uea_api.grep_string
  M.find_dependencies = uea_api.find_dependencies
  M.show_in_editor = uea_api.show_in_editor
  M.copy_reference = uea_api.copy_reference
  M.system_open_asset = uea_api.system_open
  M.find_bp_parent = uea_api.find_bp_parent
  M.refresh_lens = uea_api.refresh_lens
end

--
-- UNX API (Explorer / UI Hub)
--
local unx_ok, unx_api = pcall(require, "UNX.api")
if unx_ok then
  M.explorer_open = unx_api.explorer_open
  M.explorer_close = unx_api.explorer_close
  M.explorer_toggle = unx_api.explorer_toggle
  M.explorer_refresh = unx_api.explorer_refresh
  M.explorer_is_open = unx_api.explorer_is_open

  M.add_favorites = unx_api.add_favorites
  M.favorites_files = unx_api.favorites_files
  M.favorite_current = unx_api.favorite_current
  M.pending_files = unx_api.pending_files
  M.unpushed_files = unx_api.unpushed_files
end

--
-- UDB API (pcall)
--
local udb_ok, udb_api = pcall(require, "UDB.api")
if udb_ok then
  M.run_debug = udb_api.run_debug
end

return M