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

return M
