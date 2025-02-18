local handlers = require("handlers")
local colors = require("helper.colors")
local utils = require("helper.utils")

local M = {}

function M.gitbranch(opts)
  return function()
    local is_git_dir = handlers.git.is_git_dir()
    local is_nofile = utils.match_buftype("nofile")
    local global = handlers.git.get_global_git_branch()
    local buf = handlers.git.get_buf_git_branch()

    return {
      condition = utils.construct_condition(opts.condition, is_git_dir),
      icon = opts.icon or "",
      provider = is_nofile and global or buf,
      padding = opts.padding,
      hl = opts.hl or { fg = colors.green, bg = utils.get_hl("StatusLine").bg },
    }
  end
end

function M.gitadd(opts)
  return function()
    local git_added_exists = handlers.git.git_added_exists()

    return {
      condition = utils.construct_condition(opts.condition, git_added_exists),
      icon = opts.icon or "",
      provider = handlers.git.git_added(),
      padding = opts.padding,
      hl = opts.hl or { fg = colors.light_green, bg = utils.get_hl("StatusLine").bg },
    }
  end
end

function M.gitchange(opts)
  return function()
    local git_changed_exists = handlers.git.git_changed_exists()

    return {
      condition = utils.construct_condition(opts.condition, git_changed_exists),
      icon = opts.icon or "",
      provider = handlers.git.git_changed(),
      padding = opts.padding,
      hl = opts.hl or { fg = colors.orange, bg = utils.get_hl("StatusLine").bg },
    }
  end
end

function M.gitremove(opts)
  return function()
    local git_removed_exists = handlers.git.git_removed_exists()

    return {
      condition = utils.construct_condition(opts.condition, git_removed_exists),
      icon = opts.icon or "",
      provider = handlers.git.git_removed(),
      padding = opts.padding,
      hl = opts.hl or { fg = colors.red, bg = utils.get_hl("StatusLine").bg },
    }
  end
end

return M
