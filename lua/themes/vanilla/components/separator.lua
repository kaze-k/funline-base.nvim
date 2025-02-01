local utils = require("helper.utils")

local M = {}

M.separator = function()
  return {
    icon = " ",
    hl = { fg = utils.get_hl("StatusLine").fg, bg = utils.get_hl("StatusLine").bg },
  }
end

return M
