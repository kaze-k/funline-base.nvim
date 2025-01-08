local datetime = require("theme.vanilla.components.datetime")
local diagnostic = require("theme.vanilla.components.diagnostic")
local fileinfo = require("theme.vanilla.components.fileinfo")
local git = require("theme.vanilla.components.git")
local lsp = require("theme.vanilla.components.lsp")
local mode = require("theme.vanilla.components.mode")
local opt = require("theme.vanilla.components.opt")
local plugins = require("theme.vanilla.components.plugins")
local separator = require("theme.vanilla.components.separator")

local M = {
  datetime = datetime,
  diagnostic = diagnostic,
  fileinfo = fileinfo,
  git = git,
  lsp = lsp,
  mode = mode,
  opt = opt,
  plugins = plugins,
  separator = separator,
}

return M
