local colors = require("theme.vanilla.colors")

local M = {}

local function spell_toString(str)
  if type(str) == "table" then
    if #str > 2 then
      return string.format("%s...", str[1])
    end

    return string.format("%s", table.concat(str, ","))
  else
    return str
  end
end

M.Spell = {
  condition = function() return vim.opt.spell:get() end,
  icon = "󰓆",
  provider = function()
    local spelllange = vim.opt.spelllang:get()
    return spell_toString(spelllange)
  end,
  hl = { fg = "#ff5555", bg = colors.bg, bold = true },
}

M.Search = {
  condition = function()
    local search_count = vim.fn.searchcount({
      recompute = 1,
      maxcount = -1,
    })
    local active_result = vim.v.hlsearch == 1 and search_count.total > 0
    if active_result then
      return true
    end
    return false
  end,
  icon = "",
  provider = function()
    local squeeze_width = vim.fn.winwidth(0)
    local search_term = vim.fn.getreg("/")
    local search_count = vim.fn.searchcount({
      recompute = 1,
      maxcount = -1,
    })

    if vim.o.laststatus == 3 then
      squeeze_width = vim.o.columns
    end

    if squeeze_width > 140 then
      return string.format("%s[%d/%d]", search_term, search_count.current, search_count.total)
    else
      return search_term
    end
  end,
  hl = { fg = "#f1fa8c", bg = colors.bg, bold = true },
}

return M
