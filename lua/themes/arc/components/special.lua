local handlers = require("handlers")
local utils = require("helper.utils")
local colors = require("helper.colors")
local mode_icons = require("helper.mode_icons")

local M = {
  left = {},
  right = {},
}

M.left.mode = function()
  return {
    icon = handlers.mode.get_mode_icon(mode_icons),
    provider = handlers.mode.get_vim_mode(),
    hl = {
      fg = handlers.mode.get_mode_color(colors.mode_colors),
      bg = utils.get_hl("StatusLine").bg,
      bold = true,
    },
  }
end

M.right.date = function()
  return {
    condition = utils.is_widen_condition(140),
    icon = "",
    provider = handlers.datetime.get_date(),
    padding = { right = " " },
    hl = { fg = colors.yellow, bg = utils.get_hl("StatusLine").bg },
  }
end

M.right.time = function()
  local icons = { "", "", "", "", "", "", "", "", "", "", "", "" }

  return {
    icon = handlers.datetime.get_time_icon(icons),
    provider = handlers.datetime.get_time(),
    hl = { fg = colors.yellow, bg = utils.get_hl("StatusLine").bg },
  }
end

return M
