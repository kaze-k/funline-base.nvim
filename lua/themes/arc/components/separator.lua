local utils = require("helper.utils")

local M = {}

M.aroundLeft = function()
  return {
    icon = "",
    hl = { fg = utils.get_hl("StatusLine").bg, bg = utils.get_hl("Normal").bg },
  }
end

M.aroundRight = function()
  return {
    icon = "",
    hl = { fg = utils.get_hl("StatusLine").bg, bg = utils.get_hl("Normal").bg },
  }
end

return M
