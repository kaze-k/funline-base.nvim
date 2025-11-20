local handlers = require("handlers")
local utils = require("helper.utils")

local M = {}

M.aroundLeft = function()
  return {
    icon = "",
    hl = { fg = utils.get_hl("StatusLineNC").bg, bg = utils.get_hl("Normal").bg },
  }
end

M.aroundRight = function()
  return {
    icon = "",
    hl = { fg = utils.get_hl("StatusLineNC").bg, bg = utils.get_hl("Normal").bg },
  }
end

M.gitAroundLeft = function()
  return {
    condition = handlers.git.is_git_dir(),
    icon = "",
    hl = { fg = utils.get_hl("StatusLineNC").bg, bg = utils.get_hl("Normal").bg },
  }
end

M.gitAroundRight = function()
  return {
    condition = handlers.git.is_git_dir(),
    icon = "",
    padding = { left = " " },
    hl = { fg = utils.get_hl("StatusLineNC").bg, bg = utils.get_hl("Normal").bg },
  }
end

M.fileAroundLeft = function()
  return {
    condition = handlers.file.is_filname_exists(),
    icon = "",
    hl = { fg = utils.get_hl("StatusLineNC").bg, bg = utils.get_hl("Normal").bg },
  }
end

M.fileAroundRight = function()
  return {
    condition = handlers.file.is_filname_exists(),
    icon = "",
    padding = { left = " " },
    hl = { fg = utils.get_hl("StatusLineNC").bg, bg = utils.get_hl("Normal").bg },
  }
end

return M
