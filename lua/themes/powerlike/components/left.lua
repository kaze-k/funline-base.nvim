local handlers = require("handlers")
local utils = require("helper.utils")
local mode_icons = require("helper.mode_icons")
local colors = require("helper.colors")

local M = {}

local padding = { right = " " }

M.mode = function()
  return {
    icon = handlers.mode.get_mode_icon(mode_icons),
    provider = handlers.mode.get_vim_mode(),
    padding = padding,
    hl = { fg = utils.get_hl("StatusLineNC").bg, bg = handlers.mode.get_mode_color(colors.mode_colors), bold = true },
  }
end

M.macro = function()
  return {
    condition = handlers.opt.is_macro(),
    icon = "",
    provider = handlers.opt.get_macro(),
    padding = padding,
    hl = {
      fg = handlers.opt.get_macro_color(colors.light_red, colors.light_green),
      bg = utils.get_hl("StatusLine").bg,
      bold = true,
    },
  }
end

M.gitbranch = function()
  return {
    condition = handlers.git.is_git_dir(),
    icon = "",
    provider = utils.is_match_buftype("nofile") and handlers.git.get_global_git_branch()
      or handlers.git.get_buf_git_branch(),
    padding = padding,
    hl = { fg = colors.green, bg = utils.get_hl("StatusLine").bg },
  }
end

M.gitadd = function()
  return {
    condition = handlers.git.is_git_added_exists(),
    icon = "",
    provider = handlers.git.get_git_added(),
    padding = padding,
    hl = { fg = colors.light_green, bg = utils.get_hl("StatusLine").bg },
  }
end

M.gitchange = function()
  return {
    condition = handlers.git.is_git_changed_exists(),
    icon = "",
    provider = handlers.git.get_git_changed(),
    padding = padding,
    hl = { fg = colors.orange, bg = utils.get_hl("StatusLine").bg },
  }
end

M.gitremove = function()
  return {
    condition = handlers.git.is_git_removed_exists(),
    icon = "",
    provider = handlers.git.get_git_removed(),
    padding = padding,
    hl = { fg = colors.red, bg = utils.get_hl("StatusLine").bg },
  }
end

M.fileicon = function()
  local icon, color = handlers.file.get_file_icon_and_color()

  return {
    condition = handlers.file.is_file_icon_exists(),
    icon = icon,
    padding = padding,
    hl = { fg = color, bg = utils.get_hl("StatusLine").bg },
  }
end

M.filename = function()
  local hls = {
    normal = { fg = utils.get_hl("StatusLine").fg, bg = utils.get_hl("StatusLine").bg },
    readonly = { fg = colors.light_red, bg = utils.get_hl("StatusLine").bg, bold = true },
    modified = { fg = utils.get_hl("StatusLine").fg, bg = utils.get_hl("StatusLine").bg, bold = true, italic = true },
  }

  local file_status = handlers.file.get_file_status()

  return {
    condition = handlers.file.is_filname_exists(),
    provider = handlers.file.get_filename(),
    padding = padding,
    hl = hls[file_status],
  }
end

M.filemark = function()
  local hls = {
    normal = { fg = utils.get_hl("StatusLine").fg, bg = utils.get_hl("StatusLine").bg, bold = true },
    help = { fg = colors.light_yellow, bg = utils.get_hl("StatusLine").bg, bold = true },
    readonly = { fg = colors.light_red, bg = utils.get_hl("StatusLine").bg, bold = true },
    modified = { fg = colors.light_green, bg = utils.get_hl("StatusLine").bg, bold = true },
  }

  local icons = {
    help = "󰋗",
    readonly = "",
    modified = "[+]",
  }

  local file_status = handlers.file.get_file_status()

  return {
    condition = handlers.file.is_filname_exists() and handlers.file.is_file_status(),
    icon = icons[file_status],
    padding = padding,
    hl = hls[file_status],
  }
end

M.session = function()
  return {
    condition = handlers.plugins.is_session_exists(),
    icon = "",
    provider = handlers.plugins.get_session_name(),
    padding = padding,
    hl = { fg = colors.blue, bg = utils.get_hl("StatusLine").bg },
  }
end

M.lightbulb = function()
  return {
    condition = handlers.plugins.is_lightbulb_exists(),
    icon = handlers.plugins.get_lightbulb_status(),
    padding = padding,
    hl = { fg = colors.blue, bg = utils.get_hl("StatusLine").bg },
  }
end

return M
