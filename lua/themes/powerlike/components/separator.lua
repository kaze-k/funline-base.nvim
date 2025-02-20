local handlers = require("handlers")
local utils = require("helper.utils")
local colors = require("helper.colors")

local M = {}

M.separator = function()
  return {
    icon = " ",
    hl = {
      fg = handlers.mode.get_mode_color(colors.mode_colors),
      bg = handlers.mode.get_mode_color(colors.mode_colors),
    },
  }
end

M.arrow_left = function()
  return {
    icon = "",
    padding = { right = " " },
    hl = { fg = handlers.mode.get_mode_color(colors.mode_colors), bg = utils.get_hl("StatusLine").bg },
  }
end

M.arrow_right = function()
  return {
    icon = "",
    padding = { left = " " },
    hl = { fg = handlers.mode.get_mode_color(colors.mode_colors), bg = utils.get_hl("StatusLine").bg },
  }
end

return M
