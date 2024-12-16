local colors = require("theme.vanilla.colors")

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

local spinners = { "◜", "◠", "◝", "◞", "◡", "◟" }
local index = 0
local last_time = vim.uv.now()
local last_spinner = nil
local function loading()
  local current_time = vim.uv.now()

  if current_time - last_time >= interval.main then
    last_time = current_time
    index = index + 1
    if index > #spinners then
      index = 1
    end
    last_spinner = spinners[index]
    return spinners[index]
  end
  return last_spinner
end

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

M.lspstatus = {
  condition = function()
    local lsp_clients = get_lsp_clients({ "null-ls" })

    if next(lsp_clients.lsp) == nil then
      return false
    end

    return true
  end,
  icon = function()
    local pending = get_lsp_pending({ "null-ls" })
    local bufnr = vim.api.nvim_get_current_buf()
    local winwidth = vim.fn.winwidth(bufnr)

    if vim.o.laststatus == 3 then
      winwidth = vim.o.columns
    end

    if pending then
      return loading()
    end

    if winwidth > widen_width then
      return icon.widen
    end

    return icon.normal
  end,
  provider = function()
    local lsp_clients = get_lsp_clients({ "null-ls" })
    local bufnr = vim.api.nvim_get_current_buf()
    local winwidth = vim.fn.winwidth(bufnr)

    if vim.o.laststatus == 3 then
      winwidth = vim.o.columns
    end

    if winwidth > widen_width then
      return string.format("[%s]", table.concat(lsp_clients.lsp, ", "))
    end

    return provider.lsp
  end,
  hl = { fg = "#8be9fd", bg = colors.bg, bold = true },
  interval = function()
    local pending = get_lsp_pending({ "null-ls" })

    if pending then
      return interval.main
    end

    return interval.init
  end,
}

M.nlsstatus = {
  condition = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({
      name = "null-ls",
      bufnr = bufnr,
    })

    if next(clients) == nil then
      return false
    end

    for _, client in ipairs(clients) do
      if client.name ~= "null-ls" then
        return false
      end
    end

    return true
  end,
  icon = icon.nls,
  provider = provider.nls,
  hl = { fg = "#8be9fd", bg = colors.bg, bold = true },
}

return M