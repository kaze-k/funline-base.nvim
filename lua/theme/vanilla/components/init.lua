local diagnostic = require("theme.vanilla.components.diagnostic")
local fileinfo = require("theme.vanilla.components.fileinfo")
local git = require("theme.vanilla.components.git")
local lsp = require("theme.vanilla.components.lsp")
local mode = require("theme.vanilla.components.mode")
local opt = require("theme.vanilla.components.opt")
local plugins = require("theme.vanilla.components.plugins")
local separator = require("theme.vanilla.components.separator")

local datetime_ = require("theme.vanilla.components.datetime_")
local diagnostic_ = require("theme.vanilla.components.diagnostic_")
local fileinfo_ = require("theme.vanilla.components.fileinfo_")
local git_ = require("theme.vanilla.components.git_")
local lsp_ = require("theme.vanilla.components.lsp_")
local mode_ = require("theme.vanilla.components.mode_")
local opt_ = require("theme.vanilla.components.opt_")
local plugins_ = require("theme.vanilla.components.plugins_")
local separator_ = require("theme.vanilla.components.separator_")

local M = {
  diagnostic = diagnostic,
  fileinfo = fileinfo,
  git = git,
  lsp = lsp,
  mode = mode,
  opt = opt,
  plugins = plugins,
  separator = separator,

  datetime_ = datetime_,
  diagnostic_ = diagnostic_,
  fileinfo_ = fileinfo_,
  git_ = git_,
  lsp_ = lsp_,
  mode_ = mode_,
  opt_ = opt_,
  plugins_ = plugins_,
  separator_ = separator_,
}

return M
