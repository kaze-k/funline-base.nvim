local api = vim.api

local M = {}

local mode_alias = {
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
  [""] = "BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rx"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
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

function M.mode_icon(icons) return icons[api.nvim_get_mode().mode] end

function M.mode_color(colors) return colors[api.nvim_get_mode().mode] end

function M.vim_mode() return mode_alias[api.nvim_get_mode().mode] end

return M
