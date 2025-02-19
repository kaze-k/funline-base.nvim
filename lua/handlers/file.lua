local api = vim.api
local fn = vim.fn
local bo = vim.bo

local utils = require("helper.utils")

local M = {}

function M.is_filname_exists() return not utils.is_buffer_empty() and not utils.is_match_buftype("nofile") end

function M.get_filename() return fn.expand("%:t") end

function M.is_file_status() return utils.filetype_is_help() or utils.is_buffer_readonly() or utils.is_buffer_modified() end

function M.get_file_status()
  if utils.filetype_is_help() then
    return "help"
  elseif utils.is_buffer_readonly() and not utils.filetype_is_help() then
    return "readonly"
  elseif utils.is_buffer_modified() then
    return "modified"
  else
    return "normal"
  end
end

function M.get_file_extension() return fn.expand("%:e") end

function M.is_file_icon_exists()
  return not utils.is_buffer_empty() and not utils.is_match_buftype("nofile") and not utils.is_match_buftype("prompt")
end

function M.get_file_icon_and_color()
  local filename = M.get_filename()
  local ext = M.get_file_extension()
  local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
  if not devicons_ok then
    error("nvim-web-devicons not found")
  end
  local icon, color = devicons.get_icon_color(filename, ext, { default = true })
  return icon, color
end

function M.get_file_indent()
  if bo.expandtab then
    return string.format("SPC: %s", bo.shiftwidth)
  else
    return string.format("TAB: %s", bo.shiftwidth)
  end
end

function M.get_file_format()
  local fileformat = bo.fileformat
  if fileformat:upper() == "UNIX" then
    return "LF"
  elseif fileformat:upper() == "DOS" then
    return "CRLF"
  elseif fileformat:upper() == "MAC" then
    return "CR"
  end
end

function M.get_buf_current_line()
  local bufnr = api.nvim_get_current_buf()
  return api.nvim_win_get_cursor(bufnr)[1]
end

function M.get_buf_total_line()
  local bufnr = api.nvim_get_current_buf()
  return api.nvim_buf_line_count(bufnr)
end

function M.get_line_ratio()
  local current_line = M.get_current_line()
  local total_line = M.get_total_line()
  local line_ratio = (current_line / total_line) * 100
  line_ratio = math.ceil(line_ratio)
  if line_ratio == 100 then
    line_ratio = math.floor(line_ratio - 1)
  end
  return line_ratio
end

function M.get_position(top, bottom, ratio)
  local position
  local current_line = M.get_current_line()
  local total_line = M.get_total_line()

  if current_line == 1 then
    position = top
  elseif current_line == total_line then
    position = bottom
  else
    position = string.format("%s", ratio)
  end
  return position
end

function M.get_current_col() return fn.col(".") end

function M.get_current_line() return fn.line(".") end

function M.get_total_line() return fn.line("$") end

return M
