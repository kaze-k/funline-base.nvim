local M = {}

local statusline_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })

M.fg = statusline_hl.fg

M.bg = statusline_hl.bg

M.mode_colors = {
  ["n"] = "#ff79c6",
  ["niI"] = "#ff79c6",
  ["niR"] = "#ff79c6",
  ["niV"] = "#ff79c6",
  ["no"] = "#bd93f9",
  ["nov"] = "#bd93f9",
  ["noV"] = "#bd93f9",
  ["no"] = "#bd93f9",
  ["v"] = "#8be9fd",
  ["vs"] = "#8be9fd",
  ["V"] = "#8be9fd",
  ["Vs"] = "#8be9fd",
  [""] = "#8be9fd",
  ["s"] = "#8be9fd",
  ["s"] = "#50fa7b",
  ["S"] = "#50fa7b",
  [""] = "#50fa7b",
  ["i"] = "#8be9fd",
  ["ic"] = "#8be9fd",
  ["ix"] = "#8be9fd",
  ["R"] = "#ff5555",
  ["Rc"] = "#ff5555",
  ["Rv"] = "#ff5555",
  ["Rx"] = "#ff5555",
  ["c"] = "#4be9fd",
  ["cv"] = "#4be9fd",
  ["ce"] = "#4be9fd",
  ["r"] = "#f1fa8c",
  ["rm"] = "#f1fa8c",
  ["r?"] = "#f1fa8c",
  ["!"] = "#ff79c6",
  ["t"] = "#bd93f9",
  ["nt"] = "#bd93f9",
  ["null"] = "#bd93f9",
}

return M
