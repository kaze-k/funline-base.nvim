local plugins = require("lazy.core.config").plugins

local lazyStatus = require("lazy.status")
local possession = require("possession.session")
local nvim_lightbulb = require("nvim-lightbulb")

local colors = require("theme.vanilla.colors")

local M = {}

local icons = {
  autosave_on = " ",
  autosave_off = " ",
  session = "",
}

M.autosave = {
  icon = function()
    local autoSave = vim.g.loaded_auto_save

    if autoSave then
      return icons.autosave_on
    else
      return icons.autosave_off
    end
  end,
  hl = { fg = "#50fa7b", bg = colors.bg, bold = true },
}

M.lazystatus = {
  provider = function() return lazyStatus.updates() end,
  hl = { fg = "#f1fa8c", bg = colors.bg, bold = true },
}

M.session = {
  condition = function()
    local session_name = possession.get_session_name()
    if session_name then
      return true
    end
    return false
  end,
  icon = icons.session,
  provider = function()
    local session_name = possession.get_session_name()
    if session_name then
      return session_name
    end
  end,
  hl = { fg = "#8be9fd", bg = colors.bg, bold = true },
}

M.lightbulb = {
  provider = function() return nvim_lightbulb.get_status_text() end,
  hl = { fg = "#8be9fd", bg = colors.bg, bold = true },
}

local codeium_icons = {
  on = "󱙺 ",
  off = "󱙻 ",
  none = "󱚠 ",
  codeium = "󰘦",
}

local interval = {
  init = 0,
  main = 100,
}

local spinners = { "◜", "◠", "◝", "◞", "◡", "◟" }
local index = 0
local last_time = vim.uv.now()
local last_spinner = nil
local function loading()
  local current_time = vim.uv.now()

  if current_time - last_time >= interval.main then
    last_time = current_time
    index = index + 1
    if index > #spinners then
      index = 1
    end
    last_spinner = spinners[index]
    return spinners[index]
  end
  return last_spinner
end

M.codeium = {
  condition = function()
    if plugins and plugins["codeium.vim"] and plugins["codeium.vim"]._.loaded then
      return true
    end
    return false
  end,
  icon = function()
    local status = vim.fn["codeium#GetStatusString"]()
    if status == string.match(status, "^%sON$") then
      return codeium_icons.on
    elseif status == "OFF" then
      return codeium_icons.off
    elseif status == string.match(status, "^%s%*%s$") then
      return loading()
    elseif status == string.match(status, "^%s0%s$") then
      return codeium_icons.codeium
    elseif status == string.match(status, "^%s%s%s$") then
      return codeium_icons.none
    else
      return codeium_icons.codeium
    end
  end,
  provider = function()
    local status = vim.fn["codeium#GetStatusString"]()
    if status == string.match(status, "^%sON$") then
      return ""
    elseif status == "OFF" then
      return ""
    elseif status == string.match(status, "^%s%*%s$") then
      return ""
    elseif status == string.match(status, "^%s0%s$") then
      return "0/0"
    elseif status == string.match(status, "^%s%s%s$") then
      return ""
    else
      return status
    end
  end,
  hl = { fg = "#09b6a2", bg = colors.bg, bold = true },
  interval = function()
    local status = vim.fn["codeium#GetStatusString"]()
    if status == string.match(status, "^%s%*%s$") then
      return interval.main
    end
    return interval.init
  end,
}

return M
