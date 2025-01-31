local colors = require("themes.vanilla.colors")
local utils = require("funline-base.utils")

local M = {}

M.branch = function()
  return {
    condition = utils.buffer_is_empty()
      and utils.buftype_not_nofile()
      and vim.b.gitsigns_status_dict ~= nil
      and vim.b.gitsigns_status_dict.head ~= nil,
    icon = "",
    provider = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.head or vim.b.gitsigns_head,
    padding_right = " ",
    hl = { fg = colors.green, bg = utils.get_hl("StatusLine").bg },
  }
end

M.add = function()
  return {
    condition = utils.buffer_is_empty()
      and utils.buftype_not_nofile()
      and vim.b.gitsigns_status_dict ~= nil
      and vim.b.gitsigns_status_dict.added ~= nil
      and vim.b.gitsigns_status_dict.added > 0,
    icon = "",
    provider = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.added,
    padding_right = " ",
    hl = { fg = colors.light_green, bg = utils.get_hl("StatusLine").bg },
  }
end

M.change = function()
  return {
    condition = utils.buffer_is_empty()
      and utils.buftype_not_nofile()
      and vim.b.gitsigns_status_dict ~= nil
      and vim.b.gitsigns_status_dict.changed ~= nil
      and vim.b.gitsigns_status_dict.changed > 0,
    icon = "",
    provider = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.changed,
    padding_right = " ",
    hl = { fg = colors.orange, bg = utils.get_hl("StatusLine").bg },
  }
end

M.remove = function()
  return {
    condition = utils.buffer_is_empty()
      and utils.buftype_not_nofile()
      and vim.b.gitsigns_status_dict ~= nil
      and vim.b.gitsigns_status_dict.removed ~= nil
      and vim.b.gitsigns_status_dict.removed > 0,
    icon = "",
    provider = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.removed,
    padding_right = " ",
    hl = { fg = colors.red, bg = utils.get_hl("StatusLine").bg },
  }
end

return M
