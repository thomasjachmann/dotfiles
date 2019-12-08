hs.hotkey.setLogLevel("warning")

local apps = require "apps"
local grid = require "grid"
local hyper = require "hyper"
local scrn = require "scrn"

local tmux = require "apps.tmux"
local ticktrack = require "apps.ticktrack"

local hyperMappings = {
  -- binding + produces error on English keyboard layout
  -- if bound on German and then executed on English, it works
  --["+"] = apps.launch("Google Plus"),

  f2 = apps.showCurrentTitle,
  f3 = apps.showCurrentBundleID,

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

  a = apps.launch("Adium"),
  b = apps.launch("Firefox"), -- b for browser
  c = apps.launch("Google Chrome"),
  d = apps.launch("Calendar"),             -- d for dates
  e = tmux.launch("nvim", {noToggle=true, startcmd="notes"}), -- e for editor
  f = apps.launch("Finder"),
  g = apps.launch("GitX"),
  i = apps.launch("Textual"),              -- i for irc
  m = apps.launch("Thunderbird"),
  n = apps.launch("Tweetbot"),             -- n for noise
  o = apps.launch("Opera"),
  r = tmux.activate("ruby"),               -- r anything that's running ruby (rails server, guard, formeman, rails console)
  p = apps.launch("Trello"), -- p for project management (temporary until I've figured out how to do working SSBs)
  s = apps.launch("Skype"),
  z = tmux.activate("zsh"),
  t = apps.launch("kitty", {noToggle=true}), -- t for terminal
  x = apps.launch("X-Lite"),
  y = apps.launch("Rambox"), -- y for whatever, this space gets crowded!! y is next to s which has a similar function, I need multikey shortcuts!

  w = apps.hideCurrent,

  escape = function()
    hs.openConsole()
    hs.reload()
  end
}

hyper.bindAll(hyperMappings)
