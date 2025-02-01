local M = {}

function M.widen_condition(widen_width)
  local bufnr = vim.api.nvim_get_current_buf()
  local winwidth = vim.fn.winwidth(bufnr)
  if vim.o.laststatus == 3 then
    winwidth = vim.o.columns
  end

  if winwidth > widen_width then
    return true
  end
  return false
end

function M.buffer_is_empty() return vim.fn.empty(vim.fn.expand("%:t")) == 1 end

function M.buffer_is_readonly() return vim.bo.readonly end

function M.buftype_is_nofile() return vim.bo.buftype == "nofile" end

function M.get_loading(speed)
  local spinners = { "◜", "◠", "◝", "◞", "◡", "◟" }
  local index = 0
  local last_time = vim.uv.now()
  local last_spinner = nil
  local function loading()
    local current_time = vim.uv.now()

    if current_time - last_time >= speed then
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

  return loading
end

function M.get_hl(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  return hl
end

return M
