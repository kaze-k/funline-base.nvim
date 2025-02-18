local M = {}

M.datetime = require("handlers.datetime")
M.file = require("handlers.file")
M.git = require("handlers.git")
M.lsp = require("handlers.lsp")
M.mode = require("handlers.mode")
M.opt = require("handlers.opt")
M.plugins = require("handlers.plugins")

return M
