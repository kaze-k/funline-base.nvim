local colors = require("themes.vanilla.colors")
local utils = require("funline-base.utils")

local M = {}

local icon = {
  normal = "󰘽",
  widen = "",
  nls = "",
}

local provider = {
  lsp = "LSP",
  nls = "NLS",
}

local interval = {
  init = 0,
  main = 100,
}

local widen_width = 140

local loading = utils.get_loading(interval.main)

local function get_lsp_clients(ignore_clients)
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

local function get_lsp_pending(ignore_clients)
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
        if #client.progress.pending ~= 0 then
          return true
        end
      end
    end
  end

  return false
end

M.lspstatus = function(ctx)
  local lsp_clients = get_lsp_clients({ "null-ls" })
  local pending = get_lsp_pending({ "null-ls" })
  local bufnr = vim.api.nvim_get_current_buf()
  local winwidth = vim.o.laststatus == 3 and vim.o.columns or vim.fn.winwidth(bufnr)
  local provider_str = string.format("[%s]", table.concat(lsp_clients.lsp, ", "))

  if pending then
    ctx.refresh(interval.main)
  else
    ctx.done()
  end

  return {
    condition = next(lsp_clients.lsp) ~= nil,
    icon = pending and loading() or (winwidth > widen_width and icon.widen or icon.normal),
    provider = winwidth > widen_width and provider_str or provider.lsp,
    padding_left = " ",
    hl = { fg = colors.cyan, bg = colors.hl("StatusLine", "bg") },
  }
end

M.nlsstatus = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({
    name = "null-ls",
    bufnr = bufnr,
  })

  return {
    condition = next(clients) ~= nil,
    icon = icon.nls,
    provider = provider.nls,
    padding_left = " ",
    hl = { fg = colors.cyan, bg = colors.hl("StatusLine", "bg") },
  }
end

return M
