local colors = require("theme.vanilla.colors")

local M = {}

local function get_diagnostic(severity)
  return vim.diagnostic.get(0, {
    severity = vim.diagnostic.severity[severity],
  })
end

M.error = function()
  return {
    condition = #get_diagnostic("ERROR") > 0,
    icon = "",
    provider = #get_diagnostic("ERROR"),
    hl = { fg = "#ff5555", bg = colors.statusline_hl("bg"), bold = true },
  }
end

M.warn = function()
  return {
    condition = #get_diagnostic("WARN") > 0,
    icon = "",
    provider = #get_diagnostic("WARN"),
    hl = { fg = "#f1ba8c", bg = colors.statusline_hl("bg"), bold = true },
  }
end

M.hint = function()
  return {
    condition = #get_diagnostic("HINT") > 0,
    icon = "󰌶",
    provider = #get_diagnostic("HINT"),
    hl = { fg = "#8be9d1", bg = colors.statusline_hl("bg"), bold = true },
  }
end

M.info = function()
  return {
    condition = #get_diagnostic("INFO") > 0,
    icon = "",
    provider = #get_diagnostic("INFO"),
    hl = { fg = "#8be9fd", bg = colors.statusline_hl("bg"), bold = true },
  }
end

return M
