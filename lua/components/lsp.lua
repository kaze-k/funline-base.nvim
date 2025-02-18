local M = {}

function M.lspstatus(opts)
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

function M.nlstatus(opts)
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
