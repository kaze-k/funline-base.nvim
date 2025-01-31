local colors = require("themes.vanilla.colors")
local utils = require("funline-base.utils")

local M = {}

local icons = {
  modified = "[+]",
  readonly = "",
  help = "󰋗",
  linux = "",
  windows = "",
  mac = "",
  lineinfo = "",
}

local line_ratio_icons = {
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  top = "",
  bottom = "",
}

local function get_current_line() return vim.api.nvim_win_get_cursor(0)[1] end

local function get_total_line() return vim.api.nvim_buf_line_count(0) end

local function get_line_ratio()
  local current_line = get_current_line()
  local total_line = get_total_line()
  local line_ratio = (current_line / total_line) * 100
  line_ratio = math.ceil(line_ratio)
  if line_ratio == 100 then
    line_ratio = math.floor(line_ratio - 1)
  end
  return line_ratio
end

local function col(top, bottom, ratio)
  local position
  local current_line = get_current_line()
  local total_line = get_total_line()

  if current_line == 1 then
    position = top
  elseif current_line == total_line then
    position = bottom
  else
    position = string.format("%s", ratio)
  end
  return position
end

local function buffer_is_readonly()
  if vim.bo.filetype == "help" then
    return false
  end
  return vim.bo.readonly
end

M.fileicon = function()
  local icon, color = utils.get_icon_and_color()

  return {
    condition = utils.buffer_is_empty() and utils.buftype_not_nofile() and vim.bo.buftype ~= "prompt",
    icon = icon,
    padding_right = " ",
    hl = { fg = color, bg = utils.get_hl("StatusLine").bg },
  }
end

M.filename = function()
  local hl = { fg = utils.get_hl("StatusLine").fg, bg = utils.get_hl("StatusLine").bg }
  if buffer_is_readonly() then
    hl = { fg = colors.light_red, bg = utils.get_hl("StatusLine").bg, bold = true }
  end
  if vim.bo.modifiable and vim.bo.modified then
    hl = { fg = utils.get_hl("StatusLine").fg, bg = utils.get_hl("StatusLine").bg, bold = true, italic = true }
  end

  return {
    condition = utils.buffer_is_empty() and utils.buftype_not_nofile(),
    provider = vim.fn.expand("%:t"),
    padding_right = " ",
    hl = hl,
  }
end

M.filemark = function()
  local icon
  local hl = { fg = utils.get_hl("StatusLine").fg, bg = utils.get_hl("StatusLine").bg, bold = true }
  if vim.bo.filetype == "help" then
    icon = icons.help
    hl = { fg = colors.light_yellow, bg = utils.get_hl("StatusLine").bg, bold = true }
  elseif buffer_is_readonly() then
    icon = icons.readonly
    hl = { fg = colors.light_red, bg = utils.get_hl("StatusLine").bg, bold = true }
  elseif vim.bo.modifiable and vim.bo.modifiable then
    icon = icons.modified
    hl = { fg = colors.light_green, bg = utils.get_hl("StatusLine").bg, bold = true }
  end
  local condition = false

  if (utils.buffer_is_empty() and utils.buftype_not_nofile()) or vim.bo.buftype == "prompt" then
    condition = false
  end
  condition = vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    and (vim.bo.filetype == "help" or buffer_is_readonly() or vim.bo.modifiable and vim.bo.modified)

  return {
    condition = condition,
    icon = icon,
    padding_right = " ",
    hl = hl,
  }
end

M.fileindent = function()
  return {
    condition = utils.widen_condition(140),
    provider = string.format("SPC:%s", vim.bo.shiftwidth),
    padding_left = " ",
    hl = { fg = colors.pink, bg = utils.get_hl("StatusLine").bg },
  }
end

M.fileformat = function()
  local icon
  local provider

  if vim.bo.fileformat:upper() == "UNIX" then
    icon = icons.linux
    provider = "LF"
  elseif vim.bo.fileformat:upper() == "DOS" then
    icon = icons.windows
    provider = "CRLF"
  elseif vim.bo.fileformat:upper() == "MAC" then
    icon = icons.mac
    provider = "CR"
  end

  return {
    icon = icon,
    provider = provider,
    padding_left = " ",
    hl = { fg = colors.pink, bg = utils.get_hl("StatusLine").bg },
  }
end

M.lineinfo = function()
  return {
    icon = icons.lineinfo,
    provider = string.format("%d:%d[%d]", vim.fn.col("."), vim.fn.line("."), vim.fn.line("$")),
    padding_left = " ",
    hl = { fg = colors.pink, bg = utils.get_hl("StatusLine").bg, bold = true },
  }
end

M.lineratio = function()
  local line_ratio = get_line_ratio()
  local icon =
    col(line_ratio_icons.top, line_ratio_icons.bottom, line_ratio_icons[math.ceil(line_ratio / #line_ratio_icons)])
  local provider = col("TOP", "BOT", string.format("%s%%", tostring(line_ratio)))

  return {
    condition = utils.widen_condition(140),
    icon = icon,
    provider = provider,
    padding_left = " ",
    hl = { fg = colors.light_green, bg = utils.get_hl("StatusLine").bg },
  }
end

return M
