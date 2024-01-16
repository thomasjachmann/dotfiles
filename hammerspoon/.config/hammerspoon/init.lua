hs.hotkey.setLogLevel("warning")


local apps = require "lib.apps"
local hyper = require "lib.hyper"

local tmux = require "apps.tmux"
local kitty = require "apps.kitty"
local ticktrack = require "apps.ticktrack"
local devdocs = require "apps.devdocs"

require "config.window_management"

local hyperMappings = {

  ["0"] = ticktrack.toggle,
  [{"shift", "0"}] = ticktrack.permanent,
  ["ß"] = devdocs.toggle, -- ? for help

  a = apps.launch("Adium"),
  b = apps.launch("Firefox"), -- b for browser
  [{"shift", "b"}] = apps.launchOrNewWindow("Firefox", {
      newWindowFn=function(app)
        app:selectMenuItem({"File", "New Window"})
      end,
      raiseWindow=true
    }),
  [{"alt", "b"}] = apps.launch("Tor Browser"),
  [{{"shift", "alt"}, "b"}] = apps.launchOrNewWindow("Tor Browser", {
      newWindowFn=function(app)
        app:selectMenuItem({"File", "New Private Window"})
      end,
      raiseWindow=true
    }),
  c = apps.launch("Google Chrome"),
  d = apps.launch("Calendar"), -- d for dates
  e = tmux.launch("nvim", {noToggle=true}), -- e for editor
  f = apps.launch("Finder"),
  g = apps.launch("GitX"),
  i = apps.launch("Textual"), -- i for irc
  m = apps.launch("Thunderbird"),
  n = apps.launch("Tweetbot"), -- n for noise
  o = apps.launch("Opera"),
  p = apps.launch("Trello"), -- p for project management (temporary until I've figured out how to do working SSBs)
  q = kitty.focusOrLaunch{title="taskwarrior-tui", cmd="taskwarrior-tui"},
  [{"shift", "q"}] = kitty.focusOrLaunch{title="taskwarrior", cmd="tasksh", text="next\n"},
  r = tmux.activate("ruby"), -- r anything that's running ruby (rails server, guard, formeman, rails console)
  s = apps.launch("Skype"),
  [{"shift", "t"}] = kitty.focusOrLaunch(),
  [{"alt", "t"}] = kitty.focusOrLaunch{shell=true},
  t = apps.launch("net.kovidgoyal.kitty", {noToggle=true}), -- t for terminal
  u = apps.launch("OpenLens"), -- u for U got to be kidding me: last free shortcut!
  [{"shift", "w"}] = function()
    hs.wifi.setPower(hs.wifi.currentNetwork() == nil)
  end,
  x = apps.launch("X-Lite"),
  y = apps.launch("Rambox"), -- y for whatever, this space gets crowded!! y is next to s which has a similar function, I need multikey shortcuts!
  z = apps.launch("zoom.us", {forceToggle=true}),

  w = apps.hideCurrent,

  escape = function()
    hs.openConsole()
    hs.reload()
  end
}

hyper.bindAll(hyperMappings)
