local devicons = require("nvim-web-devicons")

local M = {}

function M.get_diagnostic(severity)
  return vim.diagnostic.get(0, {
    severity = vim.diagnostic.severity[severity],
  })
end

function M.get_current_line() return vim.api.nvim_win_get_cursor(0)[1] end

function M.get_total_line() return vim.api.nvim_buf_line_count(0) end

function M.get_line_ratio()
  local current_line = M.get_current_line()
  local total_line = M.get_total_line()
  local line_ratio = (current_line / total_line) * 100
  line_ratio = math.ceil(line_ratio)
  if line_ratio == 100 then
    line_ratio = math.floor(line_ratio - 1)
  end
  return line_ratio
end

function M.col(top, bottom, ratio)
  local position
  local current_line = M.get_current_line()
  local total_line = M.get_total_line()

  if current_line == 1 then
    position = top
  elseif current_line == total_line then
    position = bottom
  else
    position = string.format("%s", ratio)
  end
  return position
end

function M.filetype_is_help() return vim.bo.filetype == "help" end

function M.buffer_is_modified() return vim.bo.modifiable and vim.bo.modified end

function M.get_icon_and_color()
  local filename = vim.fn.expand("%:t")
  local ext = vim.fn.expand("%:e")
  return devicons.get_icon_color(filename, ext, { default = true })
end

function M.get_lsp_clients(ignore_clients)
  local lsp_clients = {}
  local lsp = {}
  local ignore_lsp = {}
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({
    bufnr = bufnr,
  })

  if next(clients) == nil then
    lsp_clients = {
      lsp = lsp,
      ignore_lsp = ignore_lsp,
    }
    return lsp_clients
  end

  for _, client in ipairs(clients) do
    for _, ignore in ipairs(ignore_clients) do
      if client.name ~= ignore then
        table.insert(lsp, client.name)
      else
        table.insert(ignore_lsp, client.name)
      end
    end
  end

  lsp_clients = {
    lsp = lsp,
    ignore_lsp = ignore_lsp,
  }
  return lsp_clients
end

function M.get_lsp_pending(ignore_clients)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({
    bufnr = bufnr,
  })

  if next(clients) == nil then
    return false
  end

  for _, client in ipairs(clients) do
    for _, ignore in ipairs(ignore_clients) do
      if client.name ~= ignore then
        if vim.tbl_count(client.progress.pending) ~= 0 then
          return true
        end
      end
    end
  end

  return false
end

function M.get_search()
  local search_count

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

  return search_count, search_term, formated_str
end

function M.spell_toString(str)
  if type(str) == "table" then
    if #str > 2 then
      return string.format("%s...", str[1])
    end

    return string.format("%s", table.concat(str, ","))
  else
    return str
  end
end

return M
