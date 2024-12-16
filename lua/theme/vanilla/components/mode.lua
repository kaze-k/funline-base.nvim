local colors = require("theme.vanilla.colors")

local M = {}

local icon = {
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
  ["s"] = "",
  ["S"] = "",
  [""] = "",
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

local mode = {
  ["n"] = "NORMAL",
  ["niI"] = "NORMAL",
  ["niR"] = "NORMAL",
  ["niV"] = "NORMAL",
  ["no"] = "OP",
  ["nov"] = "OP",
  ["noV"] = "OP",
  ["no"] = "OP",
  ["v"] = "VISUAL",
  ["vs"] = "VISUAL",
  ["V"] = "LINES",
  ["Vs"] = "LINES",
  [""] = "BLOCK",
  ["s"] = "BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT",
  [""] = "BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["Rx"] = "REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "COMMAND",
  ["ce"] = "COMMAND",
  ["r"] = "ENTER",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERM",
  ["nt"] = "N-TERM",
  ["null"] = "NONE",
}

M.mode = {
  icon = function() return icon[vim.fn.mode()] end,
  provider = function() return mode[vim.fn.mode()] end,
  hl = function() return { fg = colors.mode_colors[vim.fn.mode()], bg = colors.bg, bold = true, italic = true } end,
}

return M
