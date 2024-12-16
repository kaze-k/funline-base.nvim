local lazyStatus = require("lazy.status")
local possession = require("possession.session")
local nvim_lightbulb = require("nvim-lightbulb")
local plugins = require("lazy.core.config").plugins

local colors = require("theme.vanilla.colors")

local M = {}

local icons = {
  autosave_on = " ",
  autosave_off = " ",
  session = "",
}

M.autosave = function()
  local hl = { fg = "#50fa7b", bg = colors.bg, bold = true }
  local autoSave = vim.g.loaded_auto_save

  return {
    icon = autoSave and icons.autosave_on or icons.autosave_off,
    hl = hl,
  }
end

M.lazystatus = function()
  return {
    provider = lazyStatus.updates(),
    hl = { fg = "#f1fa8c", bg = colors.bg, bold = true },
  }
end

M.session = function()
  local session_name = possession.get_session_name()
  local condition = possession.get_session_name() ~= nil
  local icon = icons.session

  return {
    condition = condition,
    icon = icon,
    provider = session_name,
    hl = { fg = "#8be9fd", bg = colors.bg, bold = true },
  }
end

M.lightbulb = function()
  return {
    provider = nvim_lightbulb.get_status_text(),
    hl = { fg = "#8be9fd", bg = colors.bg, bold = true },
  }
end

local codeium_icons = {
  on = "󱙺 ",
  off = "󱙻 ",
  none = "󱚠 ",
  codeium = "󰘦",
}

local time = {
  init = 0,
  main = 100,
}

local spinners = { "◜", "◠", "◝", "◞", "◡", "◟" }
local index = 0
local last_time = vim.uv.now()
local last_spinner = nil
local function loading()
  local current_time = vim.uv.now()

  if current_time - last_time >= time.main then
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

M.codeium = function()
  local icon
  local provider
  local interval = time.init
  local status = plugins
      and plugins["codeium.vim"]
      and plugins["codeium.vim"]._.loaded
      and vim.fn["codeium#GetStatusString"]()
    or ""
  if status == string.match(status, "^%sON$") then
    icon = codeium_icons.on
    provider = ""
  elseif status == "OFF" then
    icon = codeium_icons.off
    provider = ""
  elseif status == string.match(status, "^%s%*%s$") then
    icon = loading()
    provider = ""
    interval = time.main
  elseif status == string.match(status, "^%s0%s$") then
    icon = codeium_icons.codeium
    provider = "0/0"
  elseif status == string.match(status, "^%s%s%s$") then
    icon = codeium_icons.none
    provider = ""
  else
    icon = codeium_icons.codeium
    provider = status
  end

  return {
    condition = plugins and plugins["codeium.vim"] and plugins["codeium.vim"]._.loaded,
    icon = icon,
    provider = provider,
    hl = { fg = "#09b6a2", bg = colors.bg, bold = true },
    interval = interval,
  }
end

return M
