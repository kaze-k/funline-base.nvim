local colors = require("themes.powerlike.colors")
local utils = require("helper.utils")

local M = {}

M.separator = function()
  return {
    icon = " ",
    hl = { fg = colors.mode_colors[vim.fn.mode()], bg = colors.mode_colors[vim.fn.mode()] },
  }
end

M.arrow_left = function()
  return {
    icon = "",
    padding = { right = " " },
    hl = { fg = colors.mode_colors[vim.fn.mode()], bg = utils.get_hl("StatusLine").bg },
  }
end

M.arrow_right = function()
  return {
    icon = "",
    padding = { left = " " },
    hl = { fg = colors.mode_colors[vim.fn.mode()], bg = utils.get_hl("StatusLine").bg },
  }
end

return M
