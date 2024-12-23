local colors = require("theme.vanilla.colors")
local utils = require("theme.vanilla.utils")

local M = {}

M.date = function()
  local date = os.date("%Y-%m-%d")

  return {
    condition = utils.widen_condition(140),
    icon = "",
    provider = date,
    hl = { fg = "#f1fa8c", bg = colors.statusline_hl("bg"), bold = true },
  }
end

M.time = function()
  local time = os.date("%H:%M:%S")

  return {
    -- TODO:按照时间来显示图标
    icon = "",
    provider = time,
    hl = { fg = "#f1fa8c", bg = colors.statusline_hl("bg"), bold = true },
  }
end

return M
