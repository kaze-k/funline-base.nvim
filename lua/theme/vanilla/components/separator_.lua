local colors = require("theme.vanilla.colors")

local M = {}

M.separator = function()
  return {
    icon = "",
    hl = { fg = colors.fg, bg = colors.bg },
  }
end

return M
