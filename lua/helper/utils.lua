local api = vim.api
local bo = vim.bo
local fn = vim.fn
local o = vim.o
local uv = vim.uv

local M = {}

function M.widen_condition(widen_width)
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

function M.buffer_is_empty(expr) return fn.empty(expr) == 1 end

function M.buffer_is_readonly() return bo.readonly end

function M.buftype_is_nofile() return bo.buftype == "nofile" end

function M.match_buftype(buftype) return bo.buftype == buftype end

function M.buffer_is_modified() return bo.modifiable and bo.modified end

function M.get_loading(speed, spinners)
  local index = 0
  local last_time = uv.now()
  local last_spinner = nil

  return function()
    local current_time = uv.now()

    if current_time - last_time >= speed then
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
end

function M.get_hl(name)
  local hl = api.nvim_get_hl(0, { name = name })
  return hl
end

function M.construct_condition(opt_condition, condition)
  if opt_condition == nil then
    return condition
  end
  return opt_condition and condition
end

return M
