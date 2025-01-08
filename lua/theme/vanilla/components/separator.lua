local colors = require("theme.vanilla.colors")

local M = {}

M.separator = function()
  return {
    icon = "",
    hl = { fg = colors.statusline_hl("fg"), bg = colors.statusline_hl("bg") },
  }
end

return M
