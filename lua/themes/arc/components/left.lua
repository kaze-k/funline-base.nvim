local handlers = require("handlers")
local providers = require("helper.providers")
local utils = require("helper.utils")

local colors = require("themes.arc.colors")

local M = {}

local padding = { right = " " }

local mode_icons = {
  ["n"] = "",
  ["niI"] = "",
  ["niR"] = "",
  ["niV"] = "",
  ["no"] = "",
  ["nov"] = "",
  ["noV"] = "",
  ["no"] = "",
  ["v"] = "",
  ["vs"] = "",
  ["V"] = "",
  ["Vs"] = "",
  [""] = "",
  ["s"] = "",
  [""] = "",
  ["s"] = "",
  ["S"] = "",
  ["i"] = "󰛿",
  ["ic"] = "󰛿",
  ["ix"] = "󰛿",
  ["R"] = "󰬲",
  ["Rc"] = "󰬲",
  ["Rv"] = "󰬲",
  ["Rx"] = "󰬲",
  ["c"] = "󰊠",
  ["cv"] = "󰊠",
  ["ce"] = "󰊠",
  ["r"] = "",
  ["rm"] = "",
  ["r?"] = "",
  ["!"] = "",
  ["t"] = "",
  ["nt"] = "",
  ["null"] = "󰟢",
}

M.mode = function()
  return {
    icon = handlers.mode.mode_icon(mode_icons),
    provider = handlers.mode.vim_mode(),
    padding = padding,
    hl = {
      fg = handlers.mode.mode_color(colors.mode_colors),
      bg = utils.get_hl("StatusLine").bg,
      bold = true,
      italic = true,
    },
  }
end

M.macro = function()
  local recording = handlers.opt.get_reg_recording()
  local executing = handlers.opt.get_reg_executing()

  return {
    condition = handlers.opt.is_macro(),
    icon = "",
    provider = recording ~= "" and recording or executing,
    padding = padding,
    hl = {
      fg = recording ~= "" and colors.light_red or colors.light_green,
      bg = utils.get_hl("StatusLine").bg,
      bold = true,
    },
  }
end

M.gitbranch = function()
  return {
    condition = handlers.git.is_git_dir(),
    icon = "",
    provider = utils.buftype_is_nofile() and handlers.git.get_global_git_branch() or handlers.git.get_buf_git_branch(),
    padding = padding,
    hl = { fg = colors.green, bg = utils.get_hl("StatusLine").bg },
  }
end

M.gitadd = function()
  return {
    condition = handlers.git.git_added_exists(),
    icon = "",
    provider = handlers.git.git_added(),
    padding = padding,
    hl = { fg = colors.light_green, bg = utils.get_hl("StatusLine").bg },
  }
end

M.gitchange = function()
  return {
    condition = handlers.git.git_changed_exists(),
    icon = "",
    provider = handlers.git.git_changed(),
    padding = padding,
    hl = { fg = colors.orange, bg = utils.get_hl("StatusLine").bg },
  }
end

M.gitremove = function()
  return {
    condition = handlers.git.git_removed_exists(),
    icon = "",
    provider = handlers.git.git_removed(),
    padding = padding,
    hl = { fg = colors.red, bg = utils.get_hl("StatusLine").bg },
  }
end

M.fileicon = function()
  local icon, color = handlers.file.get_file_icon_and_color()

  return {
    condition = not utils.buffer_is_empty(handlers.file.get_file_extension())
      and not utils.match_buftype("nofile")
      and not utils.match_buftype("prompt"),
    icon = icon,
    padding = padding,
    hl = { fg = color, bg = utils.get_hl("StatusLine").bg },
  }
end

M.filename = function()
  local hl = { fg = utils.get_hl("StatusLine").fg, bg = utils.get_hl("StatusLine").bg }
  if utils.buffer_is_readonly() and not providers.filetype_is_help() then
    hl = { fg = colors.light_red, bg = utils.get_hl("StatusLine").bg, bold = true }
  end
  if providers.buffer_is_modified() then
    hl = { fg = utils.get_hl("StatusLine").fg, bg = utils.get_hl("StatusLine").bg, bold = true, italic = true }
  end

  return {
    condition = not utils.buffer_is_empty(handlers.file.get_file_extension()) and not utils.buftype_is_nofile(),
    provider = vim.fn.expand("%:t"),
    padding = padding,
    hl = hl,
  }
end

local icons = {
  modified = "",
  readonly = "",
  help = "󰋗",
}

M.filemark = function()
  local icon
  local hl = { fg = utils.get_hl("StatusLine").fg, bg = utils.get_hl("StatusLine").bg, bold = true }
  if vim.bo.filetype == "help" then
    icon = icons.help
    hl = { fg = colors.light_yellow, bg = utils.get_hl("StatusLine").bg, bold = true }
  elseif utils.buffer_is_readonly() and not providers.filetype_is_help() then
    icon = icons.readonly
    hl = { fg = colors.light_red, bg = utils.get_hl("StatusLine").bg, bold = true }
  elseif providers.buffer_is_modified() then
    icon = icons.modified
    hl = { fg = colors.light_green, bg = utils.get_hl("StatusLine").bg, bold = true }
  end

  local condition = not utils.buffer_is_empty(handlers.file.get_file_extension())
    and (providers.filetype_is_help() or utils.buffer_is_readonly() or providers.buffer_is_modified())

  return {
    condition = condition,
    icon = icon,
    padding = padding,
    hl = hl,
  }
end

M.session = function()
  local plugins = require("lazy.core.config").plugins
  local possession_ok, possession = pcall(require, "possession.session")

  local session_name = possession_ok and possession.get_session_name()
  local condition = plugins
    and plugins["possession.nvim"]
    and plugins["possession.nvim"]._.loaded
    and possession_ok
    and possession.get_session_name() ~= nil

  return {
    condition = condition,
    icon = "",
    provider = session_name,
    padding = padding,
    hl = { fg = colors.blue, bg = utils.get_hl("StatusLine").bg },
  }
end

M.lightbulb = function()
  local plugins = require("lazy.core.config").plugins
  local nvim_lightbulb_ok, nvim_lightbulb = pcall(require, "nvim-lightbulb")

  return {
    condition = plugins and plugins["nvim-lightbulb"] and plugins["nvim-lightbulb"]._.loaded and nvim_lightbulb_ok,
    provider = nvim_lightbulb_ok and nvim_lightbulb.get_status_text(),
    padding = padding,
    hl = { fg = colors.blue, bg = utils.get_hl("StatusLine").bg },
  }
end

return M
