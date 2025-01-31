local plugins = require("lazy.core.config").plugins
local lazyStatus = require("lazy.status")

local colors = require("themes.vanilla.colors")
local utils = require("funline-base.utils")

local M = {}

local icons = {
  autosave_on = " ",
  autosave_off = " ",
  session = "",
}

M.autosave = function()
  local hl = { fg = colors.light_cyan, bg = utils.get_hl("StatusLine").bg }
  local autoSave = vim.g.loaded_auto_save

  return {
    condition = plugins and plugins["auto-save.nvim"] and plugins["auto-save.nvim"]._.loaded,
    icon = autoSave and icons.autosave_on or icons.autosave_off,
    padding_left = " ",
    hl = hl,
  }
end

M.lazystatus = function()
  return {
    condition = lazyStatus.updates(),
    provider = lazyStatus.updates(),
    padding_left = " ",
    hl = { fg = colors.yellow, bg = utils.get_hl("StatusLine").bg },
  }
end

M.session = function()
  local possession_ok, possession = pcall(require, "possession.session")

  local session_name = possession_ok and possession.get_session_name()
  local condition = plugins
    and plugins["possession.nvim"]
    and plugins["possession.nvim"]._.loaded
    and possession_ok
    and possession.get_session_name() ~= nil
  local icon = icons.session

  return {
    condition = condition,
    icon = icon,
    provider = session_name,
    padding_right = " ",
    hl = { fg = colors.blue, bg = utils.get_hl("StatusLine").bg },
  }
end

M.lightbulb = function()
  local nvim_lightbulb_ok, nvim_lightbulb = pcall(require, "nvim-lightbulb")

  return {
    condition = plugins and plugins["nvim-lightbulb"] and plugins["nvim-lightbulb"]._.loaded and nvim_lightbulb_ok,
    provider = nvim_lightbulb_ok and nvim_lightbulb.get_status_text(),
    hl = { fg = colors.blue, bg = utils.get_hl("StatusLine").bg },
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

local loading = utils.get_loading(time.main)

M.codeium = function(ctx)
  local icon
  local provider
  local status = plugins
      and plugins["codeium.vim"]
      and plugins["codeium.vim"]._.loaded
      and vim.fn["codeium#GetStatusString"]()
    or ""

  if status == string.match(status, "^%s%*%s$") then
    ctx.refresh(time.main)
  else
    ctx.done()
  end

  if status == string.match(status, "^%sON$") then
    icon = codeium_icons.on
    provider = ""
  elseif status == "OFF" then
    icon = codeium_icons.off
    provider = ""
  elseif status == string.match(status, "^%s%*%s$") then
    icon = loading()
    provider = ""
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
    padding_left = " ",
    hl = { fg = colors.turquoise, bg = utils.get_hl("StatusLine").bg },
  }
end

return M
