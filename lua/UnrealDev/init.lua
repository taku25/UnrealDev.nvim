-- From: C:\Users\taku3\Documents\git\UnrealDev.nvim\lua\UnrealDev\init.lua

local unl_log = require("UNL.logging")
local config_defaults = require("UnrealDev.config.defaults")

local M = {}

local setup_done = false

function M.setup(user_opts)
  if setup_done then return end

  -- 1. デフォルト設定とユーザー設定をマージ
  -- (元々の defaults.lua を変更しないよう deepcopy を使用)

  unl_log.setup("UnrealDev", config_defaults, user_opts or {})
  local log = unl_log.get("UnrealDev")
  
  if log then
    log.debug("UnrealDev.nvim setup starting...")
  end

  local config = vim.deepcopy(config_defaults)
  config = vim.tbl_deep_extend("force", config, user_opts or {})

  if config.setup_modules then
    for module_name, should_setup in pairs(config.setup_modules) do
      if should_setup then
        local ok, plugin = pcall(require, module_name)
        
        if ok then
          if plugin.setup then
            if log then
              log.debug("Setting up " .. module_name .. ".nvim...")
            end
            pcall(plugin.setup, config)
          else
            if log then
              log.warn("Module " .. module_name .. " loaded, but no .setup() function found.")
            end
          end
        else
          if log then
            log.warn("Failed to require module: " .. module_name .. " (from setup_modules)")
          end
        end
      else
        if log then
          log.debug("Skipping setup for " .. module_name .. ".nvim (disabled in config).")
        end
      end
    end
  end

  if log then
    log.debug("UnrealDev.nvim setup complete.")
  end

  setup_done = true
end

return M
