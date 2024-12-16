local colors = require("theme.vanilla.colors")
local utils = require("theme.vanilla.utils")

local M = {}

local icons = {
  modified = "[+]",
  readonly = "",
  help = "",
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

local function buffer_is_empty() return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 and vim.bo.buftype ~= "nofile" end

M.fileicon = {
  condition = buffer_is_empty,
  icon = function()
    local icon, _ = utils.get_icon_and_color()
    return icon
  end,
  hl = function()
    local _, color = utils.get_icon_and_color()
    return { fg = color, bg = colors.bg }
  end,
}

M.filename = {
  condition = buffer_is_empty,
  provider = function() return vim.fn.expand("%:t") end,
  hl = function()
    if buffer_is_readonly() then
      return { fg = "#ff0000", bg = colors.bg, bold = true }
    end
    if vim.bo.modifiable and vim.bo.modified then
      return { fg = "#50fa7b", bg = colors.bg, bold = true, italic = true }
    end
    return { fg = colors.fg, bg = colors.bg, bold = true }
  end,
}

M.filemark = {
  condition = function()
    if buffer_is_empty() or vim.bo.buftype == "prompt" then
      return false
    end
    return vim.bo.filetype == "help" or buffer_is_readonly() or vim.bo.modifiable and vim.bo.modified
  end,
  icon = function()
    local icon
    if vim.bo.filetype == "help" then
      icon = icons.help
    elseif buffer_is_readonly() then
      icon = icons.modified
    elseif vim.bo.modifiable and vim.bo.modified then
      icon = icons.modified
    end
    return icon
  end,
  hl = function()
    if buffer_is_readonly() then
      return { fg = "#ff0000", bg = colors.bg, bold = true }
    end
    if vim.bo.modifiable and vim.bo.modified then
      return { fg = "#50fa7b", bg = colors.bg, bold = true }
    end
    return { fg = colors.fg, bg = colors.bg, bold = true }
  end,
}

M.fileindent = {
  condition = function() return utils.widen_condition(140) end,
  provider = function()
    local spaces = vim.bo.shiftwidth
    return string.format("SPC:%s", spaces)
  end,
  hl = { fg = "#ff79c6", bg = colors.bg },
}

M.fileformat = {
  icon = function()
    if vim.bo.fileformat:upper() == "UNIX" then
      return icons.linux
    elseif vim.bo.fileformat:upper() == "DOS" then
      return icons.windows
    else
      return icons.mac
    end
  end,
  provider = function()
    if vim.bo.fileformat:upper() == "UNIX" then
      return "LF"
    elseif vim.bo.fileformat:upper() == "DOS" then
      return "CRLF"
    else
      return "CR"
    end
  end,
  hl = { fg = "#ff79c6", bg = colors.bg, bold = true },
}
M.lineinfo = {
  icon = icons.lineinfo,
  provider = function()
    local column = vim.fn.col(".")
    local line = vim.fn.line(".")
    local line_total = vim.fn.line("$")
    return string.format("%d:%d[%d]", column, line, line_total)
  end,
  hl = { fg = "#ff79c6", bg = colors.bg, bold = true },
}

M.lineratio = {
  icon = function()
    local line_ratio = get_line_ratio()
    local icon = line_ratio_icons[math.ceil(line_ratio / #line_ratio_icons)]
    return col(line_ratio_icons.top, line_ratio_icons.bottom, icon)
  end,
  provider = function()
    local line_ratio = tostring(get_line_ratio())
    line_ratio = string.format("%s%%", line_ratio)
    return col("TOP", "BOT", line_ratio)
  end,
  hl = { fg = "#50fa7b", bg = colors.bg, bold = true },
}

return M
