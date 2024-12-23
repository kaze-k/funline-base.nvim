local colors = require("theme.vanilla.colors")

local M = {}

M.branch = function()
  return {
    condition = vim.b.gitsigns_status_dict ~= nil and vim.b.gitsigns_status_dict.head ~= nil,
    icon = "",
    provider = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.head or vim.b.gitsigns_head,
    hl = { fg = "#5ac9a0", bg = colors.statusline_hl("bg"), bold = true },
  }
end

M.add = function()
  return {
    condition = vim.b.gitsigns_status_dict ~= nil
      and vim.b.gitsigns_status_dict.added ~= nil
      and vim.b.gitsigns_status_dict.added > 0,
    icon = "",
    provider = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.added,
    hl = { fg = "#50fa7b", bg = colors.statusline_hl("bg"), bold = true },
  }
end

M.change = function()
  return {
    condition = vim.b.gitsigns_status_dict ~= nil
      and vim.b.gitsigns_status_dict.changed ~= nil
      and vim.b.gitsigns_status_dict.changed > 0,
    icon = "",
    provider = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.changed,
    hl = { fg = "#f1aa8c", bg = colors.statusline_hl("bg"), bold = true },
  }
end

M.remove = function()
  return {
    condition = vim.b.gitsigns_status_dict ~= nil
      and vim.b.gitsigns_status_dict.removed ~= nil
      and vim.b.gitsigns_status_dict.removed > 0,
    icon = "",
    provider = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.removed,
    hl = { fg = "#ff5555", bg = colors.statusline_hl("bg"), bold = true },
  }
end

return M
