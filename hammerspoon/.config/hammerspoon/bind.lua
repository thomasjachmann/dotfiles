# this would more appropriately be named hyper
local bind = {}

hyper = hs.hotkey.modal.new()

pressedHyper = function()
  hyper.triggered = false
  hyper:enter()
end

releasedHyper = function()
  hyper:exit()
  if not hyper.triggered and hs.application.frontmostApplication():name() == "iTerm2" then
    local _, activeTTY = hs.applescript.applescript('tell application "iTerm" to tty of current session of current tab of current window')
    if os.execute("/usr/local/bin/tmux list-clients -F '#{client_tty}' | grep '^" .. activeTTY .. "$'") then
      hs.eventtap.keyStroke("ctrl", "b")
    end
  end
end

hs.hotkey.bind({}, "F20", pressedHyper, releasedHyper)

function bind.bind(key, pressed, released, repeated)
  hyper:bind({}, key, function()
    hyper.triggered = true
    if (pressed) then
      pressed()
    end
  end, released, repeated)
end

function bind.alias(key, alias)
  callback = function()
    hs.eventtap.keyStroke({}, alias)
  end
  bind.bind(key, callback, nil, callback)
end

function bind.restoreOldHyperKey(key)
  callback = function()
    hs.eventtap.keyStroke("ctrl alt shift cmd", key)
  end
  bind.bind(key, callback, nil, callback)
end

function bind.hyper(mappings)
  for key, fn in pairs(mappings) do
    bind.bind(key, fn)
  end
end

return bind
