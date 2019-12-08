local hyper = {}

modal = hs.hotkey.modal.new()

-- bind F20 (eg sent from Karabiner Elements) to enter/exit the hyper hotkey mappings
hs.hotkey.bind({}, "F20", function() modal:enter() end, function() modal:exit() end)

function hyper.bind(key, pressed, released, repeated)
  if type(key) == "table" then
    mods = key[1]
    key = key[2]
  else
    mods = {}
  end
  modal:bind(mods, key, pressed, released, repeated)
end

function hyper.restoreOldHyperKey(key)
  callback = function()
    hs.eventtap.keyStroke("ctrl alt shift cmd", key)
  end
  hyper.bind(key, callback, nil, callback)
end

function hyper.bindAll(mappings)
  for key, fn in pairs(mappings) do
    hyper.bind(key, fn)
  end
end

return hyper
