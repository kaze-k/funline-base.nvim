local plugins = require("lazy.core.config").plugins

local M = {}

function M.is_plugin_exists(plugin)
  if plugins and plugins[plugin] and plugins[plugin]._.loaded then
    return true
  end
  return false
end

function M.is_lazy_exists() return package.loaded["lazy"] and require("lazy.status").has_updates() end

function M.get_lazy_updates() return require("lazy.status").updates() end

function M.is_session_exists() return M.is_plugin_exists("possession.nvim") and M.get_session_name() ~= nil end

function M.get_session_name() return require("possession.session").get_session_name() end

function M.is_lightbulb_exists() return M.is_plugin_exists("nvim-lightbulb") and M.get_lightbulb_status() ~= nil end

function M.get_lightbulb_status() return require("nvim-lightbulb").get_status_text() end

function M.is_autosave_exists() return M.is_plugin_exists("auto-save.nvim") end

function M.get_autosave_status() return vim.g.loaded_auto_save end

function M.is_windsurf_exists() return M.is_plugin_exists("windsurf.vim") end

function M.get_windsurf_status()
  if M.is_windsurf_exists() then
    local status = vim.fn["codeium#GetStatusString"]()
    if status == string.match(status, "^%sON$") then
      return "ON", ""
    elseif status == "OFF" then
      return "OFF", ""
    elseif status == string.match(status, "^%s%*%s$") then
      return "LOADING", ""
    elseif status == string.match(status, "^%s0%s$") then
      return "EMPTY", "0/0"
    elseif status == string.match(status, "^%s%s%s$") then
      return "NONE", ""
    else
      return "NORMAL", status
    end
  end
end

return M
