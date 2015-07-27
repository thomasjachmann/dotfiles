local apps = require "apps"
local bind = require "bind"
local grid = require "grid"
local scrn = require "scrn"

local mail = require "apps.mail"

grid.init(12, 12)

-- switching languages makes Mjolnir crash when it's controlled by Bartender (Seil and Karabiner as well?)
-- binding + produces error on English keyboard layout
bind.hyper({
  --["+"] = apps.launch("Google Plus"),

  ["tab"] = scrn.movetonext(),

  ["1"] = grid.move({{x=0,y=0,w=12,h=12}}),
  ["2"] = grid.move({{x=0,y=0,w=6,h=12}, {x=6,y=0,w=6,h=12}}),
  ["3"] = grid.move({{x=0,y=0,w=4,h=12}, {x=0,y=0,w=8,h=12}, {x=4,y=0,w=4,h=12}, {x=4,y=0,w=8,h=12}, {x=8,y=0,w=4,h=12}}),
  ["4"] = grid.move({{x=0,y=0,w=6,h=6}, {x=6,y=0,w=6,h=6}, {x=6,y=6,w=6,h=6}, {x=0,y=6,w=6,h=6}}),

  ["6"] = grid.nudge(-1, nil),
  ["7"] = grid.nudge(nil, 1),
  ["8"] = grid.nudge(nil, -1),
  ["9"] = grid.nudge(1, nil),

  ["0"] = apps.launch("TickTrack SSB"),
  a = apps.launch("Adium"),
  b = apps.launch("Safari"),               -- b for browser
  c = apps.launch("Google Chrome"),
  d = apps.launch("Calendar"),             -- d for dates
  e = apps.launch("MacVim"),               -- e for editor
  f = apps.launch("Finder"),
  g = apps.launch("GitX"),
  i = apps.launch("Textual"),              -- i for irc
  m = apps.launch("Mail", mail.init),
  n = apps.launch("Echofon"),              -- n for noise
  o = apps.launch("Opera Next"),
  p = apps.launch("Trello"),               -- p for project management
  s = apps.launch("Skype"),
  t = apps.launch("iTerm"),                -- t for terminal
  x = apps.launch("xScope"),

  w = apps.hidecurrent,

  escape = function()
    mjolnir.openconsole()
    mjolnir.reload()
  end
})
