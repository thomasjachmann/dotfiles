hs.hotkey.setLogLevel("warning")

local hyper = require "lib.hyper"

require "config.window_management"
require "config.default_apps"
require "config.terminal"
require "config.spoon"
require "config.project_chooser"
require "lib.local_files".requireEach("config", "local_")

local mappings = {
  [{"shift", "w"}] = function()
    hs.wifi.setPower(hs.wifi.currentNetwork() == nil)
  end,

  escape = function()
    hs.openConsole()
    hs.reload()
  end,
}
hyper.bindAll(mappings)
