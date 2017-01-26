# this would more appropriately be named hyper
local bind = {}

hyper = hs.hotkey.modal.new()

pressedHyper = function()
  hyper.triggered = false
  hyper:enter()
end

releasedHyper = function()
  hyper:exit()
  if not hyper.triggered then
    hs.eventtap.keyStroke({}, "ESCAPE")
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

function bind.hyper(mappings)
  for key, fn in pairs(mappings) do
    bind.bind(key, fn)
  end
end

return bind
