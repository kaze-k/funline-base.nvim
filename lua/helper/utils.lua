local api = vim.api
local bo = vim.bo
local fn = vim.fn
local o = vim.o
local uv = vim.uv

local M = {}

function M.is_widen_condition(widen_width)
  local bufnr = api.nvim_get_current_buf()
  local winwidth = fn.winwidth(bufnr)
  if o.laststatus == 3 then
    winwidth = o.columns
  end

  if winwidth > widen_width then
    return true
  end
  return false
end

function M.is_buffer_empty() return fn.empty(fn.expand("%:e")) == 1 end

function M.is_buffer_readonly() return bo.readonly end

function M.is_buffer_modified() return bo.modifiable and bo.modified end

function M.is_match_buftype(buftype) return bo.buftype == buftype end

function M.filetype_is_help() return bo.filetype == "help" end

function M.get_loading(speed, spinner)
  local index = 0
  local last_time = uv.now()
  local last_spinner = nil

  return function()
    local current_time = uv.now()

    if current_time - last_time >= speed then
      last_time = current_time
      index = index + 1
      if index > #spinner then
        index = 1
      end
      last_spinner = spinner[index]
      return spinner[index]
    end
    return last_spinner
  end
end

function M.get_hl(name)
  local hl = api.nvim_get_hl(0, { name = name })
  return hl
end

return M
