local handlers = require("handlers")
local colors = require("helper.colors")
local utils = require("helper.utils")

local M = {}

local mode_icons = {
  ["n"] = "",
  ["niI"] = "",
  ["niR"] = "",
  ["niV"] = "",
  ["no"] = "",
  ["nov"] = "",
  ["noV"] = "",
  ["no"] = "",
  ["v"] = "",
  ["vs"] = "",
  ["V"] = "",
  ["Vs"] = "",
  [""] = "",
  ["s"] = "",
  [""] = "",
  ["s"] = "",
  ["S"] = "",
  ["i"] = "󰛿",
  ["ic"] = "󰛿",
  ["ix"] = "󰛿",
  ["R"] = "󰬲",
  ["Rc"] = "󰬲",
  ["Rv"] = "󰬲",
  ["Rx"] = "󰬲",
  ["c"] = "󰊠",
  ["cv"] = "󰊠",
  ["ce"] = "󰊠",
  ["r"] = "",
  ["rm"] = "",
  ["r?"] = "",
  ["!"] = "",
  ["t"] = "",
  ["nt"] = "",
  ["null"] = "󰟢",
}

function M.mode(opts)
  return function()
    return {
      condition = opts.condition,
      icon = opts.icon or handlers.mode.mode_icon(opts.mode_icons or mode_icons),
      provider = handlers.mode.vim_mode(),
      padding = opts.padding,
      hl = opts.hl or {
        fg = handlers.mode.mode_color(colors.mode_colors),
        bg = utils.get_hl("StatusLine").bg,
        bold = true,
      },
    }
  end
end

return M
