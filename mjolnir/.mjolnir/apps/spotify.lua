local spotify = {}

local applescript = require "mjolnir._asm.hydra.applescript"
local alert = require "mjolnir.alert"

local function currenttrack()
  local erg, result = applescript.applescript('tell application "Spotify" to set output to (name of current track) & " by " & (artist of current track) & " on " & (album of current track) & " by " & (album artist of current track)')
  if (erg) then; return result; end
end

function spotify.displaycurrenttrack()
  local track = currenttrack()
  if (track) then
    alert.show(track)
  else
    alert.show("no track playing")
  end
end

return spotify
