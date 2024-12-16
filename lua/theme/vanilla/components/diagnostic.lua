local colors = require("theme.vanilla.colors")

local M = {}

local function get_diagnostic(severity)
  return vim.diagnostic.get(0, {
    severity = vim.diagnostic.severity[severity],
  })
end

M.error = {
  condition = function() return #get_diagnostic("ERROR") > 0 end,
  icon = "",
  provider = function() return #get_diagnostic("ERROR") end,
  hl = { fg = "#ff5555", bg = colors.bg, bold = true },
}

M.warn = {
  condition = function() return #get_diagnostic("WARN") > 0 end,
  icon = "",
  provider = function() return #get_diagnostic("WARN") end,
  hl = { fg = "#f1fa8c", bg = colors.bg, bold = true },
}

M.hint = {
  condition = function() return #get_diagnostic("HINT") > 0 end,
  icon = "󰌶",
  provider = function() return #get_diagnostic("HINT") end,
  hl = { fg = "#8be9d1", bg = colors.bg, bold = true },
}

M.info = {
  condition = function() return #get_diagnostic("INFO") > 0 end,
  icon = "",
  provider = function() return #get_diagnostic("INFO") end,
  hl = { fg = "#8be9fd", bg = colors.bg, bold = true },
}

return M
