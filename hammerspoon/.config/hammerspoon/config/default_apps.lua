local hyper = require "lib.hyper"
local ticktrack = require "apps.ticktrack"
local devdocs = require "apps.devdocs"
local apps = require "lib.apps"

local newWindow = {
  newWindowFn=function(app)
    hs.eventtap.keyStroke({"cmd"}, "n", 200, app)
  end,
  raiseWindow=true
}

local mappings = {
  ["0"] = ticktrack.toggle,
  [{"shift", "0"}] = ticktrack.permanent,

  ["ß"] = devdocs.toggle, -- ? for help

  b = apps.launch("Firefox"), -- b for browser
  [{"shift", "b"}] = apps.launchOrNewWindow("Firefox", newWindow),

  [{"alt", "b"}] = apps.launch("Tor Browser"),
  [{{"shift", "alt"}, "b"}] = apps.launchOrNewWindow("Tor Browser", newWindow),

  c = apps.launch("Google Chrome"),
  [{"shift", "c"}] = apps.launchOrNewWindow("Google Chrome", newWindow),

  f = apps.launch("Finder"),
}
hyper.bindAll(mappings)
