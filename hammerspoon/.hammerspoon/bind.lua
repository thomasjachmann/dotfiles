local bind = {}

local hotkey = require "mjolnir.hotkey"

function bind.hyper(mappings)
  for key, fn in pairs(mappings) do
    hotkey.bind({"cmd", "alt", "ctrl", "shift"}, key, fn)
  end
end

return bind
