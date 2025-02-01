local M = {}

local components = require("themes.arc.components")

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
    separator.aroundLeft,
  },
  mid = {},
  right = {
    separator.aroundRight,
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
    separator.aroundLeft,
  },
  mid = {},
  right = {
    separator.aroundRight,
    right.date,
    right.time,
    separator.separator,
  },
}

local highlights = {
  mid = { fg = "NONE", bg = "NONE" },
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
  statusline = statusline,
  specialline = specialline,
  highlights = highlights,
  specialtypes = specialtypes,
  refresh = refresh,
  handle_update = handle_update,
}

return M
