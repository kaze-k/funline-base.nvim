local M = {}

local components = require("theme.vanilla.components")
local colors = require("theme.vanilla.colors")

local datetime = components.datetime
local diagnostic = components.diagnostic
local fileinfo = components.fileinfo
local git = components.git
local lsp = components.lsp
local mode = components.mode
local opt = components.opt
local plugins = components.plugins
local separator = components.separator

local highlight = { fg = colors.statusline_hl("fg"), bg = colors.statusline_hl("bg") }

local statusline = {
  left = {
    separator.separator,
    mode.mode,
    git.branch,
    git.add,
    git.change,
    git.remove,
    plugins.session,
    fileinfo.fileicon,
    fileinfo.filename,
    fileinfo.filemark,
    plugins.lightbulb,
  },
  mid = {},
  right = {
    opt.search,
    opt.spell,
    datetime.date,
    datetime.time,
    diagnostic.error,
    diagnostic.warn,
    diagnostic.hint,
    diagnostic.info,
    lsp.lspstatus,
    lsp.nlsstatus,
    plugins.autosave,
    plugins.codeium,
    plugins.lazystatus,
    fileinfo.fileindent,
    fileinfo.fileformat,
    fileinfo.lineratio,
    fileinfo.lineinfo,
    separator.separator,
  },
}

local specialline = {
  left = {
    separator.separator,
    mode.mode,
  },
  mid = {},
  right = {
    datetime.date,
    datetime.time,
    separator.separator,
  },
}

local specialtypes = {
  "terminal",
}

local refresh = {
  timeout = 0,
  interval = 1000,
}

local handle_update = function(update)
  if vim.o.statusline == "%!vm#themes#statusline()" then
    update(false)
  else
    update(true)
  end
end

M.config = {
  highlight = highlight,
  statusline = statusline,
  specialline = specialline,
  specialtypes = specialtypes,
  refresh = refresh,
  handle_update = handle_update,
}

return M
