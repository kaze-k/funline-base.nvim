local colors = require("theme.vanilla.colors")

local M = {}

M.branch = {
  condition = function() return vim.b.gitsigns_status_dict ~= nil and vim.b.gitsigns_status_dict.head ~= "" end,
  icon = "",
  provider = function()
    local branch = vim.b.gitsigns_head
    return branch and branch or ""
  end,
  hl = { fg = "#8be9fd", bg = colors.bg, bold = true },
}

M.add = {
  condition = function()
    return vim.b.gitsigns_status_dict ~= nil
      and vim.b.gitsigns_status_dict.added ~= nil
      and vim.b.gitsigns_status_dict.added > 0
  end,
  icon = "",
  provider = function()
    local added = vim.b.gitsigns_status_dict.added
    return added and added
  end,
  hl = { fg = "#50fa7b", bg = colors.bg, bold = true },
}

M.change = {
  condition = function()
    return vim.b.gitsigns_status_dict ~= nil
      and vim.b.gitsigns_status_dict.changed ~= nil
      and vim.b.gitsigns_status_dict.changed > 0
  end,
  icon = "",
  provider = function()
    local changed = vim.b.gitsigns_status_dict.changed
    return changed and changed
  end,
  hl = { fg = "#f1fa8c", bg = colors.bg, bold = true },
}

M.remove = {
  condition = function()
    return vim.b.gitsigns_status_dict ~= nil
      and vim.b.gitsigns_status_dict.removed ~= nil
      and vim.b.gitsigns_status_dict.removed > 0
  end,
  icon = "",
  provider = function()
    local removed = vim.b.gitsigns_status_dict.removed
    return removed and removed
  end,
  hl = { fg = "#ff5555", bg = colors.bg, bold = true },
}

return M
