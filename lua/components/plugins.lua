local M = {}

function M.session(opts)
  return function()
    return {
      condition = opts.condition,
      icon = opts.icon or "",
      provider = "",
      padding = opts.padding,
      hl = opts.hl,
    }
  end
end

function M.lightbulb(opts)
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

function M.autosave(opts)
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

function M.codeium(opts)
  return function(ctx)
    return {
      condition = opts.condition,
      icon = opts.icon,
      provider = "",
      padding = opts.padding,
      hl = opts.hl,
    }
  end
end

function M.lazystatus(opts)
  return function(ctx)
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
