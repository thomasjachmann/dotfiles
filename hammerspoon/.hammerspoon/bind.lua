local bind = {}

function bind.hyper(mappings)
  for key, fn in pairs(mappings) do
    hs.hotkey.bind("cmd alt ctrl shift", key, nil, fn)
  end
end

return bind
