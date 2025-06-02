local handlers = require("handlers")
local utils = require("helper.utils")
local colors = require("helper.colors")
local spinners = require("helper.spinners")

local M = {}

local padding = { left = " " }

local lsp_loading = utils.get_loading(100, spinners.arc)
local nls_loading = utils.get_loading(100, spinners.arc)
local windsurf_loading = utils.get_loading(100, spinners.circle)

M.search = function()
  local icons = {
    default = "",
    ["/"] = "",
    ["?"] = "",
  }

  if handlers.opt.is_hlsearch() then
    local search_count = handlers.opt.get_search_count()
    local search_term = handlers.opt.get_search()
    local formated_str = string.format("%s[%d/%d]", search_term, search_count.current, search_count.total)

    return {
      condition = search_count.total > 0,
      icon = icons[vim.fn.getcmdtype():sub(1, 1)] or icons.default,
      provider = utils.is_widen_condition(140) and formated_str or search_term,
      padding = padding,
      hl = { fg = colors.light_yellow, bg = utils.get_hl("StatusLine").bg },
    }
  end
end

M.spell = function()
  return {
    condition = handlers.opt.is_spell(),
    icon = "󰓆",
    provider = utils.is_widen_condition(140) and handlers.opt.get_spelllang(),
    padding = padding,
    hl = { fg = colors.red, bg = utils.get_hl("StatusLine").bg },
  }
end

M.date = function()
  return {
    condition = utils.is_widen_condition(140),
    icon = "",
    provider = handlers.datetime.get_date(),
    padding = padding,
    hl = { fg = colors.yellow, bg = utils.get_hl("StatusLine").bg },
  }
end

M.time = function()
  local icons = { "", "", "", "", "", "", "", "", "", "", "", "" }

  return {
    icon = handlers.datetime.get_time_icon(icons),
    provider = handlers.datetime.get_time(),
    padding = padding,
    hl = { fg = colors.yellow, bg = utils.get_hl("StatusLine").bg },
  }
end

M.diagnosticError = function()
  return {
    condition = handlers.lsp.is_diagnostics_exist("ERROR"),
    icon = "",
    provider = handlers.lsp.get_diagnostics_count("ERROR"),
    padding = padding,
    hl = { fg = colors.red, bg = utils.get_hl("StatusLine").bg },
  }
end

M.diagnosticWarn = function()
  return {
    condition = handlers.lsp.is_diagnostics_exist("WARN"),
    icon = "",
    provider = handlers.lsp.get_diagnostics_count("WARN"),
    padding = padding,
    hl = { fg = colors.light_orange, bg = utils.get_hl("StatusLine").bg },
  }
end

M.diagnosticHint = function()
  return {
    condition = handlers.lsp.is_diagnostics_exist("HINT"),
    icon = "󰌶",
    provider = handlers.lsp.get_diagnostics_count("HINT"),
    padding = padding,
    hl = { fg = colors.light_cyan, bg = utils.get_hl("StatusLine").bg },
  }
end

M.diagnosticInfo = function()
  return {
    condition = handlers.lsp.is_diagnostics_exist("INFO"),
    icon = "",
    provider = handlers.lsp.get_diagnostics_count("INFO"),
    padding = padding,
    hl = { fg = colors.light_blue, bg = utils.get_hl("StatusLine").bg },
  }
end

M.lspstatus = function(ctx)
  local icons = {
    normal = "󰘽",
    widen = "",
  }

  local lsp_clients = handlers.lsp.get_lsp_client_names_with_ignore({ "null-ls" })
  local pending = handlers.lsp.is_lsp_progress_pending({ "null-ls" })
  local provider_str = string.format("[%s]", table.concat(lsp_clients.lsp, ", "))

  if pending then
    ctx.refresh(100)
  else
    ctx.done()
  end

  return {
    condition = handlers.lsp.is_lsp_attached(),
    icon = pending and lsp_loading() or (utils.is_widen_condition(140) and icons.widen or icons.normal),
    provider = utils.is_widen_condition(140) and provider_str or "LSP",
    padding = padding,
    hl = { fg = colors.cyan, bg = utils.get_hl("StatusLine").bg },
  }
end

M.nlsstatus = function(ctx)
  local pending = handlers.lsp.is_null_ls_progress_pending()

  if pending then
    ctx.refresh(100)
  else
    ctx.done()
  end

  return {
    condition = handlers.lsp.is_lsp_attached("null-ls"),
    icon = pending and nls_loading() or "",
    provider = "NLS",
    padding = padding,
    hl = { fg = colors.cyan, bg = utils.get_hl("StatusLine").bg },
  }
end

M.autosave = function()
  local icons = {
    on = " ",
    off = " ",
  }

  return {
    condition = handlers.plugins.is_autosave_exists(),
    icon = handlers.plugins.get_autosave_status() and icons.on or icons.off,
    padding = padding,
    hl = { fg = colors.light_cyan, bg = utils.get_hl("StatusLine").bg },
  }
end

M.lazystatus = function()
  return {
    condition = handlers.plugins.is_lazy_exists(),
    provider = handlers.plugins.get_lazy_updates(),
    padding = padding,
    hl = { fg = colors.yellow, bg = utils.get_hl("StatusLine").bg },
  }
end

M.windsurf = function(ctx)
  local icons = {
    ["ON"] = "󱙺 ",
    ["OFF"] = "󱙻 ",
    ["EMPTY"] = "󱚠",
    ["NONE"] = "󱚡 ",
    ["NORMAL"] = "󰘦",
  }

  local tag, status = handlers.plugins.get_windsurf_status()

  if tag == "LOADING" then
    ctx.refresh(100)
  else
    ctx.done()
  end

  return {
    condition = handlers.plugins.is_windsurf_exists(),
    icon = tag == "LOADING" and string.format("%s ", windsurf_loading()) or icons[tag],
    provider = status,
    padding = padding,
    hl = { fg = colors.turquoise, bg = utils.get_hl("StatusLine").bg },
  }
end

M.fileindent = function()
  return {
    condition = utils.is_widen_condition(140),
    provider = handlers.file.get_file_indent(),
    padding = padding,
    hl = { fg = colors.pink, bg = utils.get_hl("StatusLine").bg },
  }
end

M.filetype = function()
  return {
    icon = "󱑼",
    condition = utils.is_widen_condition(140),
    provider = handlers.file.get_filetype(),
    padding = padding,
    hl = { fg = colors.green, bg = utils.get_hl("StatusLine").bg },
  }
end

M.fileformat = function()
  local icons = {
    unix = "",
    dos = "",
    mac = "",
  }

  local providers = {
    unix = "LF",
    dos = "CRLF",
    mac = "CR",
  }

  local file_format = handlers.file.get_file_format()

  return {
    icon = icons[file_format],
    provider = providers[file_format],
    padding = padding,
    hl = { fg = colors.pink, bg = utils.get_hl("StatusLine").bg },
  }
end

M.lineratio = function()
  local icons = {
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

  local line_ratio = handlers.file.get_line_ratio()

  return {
    condition = utils.is_widen_condition(140),
    icon = handlers.file.get_position(icons.top, icons.bottom, icons[math.ceil(line_ratio / #icons)]),
    provider = handlers.file.get_position("TOP", "BOT", string.format("%s%%", tostring(line_ratio))),
    padding = padding,
    hl = { fg = colors.light_green, bg = utils.get_hl("StatusLine").bg },
  }
end

M.lineinfo = function()
  return {
    icon = "",
    provider = string.format(
      "%d:%d[%d]",
      handlers.file.get_current_col(),
      handlers.file.get_current_line(),
      handlers.file.get_total_line()
    ),
    padding = padding,
    hl = { fg = colors.pink, bg = utils.get_hl("StatusLine").bg, bold = true },
  }
end

return M
