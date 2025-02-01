local providers = require("helper.providers")
local utils = require("helper.utils")

local colors = require("themes.vanilla.colors")

local M = {}

local padding = { left = " " }

local interval = 100

local loading = utils.get_loading(interval)

local search_icons = {
  default = "",
  ["/"] = "",
  ["?"] = "",
}

M.search = function()
  if vim.v.hlsearch == 1 then
    local search_count, search_term, formated_str = providers.get_search()

    return {
      condition = search_count.total > 0,
      icon = search_icons[vim.fn.getcmdtype():sub(1, 1)] or search_icons.default,
      provider = utils.widen_condition(140) and formated_str or search_term,
      padding = padding,
      hl = { fg = colors.light_yellow, bg = utils.get_hl("StatusLine").bg },
    }
  end
end

M.spell = function()
  local spelllang = vim.opt.spelllang:get()

  return {
    condition = vim.opt.spell:get(),
    icon = "󰓆",
    provider = utils.widen_condition(140) and providers.spell_toString(spelllang),
    padding = padding,
    hl = { fg = colors.red, bg = utils.get_hl("StatusLine").bg },
  }
end

local time_icons = { "", "", "", "", "", "", "", "", "", "", "", "" }

M.date = function()
  local date = os.date("%Y-%m-%d")

  return {
    condition = utils.widen_condition(140),
    icon = "",
    provider = date,
    padding = padding,
    hl = { fg = colors.yellow, bg = utils.get_hl("StatusLine").bg },
  }
end

M.time = function()
  local time = os.date("%H:%M:%S")
  local hour = tonumber(os.date("%H"))
  local icon
  if 0 <= hour and hour <= 11 then
    icon = time_icons[hour + 1]
  else
    icon = time_icons[(hour - 12) + 1]
  end

  return {
    icon = icon,
    provider = time,
    padding = padding,
    hl = { fg = colors.yellow, bg = utils.get_hl("StatusLine").bg },
  }
end

M.diagnosticError = function()
  return {
    condition = #providers.get_diagnostic("ERROR") > 0,
    icon = "",
    provider = #providers.get_diagnostic("ERROR"),
    padding = padding,
    hl = { fg = colors.red, bg = utils.get_hl("StatusLine").bg },
  }
end

M.diagnosticWarn = function()
  return {
    condition = #providers.get_diagnostic("WARN") > 0,
    icon = "",
    provider = #providers.get_diagnostic("WARN"),
    padding = padding,
    hl = { fg = colors.light_orange, bg = utils.get_hl("StatusLine").bg },
  }
end

M.diagnosticHint = function()
  return {
    condition = #providers.get_diagnostic("HINT") > 0,
    icon = "󰌶",
    provider = #providers.get_diagnostic("HINT"),
    padding = padding,
    hl = { fg = colors.light_cyan, bg = utils.get_hl("StatusLine").bg },
  }
end

M.diagnosticInfo = function()
  return {
    condition = #providers.get_diagnostic("INFO") > 0,
    icon = "",
    provider = #providers.get_diagnostic("INFO"),
    padding = padding,
    hl = { fg = colors.light_blue, bg = utils.get_hl("StatusLine").bg },
  }
end

local lsp_icon = {
  normal = "󰘽",
  widen = "",
}

M.lspstatus = function(ctx)
  local widen_width = 140

  local lsp_clients = providers.get_lsp_clients({ "null-ls" })
  local pending = providers.get_lsp_pending({ "null-ls" })
  local bufnr = vim.api.nvim_get_current_buf()
  local winwidth = vim.o.laststatus == 3 and vim.o.columns or vim.fn.winwidth(bufnr)
  local provider_str = string.format("[%s]", table.concat(lsp_clients.lsp, ", "))

  if pending then
    ctx.refresh(interval)
  else
    ctx.done()
  end

  return {
    condition = next(lsp_clients.lsp) ~= nil,
    icon = pending and loading() or (winwidth > widen_width and lsp_icon.widen or lsp_icon.normal),
    provider = winwidth > widen_width and provider_str or "LSP",
    padding = padding,
    hl = { fg = colors.cyan, bg = utils.get_hl("StatusLine").bg },
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
    icon = "",
    provider = "NLS",
    padding = padding,
    hl = { fg = colors.cyan, bg = utils.get_hl("StatusLine").bg },
  }
end

local autosave_icons = {
  autosave_on = " ",
  autosave_off = " ",
}

M.autosave = function()
  local plugins = require("lazy.core.config").plugins
  local hl = { fg = colors.light_cyan, bg = utils.get_hl("StatusLine").bg }
  local autoSave = vim.g.loaded_auto_save

  return {
    condition = plugins and plugins["auto-save.nvim"] and plugins["auto-save.nvim"]._.loaded,
    icon = autoSave and autosave_icons.autosave_on or autosave_icons.autosave_off,
    padding = padding,
    hl = hl,
  }
end

M.lazystatus = function()
  local lazyStatus = require("lazy.status")
  return {
    condition = lazyStatus.updates(),
    provider = lazyStatus.updates(),
    padding = padding,
    hl = { fg = colors.yellow, bg = utils.get_hl("StatusLine").bg },
  }
end

local codeium_icons = {
  on = "󱙺 ",
  off = "󱙻 ",
  none = "󱚠 ",
  codeium = "󰘦",
}

M.codeium = function(ctx)
  local plugins = require("lazy.core.config").plugins
  local icon
  local provider
  local status = plugins
      and plugins["codeium.vim"]
      and plugins["codeium.vim"]._.loaded
      and vim.fn["codeium#GetStatusString"]()
    or ""

  if status == string.match(status, "^%s%*%s$") then
    ctx.refresh(interval)
  else
    ctx.done()
  end

  if status == string.match(status, "^%sON$") then
    icon = codeium_icons.on
    provider = ""
  elseif status == "OFF" then
    icon = codeium_icons.off
    provider = ""
  elseif status == string.match(status, "^%s%*%s$") then
    icon = loading()
    provider = ""
  elseif status == string.match(status, "^%s0%s$") then
    icon = codeium_icons.codeium
    provider = "0/0"
  elseif status == string.match(status, "^%s%s%s$") then
    icon = codeium_icons.none
    provider = ""
  else
    icon = codeium_icons.codeium
    provider = status
  end

  return {
    condition = plugins and plugins["codeium.vim"] and plugins["codeium.vim"]._.loaded,
    icon = icon,
    provider = provider,
    padding = padding,
    hl = { fg = colors.turquoise, bg = utils.get_hl("StatusLine").bg },
  }
end

M.fileindent = function()
  return {
    condition = utils.widen_condition(140),
    provider = string.format("SPC:%s", vim.bo.shiftwidth),
    padding = padding,
    hl = { fg = colors.pink, bg = utils.get_hl("StatusLine").bg },
  }
end

local fileformat_icons = {
  linux = "",
  windows = "",
  mac = "",
}

M.fileformat = function()
  local icon
  local provider

  if vim.bo.fileformat:upper() == "UNIX" then
    icon = fileformat_icons.linux
    provider = "LF"
  elseif vim.bo.fileformat:upper() == "DOS" then
    icon = fileformat_icons.windows
    provider = "CRLF"
  elseif vim.bo.fileformat:upper() == "MAC" then
    icon = fileformat_icons.mac
    provider = "CR"
  end

  return {
    icon = icon,
    provider = provider,
    padding = padding,
    hl = { fg = colors.pink, bg = utils.get_hl("StatusLine").bg },
  }
end

local line_ratio_icons = {
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  top = "",
  bottom = "",
}

M.lineratio = function()
  local line_ratio = providers.get_line_ratio()
  local icon = providers.col(
    line_ratio_icons.top,
    line_ratio_icons.bottom,
    line_ratio_icons[math.ceil(line_ratio / #line_ratio_icons)]
  )
  local provider = providers.col("TOP", "BOT", string.format("%s%%", tostring(line_ratio)))

  return {
    condition = utils.widen_condition(140),
    icon = icon,
    provider = provider,
    padding = padding,
    hl = { fg = colors.light_green, bg = utils.get_hl("StatusLine").bg },
  }
end

M.lineinfo = function()
  return {
    icon = "",
    provider = string.format("%d:%d[%d]", vim.fn.col("."), vim.fn.line("."), vim.fn.line("$")),
    padding = padding,
    hl = { fg = colors.pink, bg = utils.get_hl("StatusLine").bg, bold = true },
  }
end

return M
