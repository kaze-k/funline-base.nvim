local colors = require("theme.vanilla.colors")

local M = {}

M.separator = function()
  return {
    icon = "",
    hl = { fg = colors.hl("StatusLine", "fg"), bg = colors.hl("StatusLine", "bg") },
  }
end

return M
