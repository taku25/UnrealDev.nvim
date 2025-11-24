local M = {

  -- 各サブモジュールの setup() を呼び出すかどうかを制御します
  setup_modules = {
    UBT = true,
    UEP = true,
    ULG = true,
    USH = true,
    UCM = true,
    UEA = true,
    UNX = true,
    UDB = true,
  },
  
  logging = {
    level = "off",
    echo = { level = "off" },
    notify = { level = "off" },
    file = { enable = true, filename = "udev.log" },
  },
  
  ui = {
    picker = {
      mode = "auto",
      prefer = { "telescope", "fzf-lua", "native" },
    },
    progress = {
      mode = "auto",
      prefer = { "fidget", "generic_status", "window" },
    }
  },
  cache = { dirname = "UnrealDev" },

  engine_path = nil,

  presets = {
    { name = "Win64DebugGame", Platform = "Win64", IsEditor = false, Configuration = "DebugGame" },
    { name = "Win64Develop", Platform = "Win64", IsEditor = false, Configuration = "Development" },
    { name = "Win64Shipping", Platform = "Win64", IsEditor = false, Configuration = "Shipping" },
    { name = "Win64DebugGameWithEditor", Platform = "Win64", IsEditor = true, Configuration = "DebugGame" },
    { name = "Win64DevelopWithEditor", Platform = "Win64", IsEditor = true, Configuration = "Development" },
  },
  preset_target = "Win64DevelopWithEditor",

  cook_presets = {
    { name = "Cook Game (Win64)", platform = "win64", type = "game", options = "" },
    { name = "Cook Game OnTheFly (Win64)", platform = "win64", type = "game", options = "--onthefly" },
    { name = "Cook Client (Win64)", platform = "win64", type = "client", options = "" },
  }, 
  run_presets = {
    { name = "Run Editor", mode = "editor", args = "" },
    { name = "Run Game", mode = "game", args = "" },
    { name = "Run Game (Debug)", mode = "game", args = "--attach" },
    { name = "Run Server", mode = "server", args = "" },
    { name = "Run Client", mode = "client", args = "" },
    { name = "Run Program (UnrealInsights)", mode = "program", args = "UnrealInsights" },
  },
  uat_presets = {
   {
      name = "Build, Cook, and Archive (Win64)",
      command_string = "BuildAndCook -platform=Win64 -clientconfig=Development -serverconfig=Development -cook -allmaps -build -stage -pak -archive",
    },
    {
      name = "BuildGraph (Editor Performance)",
      command_string = "BuildGraph -- -Script=Engine/Build/EditorPerf.xml",
    },
  },
  stage_presets = {
    {
      name = "Stage Game (Win64)",
      args = "game win64",
    },
    -- プロジェクトでよく使う他のステージングコマンドをここに追加
  },

  p4_subcommands = {
    -- Commands without arguments
    { name = "sync",         desc = "Syncs the current project and engine.",        arg_required = false },
    { name = "clean",        desc = "Cleans intermediate files from the branch.",   arg_required = false },
    { name = "mergedown",    desc = "Merges down from the parent stream.",          arg_required = false },
    { name = "reset",        desc = "Adjusts the branch to match the depot.",       arg_required = false },
    { name = "v",            desc = "Opens the client spec in P4V.",                 arg_required = false },
    { name = "sync edit",    desc = "Opens .p4sync.txt in an editor.",              arg_required = false },
    { name = "sync mini",    desc = "Syncs the branch with minimal functionality.", arg_required = false },
    { name = "switch",       desc = "Switches between streams.",                    arg_required = false },
    { name = "switch list",  desc = "Displays a tree of available streams.",        arg_required = false },

    -- Commands with arguments
    { name = "authors",    desc = "Lists editors based on the specified path.",   arg_required = true, arg_prompt = "Enter file path:" },
    { name = "bisect",     desc = "Bisects changelists within a range.",            arg_required = true, arg_prompt = "Enter GoodCL, BadCL, and optional script:" },
    { name = "cherrypick", desc = "Integrates or reverts a changelist.",          arg_required = true, arg_prompt = "Enter Changelist number(s):" },
    { name = "workspace",  desc = "Creates a new workspace.",                       arg_required = true, arg_prompt = "Enter args (e.g., 'localdir [DepotPath]'):" },
    { name = "who",        desc = "Identifies the editor of a target file/line.",  arg_required = true, arg_prompt = "Enter file path and optional line number:" },
  },
}

return M
