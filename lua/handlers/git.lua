local g = vim.g
local b = vim.b

local M = {}

local function git_diff(type)
  local gsd = b.gitsigns_status_dict

  if gsd and gsd[type] and gsd[type] > 0 then
    return gsd[type]
  end

  return 0
end

function M.is_git_dir() return b.gitsigns_status_dict ~= nil and b.gitsigns_status_dict.head ~= "" end

function M.get_buf_git_branch() return b.gitsigns_head or "" end

function M.get_global_git_branch() return g.gitsigns_head or "" end

function M.is_git_added_exists() return git_diff("added") > 0 end

function M.is_git_removed_exists() return git_diff("removed") > 0 end

function M.is_git_changed_exists() return git_diff("changed") > 0 end

function M.get_git_added() return git_diff("added") end

function M.get_git_removed() return git_diff("removed") end

function M.get_git_changed() return git_diff("changed") end

return M
