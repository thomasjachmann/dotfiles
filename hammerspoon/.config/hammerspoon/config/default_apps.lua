local hyper = require "lib.hyper"
local ticktrack = require "apps.ticktrack"
local devdocs = require "apps.devdocs"
local apps = require "lib.apps"
local browser = require "lib.browser"

local newWindow = {
  newWindowFn = function(app)
    hs.eventtap.keyStroke({"cmd"}, "n", 200, app)
  end,
  raiseWindow = true
}

local mappings = {
  ["0"] = ticktrack.toggle,
  [{"shift", "0"}] = ticktrack.permanent,

  ["ß"] = devdocs.toggle, -- ? for help

  b = apps.launch(browser.browsers.default),
  [{"shift", "b"}] = apps.launchOrNewWindow(browser.browsers.default, newWindow),

  [{"alt", "b"}] = apps.launch(browser.browsers.tor),
  [{{"shift", "alt"}, "b"}] = apps.launchOrNewWindow(browser.browsers.tor, newWindow),

  c = apps.launch(browser.browsers.chrome),
  [{"shift", "c"}] = apps.launchOrNewWindow(browser.browsers.chrome, newWindow),

  f = apps.launch("Finder"),
}
hyper.bindAll(mappings)
