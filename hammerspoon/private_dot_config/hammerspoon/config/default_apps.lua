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

  b = function() apps.launch(browser.browsers.default)() end,
  [{"shift", "b"}] = function() apps.launchOrNewWindow(browser.browsers.default, newWindow)() end,

  [{"alt", "b"}] = function() apps.launch(browser.browsers.tor)() end,
  [{{"shift", "alt"}, "b"}] = function() apps.launchOrNewWindow(browser.browsers.tor, newWindow)() end,

  c = function() apps.launch(browser.browsers.chrome)() end,
  [{"shift", "c"}] = function() apps.launchOrNewWindow(browser.browsers.chrome, newWindow)() end,

  f = apps.launch("Finder"),
}
hyper.bindAll(mappings)
