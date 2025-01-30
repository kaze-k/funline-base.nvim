local colors = require("themes.vanilla.colors")
local utils = require("funline-base.utils")

local M = {}

local time_icons = { "", "", "", "", "", "", "", "", "", "", "", "" }

M.date = function()
  local date = os.date("%Y-%m-%d")

  return {
    condition = utils.widen_condition(140),
    icon = "",
    provider = date,
    padding_left = " ",
    hl = { fg = colors.yellow, bg = utils.get_hl("StatusLine", "bg") },
  }
end

M.time = function()
  local time = os.date("%H:%M:%S")
  local hour = tonumber(os.date("%H"))
  local icon
  if 0 <= hour and hour <= 11 then
    icon = time_icons[hour + 1]
  else
    icon = time_icons[(hour - 12) + 1]
  end

  return {
    icon = icon,
    provider = time,
    padding_left = " ",
    hl = { fg = colors.yellow, bg = utils.get_hl("StatusLine", "bg") },
  }
end

return M
