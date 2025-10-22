local unl_log = require("UNL.logging")
local config_defaults = require("UnrealDev.config.defaults")

local M = {}

local setup_done = false

function M.setup(user_opts)
  if setup_done then return end

  unl_log.setup("UnrealDev", config_defaults, user_opts or {})
  local log = unl_log.get("UnrealDev")
  
  if log then
    log.debug("UnrealDev.nvim setup complete.")
  end

  setup_done = true
end

return M
