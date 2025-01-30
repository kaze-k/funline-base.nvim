local datetime = require("themes.vanilla.components.datetime")
local diagnostic = require("themes.vanilla.components.diagnostic")
local fileinfo = require("themes.vanilla.components.fileinfo")
local git = require("themes.vanilla.components.git")
local lsp = require("themes.vanilla.components.lsp")
local mode = require("themes.vanilla.components.mode")
local opt = require("themes.vanilla.components.opt")
local plugins = require("themes.vanilla.components.plugins")
local separator = require("themes.vanilla.components.separator")

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
