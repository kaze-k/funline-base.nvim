local providers = require("helper.providers")
local utils = require("helper.utils")

local colors = require("themes.arc.colors")

local M = {}

local padding = { right = " " }

local mode_icon = {
  ["n"] = "",
  ["niI"] = "",
  ["niR"] = "",
  ["niV"] = "",
  ["no"] = "",
  ["nov"] = "",
  ["noV"] = "",
  ["no"] = "",
  ["v"] = "",
  ["vs"] = "",
  ["V"] = "",
  ["Vs"] = "",
  [""] = "",
  ["s"] = "",
  ["s"] = "",
  ["S"] = "",
  [""] = "",
  ["i"] = "󰛿",
  ["ic"] = "󰛿",
  ["ix"] = "󰛿",
  ["R"] = "󰬲",
  ["Rc"] = "󰬲",
  ["Rv"] = "󰬲",
  ["Rx"] = "󰬲",
  ["c"] = "󰊠",
  ["cv"] = "󰊠",
  ["ce"] = "󰊠",
  ["r"] = "",
  ["rm"] = "",
  ["r?"] = "",
  ["!"] = "",
  ["t"] = "",
  ["nt"] = "",
  ["null"] = "󰟢",
}

local mode = {
  ["n"] = "NORMAL",
  ["niI"] = "NORMAL",
  ["niR"] = "NORMAL",
  ["niV"] = "NORMAL",
  ["no"] = "OP",
  ["nov"] = "OP",
  ["noV"] = "OP",
  ["no"] = "OP",
  ["v"] = "VISUAL",
  ["vs"] = "VISUAL",
  ["V"] = "LINES",
  ["Vs"] = "LINES",
  [""] = "BLOCK",
  ["s"] = "BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT",
  [""] = "BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["Rx"] = "REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "COMMAND",
  ["ce"] = "COMMAND",
  ["r"] = "ENTER",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERM",
  ["nt"] = "N-TERM",
  ["null"] = "NONE",
}

M.mode = function()
  return {
    icon = mode_icon[vim.fn.mode()],
    provider = mode[vim.fn.mode()],
    padding = padding,
    hl = { fg = colors.mode_colors[vim.fn.mode()], bg = utils.get_hl("StatusLine").bg, bold = true, italic = true },
  }
end

M.macro = function()
  local recording = providers.get_reg_recording()
  local executing = providers.get_reg_executing()

  return {
    condition = recording ~= "" or executing ~= "",
    icon = "",
    provider = recording ~= "" and recording or executing,
    padding = padding,
    hl = {
      fg = executing ~= "" and colors.light_green or colors.light_red,
      bg = utils.get_hl("StatusLine").bg,
      bold = true,
    },
  }
end

M.gitbranch = function()
  return {
    condition = not utils.buffer_is_empty()
      and not utils.buftype_is_nofile()
      and vim.b.gitsigns_status_dict ~= nil
      and vim.b.gitsigns_status_dict.head ~= nil,
    icon = "",
    provider = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.head or vim.b.gitsigns_head,
    padding = padding,
    hl = { fg = colors.green, bg = utils.get_hl("StatusLine").bg },
  }
end

M.gitadd = function()
  return {
    condition = not utils.buffer_is_empty()
      and not utils.buftype_is_nofile()
      and vim.b.gitsigns_status_dict ~= nil
      and vim.b.gitsigns_status_dict.added ~= nil
      and vim.b.gitsigns_status_dict.added > 0,
    icon = "",
    provider = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.added,
    padding = padding,
    hl = { fg = colors.light_green, bg = utils.get_hl("StatusLine").bg },
  }
end

M.gitchange = function()
  return {
    condition = not utils.buffer_is_empty()
      and not utils.buftype_is_nofile()
      and vim.b.gitsigns_status_dict ~= nil
      and vim.b.gitsigns_status_dict.changed ~= nil
      and vim.b.gitsigns_status_dict.changed > 0,
    icon = "",
    provider = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.changed,
    padding = padding,
    hl = { fg = colors.orange, bg = utils.get_hl("StatusLine").bg },
  }
end

M.gitremove = function()
  return {
    condition = not utils.buffer_is_empty()
      and not utils.buftype_is_nofile()
      and vim.b.gitsigns_status_dict ~= nil
      and vim.b.gitsigns_status_dict.removed ~= nil
      and vim.b.gitsigns_status_dict.removed > 0,
    icon = "",
    provider = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.removed,
    padding = padding,
    hl = { fg = colors.red, bg = utils.get_hl("StatusLine").bg },
  }
end

M.fileicon = function()
  local icon, color = providers.get_icon_and_color()

  return {
    condition = not utils.buffer_is_empty() and not utils.buftype_is_nofile() and vim.bo.buftype ~= "prompt",
    icon = icon,
    padding = padding,
    hl = { fg = color, bg = utils.get_hl("StatusLine").bg },
  }
end

M.filename = function()
  local hl = { fg = utils.get_hl("StatusLine").fg, bg = utils.get_hl("StatusLine").bg }
  if utils.buffer_is_readonly() and not providers.filetype_is_help() then
    hl = { fg = colors.light_red, bg = utils.get_hl("StatusLine").bg, bold = true }
  end
  if providers.buffer_is_modified() then
    hl = { fg = utils.get_hl("StatusLine").fg, bg = utils.get_hl("StatusLine").bg, bold = true, italic = true }
  end

  return {
    condition = not utils.buffer_is_empty() and not utils.buftype_is_nofile(),
    provider = vim.fn.expand("%:t"),
    padding = padding,
    hl = hl,
  }
end

local icons = {
  modified = "",
  readonly = "",
  help = "󰋗",
}

M.filemark = function()
  local icon
  local hl = { fg = utils.get_hl("StatusLine").fg, bg = utils.get_hl("StatusLine").bg, bold = true }
  if vim.bo.filetype == "help" then
    icon = icons.help
    hl = { fg = colors.light_yellow, bg = utils.get_hl("StatusLine").bg, bold = true }
  elseif utils.buffer_is_readonly() and not providers.filetype_is_help() then
    icon = icons.readonly
    hl = { fg = colors.light_red, bg = utils.get_hl("StatusLine").bg, bold = true }
  elseif providers.buffer_is_modified() then
    icon = icons.modified
    hl = { fg = colors.light_green, bg = utils.get_hl("StatusLine").bg, bold = true }
  end

  local condition = not utils.buffer_is_empty()
    and (providers.filetype_is_help() or utils.buffer_is_readonly() or providers.buffer_is_modified())

  return {
    condition = condition,
    icon = icon,
    padding = padding,
    hl = hl,
  }
end

M.session = function()
  local plugins = require("lazy.core.config").plugins
  local possession_ok, possession = pcall(require, "possession.session")

  local session_name = possession_ok and possession.get_session_name()
  local condition = plugins
    and plugins["possession.nvim"]
    and plugins["possession.nvim"]._.loaded
    and possession_ok
    and possession.get_session_name() ~= nil

  return {
    condition = condition,
    icon = "",
    provider = session_name,
    padding = padding,
    hl = { fg = colors.blue, bg = utils.get_hl("StatusLine").bg },
  }
end

M.lightbulb = function()
  local plugins = require("lazy.core.config").plugins
  local nvim_lightbulb_ok, nvim_lightbulb = pcall(require, "nvim-lightbulb")

  return {
    condition = plugins and plugins["nvim-lightbulb"] and plugins["nvim-lightbulb"]._.loaded and nvim_lightbulb_ok,
    provider = nvim_lightbulb_ok and nvim_lightbulb.get_status_text(),
    padding = padding,
    hl = { fg = colors.blue, bg = utils.get_hl("StatusLine").bg },
  }
end

return M
