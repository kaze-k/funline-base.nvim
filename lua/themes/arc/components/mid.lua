local handlers = require("handlers")
local utils = require("helper.utils")
local colors = require("helper.colors")

local M = {}

M.date = function()
  return {
    condition = utils.is_widen_condition(140),
    icon = "",
    provider = handlers.datetime.get_date(),
    padding = { right = " " },
    hl = { fg = colors.yellow, bg = utils.get_hl("StatusLine").bg },
  }
end

M.time = function()
  local icons = { "", "", "", "", "", "", "", "", "", "", "", "" }

  return {
    icon = handlers.datetime.get_time_icon(icons),
    provider = handlers.datetime.get_time(),
    hl = { fg = colors.yellow, bg = utils.get_hl("StatusLine").bg },
  }
end

return M
