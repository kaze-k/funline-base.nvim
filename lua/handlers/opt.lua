local opt = vim.opt
local fn = vim.fn
local v = vim.v

local M = {}

function M.get_search() return fn.getreg("/") end

function M.get_search_count()
  local search_count = fn.searchcount({
    recompute = 1,
    maxcount = -1,
  })

  return search_count.current, search_count.total
end

function M.is_hlsearch() return v.hlsearch == 1 end

function M.has_spell() return opt.spell:get() end

function M.spell()
  local spelllang = opt.spelllang:get()

  if type(spelllang) == "table" then
    if vim.tbl_count(spelllang) > 2 then
      return string.format("%s...", spelllang[1])
    end

    return string.format("%s", table.concat(spelllang, ","))
  elseif type(spelllang) == "string" then
    return spelllang
  else
    return ""
  end
end

function M.get_reg_executing() return fn.reg_executing() end

function M.get_reg_recording() return fn.reg_recording() end

function M.is_macro() return M.get_reg_recording() ~= "" or M.get_reg_recording() ~= "" end

return M
