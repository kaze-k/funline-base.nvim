local colors = require("theme.vanilla.colors")
local utils = require("theme.vanilla.utils")

local M = {}

M.date = {
  condition = function() return utils.widen_condition(140) end,
  icon = "",
  provider = function()
    local date = os.date("%Y-%m-%d")
    return date
  end,
  hl = { fg = "#f1fa8c", bg = colors.bg, bold = true },
}

M.time = {
  icon = "",
  provider = function()
    local time = os.date("%H:%M:%S")
    return time
  end,
  hl = { fg = "#f1fa8c", bg = colors.bg, bold = true },
}

return M
