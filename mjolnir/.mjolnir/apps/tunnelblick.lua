local tunnelblick = {}

local applescript = require "mjolnir._asm.hydra.applescript"
local alert = require "mjolnir.alert"

local function state(name)
  local erg, result = applescript.applescript('tell application "Tunnelblick" to return state of first configuration where name is "' .. name .. '"')
  if (erg) then
    return result
  else
    return "UNKNOWN"
  end
end

function tunnelblick.toggle(name)
  return function()
    local state = state(name)
    local command = "connect"
    if (state == "CONNECTED" or state == "RESOLVE") then; command = "disconnect"; end
    local erg, result = applescript.applescript('tell application "Tunnelblick" to ' .. command .. ' "' .. name .. '"')
  end
end

return tunnelblick
