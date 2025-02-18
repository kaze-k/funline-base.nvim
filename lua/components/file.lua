local M = {}

function M.fileicon(opts)
  return function()
    return {
      condition = opts.condition,
      icon = opts.icon,
      provider = "",
      padding = opts.padding,
      hl = opts.hl,
    }
  end
end

function M.filename(opts)
  return function()
    return {
      condition = opts.condition,
      icon = opts.icon,
      provider = "",
      padding = opts.padding,
      hl = opts.hl,
    }
  end
end

function M.filemark(opts)
  return function()
    return {
      condition = opts.condition,
      icon = opts.icon,
      provider = "",
      padding = opts.padding,
      hl = opts.hl,
    }
  end
end

function M.fileindent(opts)
  return function()
    return {
      condition = opts.condition,
      icon = opts.icon,
      provider = "",
      padding = opts.padding,
      hl = opts.hl,
    }
  end
end

function M.fileformat(opts)
  return function()
    return {
      condition = opts.condition,
      icon = opts.icon,
      provider = "",
      padding = opts.padding,
      hl = opts.hl,
    }
  end
end

function M.lineratio(opts)
  return function()
    return {
      condition = opts.condition,
      icon = opts.icon,
      provider = "",
      padding = opts.padding,
      hl = opts.hl,
    }
  end
end

function M.lineinfo(opts)
  return function()
    return {
      condition = opts.condition,
      icon = opts.icon,
      provider = "",
      padding = opts.padding,
      hl = opts.hl,
    }
  end
end

return M
