local M = {}

local lsp = vim.lsp
local diagnostic = vim.diagnostic

local function get_current_buf_lsp(name)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = lsp.get_clients({
    name = name,
    bufnr = bufnr,
  })
  return clients
end

function M.get_diagnostics_count(severity)
  return vim.tbl_count(diagnostic.get(0, severity and {
    severity = severity,
  }))
end

function M.diagnostics_exist(severity) return M.get_diagnostics_count(severity) > 0 end

function M.is_lsp_attached(name)
  local clients = get_current_buf_lsp(name)
  return next(clients) ~= nil
end

function M.lsp_client_names()
  local client_names = {}

  local clients = get_current_buf_lsp()

  for _, client in pairs(clients) do
    table.insert(client_names, client.name)
  end

  return client_names
end

function M.get_lsp_client_count() return vim.tbl_count(M.lsp_client_names()) end

function M.lsp_client_names_with_ignore(ignore_clients)
  local all_lsp_client_names = {}
  local lsp_client_names = {}
  local ignore_lsp_client_names = {}

  local clients = get_current_buf_lsp()

  if next(clients) == nil then
    all_lsp_client_names = {
      lsp = lsp_client_names,
      ignore_lsp = ignore_lsp_client_names,
    }
    return all_lsp_client_names
  end

  for _, client in ipairs(clients) do
    for _, ignore_client_name in ipairs(ignore_clients) do
      if client.name ~= ignore_client_name then
        table.insert(lsp_client_names, client.name)
      else
        table.insert(ignore_lsp_client_names, client.name)
      end
    end
  end

  all_lsp_client_names = {
    lsp = lsp_client_names,
    ignore_lsp = ignore_lsp_client_names,
  }
  return all_lsp_client_names
end

function M.get_lsp_client_count_with_ignore(ignore_clients)
  local lsp_client_names = M.lsp_client_names_with_ignore(ignore_clients)
  return vim.tbl_count(lsp_client_names.lsp)
end

function M.is_lsp_progress_pending(ignore_clients)
  local clients = get_current_buf_lsp()

  if next(clients) == nil then
    return false
  end

  for _, client in ipairs(clients) do
    for _, ignore_client in ipairs(ignore_clients) do
      if client.name ~= ignore_client and #client.progress.pending ~= 0 then
        return true
      end
    end
  end

  return false
end

function M.is_null_ls_progress_pending()
  local clients = get_current_buf_lsp("null-ls")

  if next(clients) == nil then
    return false
  end

  for _, client in ipairs(clients) do
    if #client.progress.pending ~= 0 then
      return true
    end
  end

  return false
end

return M
