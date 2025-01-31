local devicons = require("nvim-web-devicons")

local M = {}

M.get_icon_and_color = function()
  local filename = vim.fn.expand("%:t")
  local ext = vim.fn.expand("%:e")
  return devicons.get_icon_color(filename, ext, { default = true })
end

M.widen_condition = function(widen_width)
  local bufnr = vim.api.nvim_get_current_buf()
  local winwidth = vim.fn.winwidth(bufnr)
  if vim.o.laststatus == 3 then
    winwidth = vim.o.columns
  end

  if winwidth > widen_width then
    return true
  end
  return false
end

M.buffer_is_empty = function() return vim.fn.empty(vim.fn.expand("%:t")) ~= 2 end

M.buftype_not_nofile = function() return vim.bo.buftype ~= "nofile" end

M.get_loading = function(speed)
  local spinners = { "◜", "◠", "◝", "◞", "◡", "◟" }
  local index = 0
  local last_time = vim.uv.now()
  local last_spinner = nil
  local function loading()
    local current_time = vim.uv.now()

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

  return loading
end

M.get_hl = function(name, opt)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  return hl[opt]
end

return M
