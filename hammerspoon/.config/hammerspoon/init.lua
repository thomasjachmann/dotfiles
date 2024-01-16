hs.hotkey.setLogLevel("warning")

local apps = require "lib.apps"
local local_files = require "lib.local_files"
local hyper = require "lib.hyper"

require "config.window_management"
require "config.default_apps"
require "config.terminal"
require "config.spoon"
require "config.project_chooser"
local_files.each("config", "local_")

local mappings = {
  d = apps.launch("Calendar"), -- d for dates
  m = apps.launch("Thunderbird"),
  s = apps.launch("Skype"),
  [{"shift", "w"}] = function()
    hs.wifi.setPower(hs.wifi.currentNetwork() == nil)
  end,
  y = apps.launch("Rambox"), -- y for whatever, this space gets crowded!! y is next to s which has a similar function, I need multikey shortcuts!
  z = apps.launch("zoom.us", {forceToggle=true}),


  escape = function()
    hs.openConsole()
    hs.reload()
  end,
}
hyper.bindAll(mappings)
