local M = {}

function M.get_search()
  local search_count = vim.fn.searchcount({
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

  return search_count, search_term, formated_str
end

function M.is_hlsearch() return vim.v.hlsearch == 1 end

return M
