local colors = require("theme.vanilla.colors")
local utils = require("theme.vanilla.utils")

local M = {}

local time_icons = { "", "", "", "", "", "", "", "", "", "", "", "" }

M.date = function()
  local date = os.date("%Y-%m-%d")

  return {
    condition = utils.widen_condition(140),
    icon = "",
    provider = date,
    hl = { fg = "#f1b00c", bg = colors.statusline_hl("bg"), bold = true },
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
    hl = { fg = "#f1b00c", bg = colors.statusline_hl("bg"), bold = true },
  }
end

return M
