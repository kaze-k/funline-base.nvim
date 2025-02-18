local M = {}

function M.get_time_icon(icons)
  local hour = tonumber(os.date("%H"))
  local icon = 0 <= hour and hour <= 11 and icons[hour + 1] or icons[(hour - 12) + 1]
  return icon
end

function M.date() return os.date("%Y-%m-%d") end

function M.time() return os.date("%H:%M:%S") end

return M
