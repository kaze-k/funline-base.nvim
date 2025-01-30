local colors = require("themes.vanilla.colors")
local utils = require("funline-base.utils")

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
    padding_left = " ",
    hl = { fg = colors.red, bg = utils.get_hl("StatusLine", "bg") },
  }
end

M.warn = function()
  return {
    condition = #get_diagnostic("WARN") > 0,
    icon = "",
    provider = #get_diagnostic("WARN"),
    padding_left = " ",
    hl = { fg = colors.light_orange, bg = utils.get_hl("StatusLine", "bg") },
  }
end

M.hint = function()
  return {
    condition = #get_diagnostic("HINT") > 0,
    icon = "󰌶",
    provider = #get_diagnostic("HINT"),
    padding_left = " ",
    hl = { fg = colors.light_cyan, bg = utils.get_hl("StatusLine", "bg") },
  }
end

M.info = function()
  return {
    condition = #get_diagnostic("INFO") > 0,
    icon = "",
    provider = #get_diagnostic("INFO"),
    padding_left = " ",
    hl = { fg = colors.light_blue, bg = utils.get_hl("StatusLine", "bg") },
  }
end

return M
