local colors = require("themes.vanilla.colors")
local utils = require("funline-base.utils")

local M = {}

M.search = function()
  local search_count
  if vim.v.hlsearch == 1 then
    search_count = vim.fn.searchcount({
      recompute = 1,
      maxcount = -1,
    })
    if not search_count.total then
      search_count.total = 0
    end
    if not search_count.current then
      search_count.current = 0
    end
    local search_term = vim.fn.getreg("/")

    local formated_str = string.format("%s[%d/%d]", search_term, search_count.current, search_count.total)
    local search_str = utils.widen_condition(140) and formated_str or search_term

    local icon = ""
    if vim.fn.getcmdtype() == "/" then
      icon = ""
    elseif vim.fn.getcmdtype() == "?" then
      icon = ""
    end

    return {
      condition = search_count.total > 0,
      icon = icon,
      provider = search_str,
      hl = { fg = colors.light_yellow, bg = colors.hl("StatusLine", "bg") },
    }
  end
end

local function spell_toString(str)
  if not utils.widen_condition(140) then
    return
  end

  if type(str) == "table" then
    if #str > 2 then
      return string.format("%s...", str[1])
    end

    return string.format("%s", table.concat(str, ","))
  else
    return str
  end
end

M.spell = function()
  local spelllang = vim.opt.spelllang:get()

  return {
    condition = vim.opt.spell:get(),
    icon = "󰓆",
    provider = spell_toString(spelllang),
    padding_left = " ",
    hl = { fg = colors.red, bg = colors.hl("StatusLine", "bg") },
  }
end

return M
