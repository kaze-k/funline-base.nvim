local handlers = require("handlers")
local colors = require("helper.colors")
local utils = require("helper.utils")

local M = {}

function M.date(opts)
  return function()
    return {
      condition = opts.condition,
      icon = opts.icon or "",
      provider = handlers.datetime.date(),
      padding = opts.padding,
      hl = opts.hl or { fg = colors.yellow, bg = utils.get_hl("StatusLine").bg },
    }
  end
end

function M.time(opts)
  local icons = { "", "", "", "", "", "", "", "", "", "", "", "" }

  return function()
    return {
      condition = opts.condition,
      icon = opts.icon or handlers.datetime.get_time_icon(opts.icons or icons),
      provider = handlers.datetime.time(),
      padding = opts.padding,
      hl = opts.hl or { fg = colors.yellow, bg = utils.get_hl("StatusLine").bg },
    }
  end
end

return M
