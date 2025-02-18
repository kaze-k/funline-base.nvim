local M = {}

function M.macro(opts)
  return function()
    return {
      condition = opts.condition,
      icon = opts.icon or "",
      provider = "",
      padding = opts.padding,
      hl = opts.hl,
    }
  end
end

function M.search(opts)
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

function M.spell(opts)
  return function()
    return {
      condition = opts.condition,
      icon = opts.icon,
      provider = "" or "󰓆",
      padding = opts.padding,
      hl = opts.hl,
    }
  end
end

return M
