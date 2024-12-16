local funline = require("funline")

local M = {}

M.setup = function(opts)
  opts = opts or {}
  opts.theme = opts.theme or "vanilla"
  local theme = string.format("theme.%s", opts.theme)
  local config = require(theme).config
  funline.setup(config)
end

return M
