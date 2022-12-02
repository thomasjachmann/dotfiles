hs.hotkey.setLogLevel("warning")

local spoons = require "spoons"

local apps = require "apps"
local grid = require "grid"
local hyper = require "hyper"
local scrn = require "scrn"

local tmux = require "apps.tmux"
local kitty = require "apps.kitty"
local ticktrack = require "apps.ticktrack"
local devdocs = require "apps.devdocs"

local hyperMappings = {
  f2 = apps.showAppAndWindowInfo,

  ["tab"] = scrn.moveToNext,

  ["^"] = grid.show,
  ["1"] = grid.move({"0,0,12x12"}),

  -- vertically oriented window moves
  ["2"] = grid.move({"0,0,6x12", "6,0,6x12", "3,0,6x12"}),
  ["3"] = grid.move({"0,0,8x12", "4,0,8x12", "0,0,4x12", "4,0,4x12", "8,0,4x12"}),
  ["4"] = grid.move({"0,0,9x12", "3,0,9x12", "0,0,3x12", "3,0,3x12", "6,0,3x12", "9,0,3x12"}),

  -- horizontally oriented window moves
  [{"alt", "2"}] = grid.move({"0,0,12x6", "0,3,12x6", "0,6,12x6"}),
  [{"alt", "3"}] = grid.move({"0,0,12x8", "0,4,12x8", "0,0,12x4", "0,4,12x4", "0,8,12x4"}),
  [{"alt", "4"}] = grid.move({"0,0,12x9", "0,3,12x9", "0,0,12x3", "0,3,12x3", "0,6,12x3", "0,9,12x3"}),

  -- specially oriented window moves
  [{"shift", "4"}] = grid.move({"0,0,6x6", "6,0,6x6", "6,6,6x6", "0,6,6x6"}),

  -- push window moves
  ["6"] = hs.grid.pushWindowLeft,
  ["7"] = hs.grid.pushWindowDown,
  ["8"] = hs.grid.pushWindowUp,
  ["9"] = hs.grid.pushWindowRight,

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
  t = apps.launch("kitty", {noToggle=true}), -- t for terminal
  [{"shift", "t"}] = kitty.focusOrLaunch(),
  [{"alt", "t"}] = kitty.focusOrLaunch{shell=true},
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
