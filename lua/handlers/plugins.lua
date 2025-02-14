local plugins = require("lazy.core.config").plugins

local M = {}

local function plugin_exists(plugin)
  if plugins and plugins[plugin] and plugins[plugin]._.loaded then
    return true
  end
  return false
end

function M.session_exists() return plugin_exists("possession.nvim") and M.get_session_name() end

function M.get_session_name() return require("possession.session").get_session_name() end

function M.lightbulb_exists() return plugin_exists("nvim-lightbulb") and M.get_lightbulb() end

function M.get_lightbulb() return require("nvim-lightbulb").get_status_text() end

function M.autosave_exists() return plugin_exists("auto-save.nvim") end

function M.get_autosave() return vim.g.loaded_auto_save end

function M.lazy_exists()
  if package.loaded["lazy"] then
    return true
  end
  return false
end

function M.get_lazy_updates() return require("lazy.status").updates() end

function M.codeium_exists() return plugin_exists("codeium.vim") end

function M.get_codeium_status()
  local status = vim.fn["codeium#GetStatusString"]()
  if status == string.match(status, "^%sON$") then
    return "ON"
  elseif status == "OFF" then
    return "OFF"
  elseif status == string.match(status, "^%s%*%s$") then
    return "LOADING"
  elseif status == string.match(status, "^%s0%s$") then
    return "0/0"
  elseif status == string.match(status, "^%s%s%s$") then
    return "NONE"
  else
    return "UNKNOWN"
  end
end

return M
