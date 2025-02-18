local handlers = require("handlers")
local colors = require("helper.colors")
local utils = require("helper.utils")
local spinners = require("helper.spinners")

local M = {}

function M.session(opts)
  return function()
    local session_exists = handlers.plugins.session_exists()

    return {
      condition = utils.construct_condition(opts.condition, session_exists),
      icon = opts.icon or "",
      provider = handlers.plugins.get_session_name(),
      padding = opts.padding,
      hl = opts.hl or { fg = colors.blue, bg = utils.get_hl("StatusLine").bg },
    }
  end
end

function M.lightbulb(opts)
  return function()
    local lightbulb_exists = handlers.plugins.lightbulb_exists()

    return {
      condition = utils.construct_condition(opts.conditon, lightbulb_exists),
      provider = handlers.plugins.get_lightbulb_status(),
      padding = opts.padding,
      hl = opts.hl or { fg = colors.blue, bg = utils.get_hl("StatusLine").bg },
    }
  end
end

function M.autosave(opts)
  local icons = {
    on = " ",
    off = " ",
  }

  return function()
    local autosave_exists = handlers.plugins.autosave_exists()
    local autosave_status = handlers.plugins.get_autosave_status()

    return {
      condition = utils.construct_condition(opts.condition, autosave_exists),
      icon = autosave_status and icons.on or icons.off,
      padding = opts.padding,
      hl = opts.hl or { fg = colors.light_cyan, bg = utils.get_hl("StatusLine").bg },
    }
  end
end

function M.codeium(opts)
  local icons = {
    ["ON"] = "󱙺 ",
    ["OFF"] = "󱙻 ",
    ["EMPTY"] = "󱚠 ",
    ["NONE"] = "󱚡 ",
    ["UNKNOWN"] = "󰘦 ",
  }

  local loading = utils.get_loading(opts.interval, spinners.circle)

  return function(ctx)
    local codeium_exists = handlers.plugins.codeium_exists()
    local tag, status = handlers.plugins.get_codeium_status()

    if tag == "LOADING" then
      ctx.refresh(opts.interval)
    else
      ctx.done()
    end

    return {
      condition = utils.construct_condition(opts.condition, codeium_exists),
      icon = tag == "LOADING" and loading() or icons[tag],
      provider = (tag == "EMPTY" and "0/0") or (tag == "UNKNOWN" and status),
      padding = opts.padding,
      hl = opts.hl or { fg = colors.turquoise, bg = utils.get_hl("StatusLine").bg },
    }
  end
end

function M.lazystatus(opts)
  return function()
    local lazy_exists = handlers.plugins.lazy_exists()

    return {
      condition = utils.construct_condition(opts.condition, lazy_exists),
      icon = opts.icon,
      provider = handlers.plugins.get_lazy_updates(),
      padding = opts.padding,
      hl = opts.hl or { fg = colors.yellow, bg = utils.get_hl("StatusLine").bg },
    }
  end
end

return M
