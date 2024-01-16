hs.hotkey.setLogLevel("warning")


local apps = require "lib.apps"
local hyper = require "lib.hyper"

local tmux = require "apps.tmux"
local kitty = require "apps.kitty"

require "config.window_management"
require "config.default_apps"

local hyperMappings = {


  d = apps.launch("Calendar"), -- d for dates
  e = tmux.launch("nvim", {noToggle=true}), -- e for editor
  m = apps.launch("Thunderbird"),
  q = kitty.focusOrLaunch{title="taskwarrior-tui", cmd="taskwarrior-tui"},
  [{"shift", "q"}] = kitty.focusOrLaunch{title="taskwarrior", cmd="tasksh", text="next\n"},
  r = tmux.activate("ruby"), -- r anything that's running ruby (rails server, guard, formeman, rails console)
  s = apps.launch("Skype"),
  [{"shift", "t"}] = kitty.focusOrLaunch(),
  [{"alt", "t"}] = kitty.focusOrLaunch{shell=true},
  t = apps.launch("net.kovidgoyal.kitty", {noToggle=true}), -- t for terminal
  [{"shift", "w"}] = function()
    hs.wifi.setPower(hs.wifi.currentNetwork() == nil)
  end,
  y = apps.launch("Rambox"), -- y for whatever, this space gets crowded!! y is next to s which has a similar function, I need multikey shortcuts!
  z = apps.launch("zoom.us", {forceToggle=true}),


  escape = function()
    hs.openConsole()
    hs.reload()
  end
}

hyper.bindAll(hyperMappings)
