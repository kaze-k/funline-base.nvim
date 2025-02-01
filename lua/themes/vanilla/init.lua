local M = {}

local utils = require("helper.utils")

local components = require("themes.vanilla.components")

local left = components.left
local right = components.right
local separator = components.separator

local statusline = {
  left = {
    separator.separator,
    left.mode,
    left.gitbranch,
    left.gitadd,
    left.gitchange,
    left.gitremove,
    left.session,
    left.fileicon,
    left.filename,
    left.filemark,
    left.lightbulb,
  },
  mid = {},
  right = {
    right.search,
    right.spell,
    right.date,
    right.time,
    right.diagnosticError,
    right.diagnosticWarn,
    right.diagnosticHint,
    right.diagnosticInfo,
    right.lspstatus,
    right.nlsstatus,
    right.autosave,
    right.codeium,
    right.lazystatus,
    right.fileindent,
    right.fileformat,
    right.lineratio,
    right.lineinfo,
    separator.separator,
  },
}

local specialline = {
  left = {
    separator.separator,
    left.mode,
  },
  mid = {},
  right = {
    right.date,
    right.time,
    separator.separator,
  },
}

local highlights = {
  mid = function() return { fg = utils.get_hl("StatusLine").fg, bg = utils.get_hl("StatusLine").bg } end,
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
  highlights = highlights,
  statusline = statusline,
  specialline = specialline,
  specialtypes = specialtypes,
  refresh = refresh,
  handle_update = handle_update,
}

return M
