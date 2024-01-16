local hyper = require "lib.hyper"
local local_files = require "lib.local_files"

hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse("ClipboardTool", {
  config = { show_in_menubar = false, show_copied_alert = false },
  start = true
})

local actions = {
  ["translate with dict.cc"] = {
    url = "https://www.dict.cc/?s=${query}",
    icon = "favicon",
    keyword = "d"
  },
  ["search gem on rubygems.org"] = {
    url = "https://rubygems.org/search?utf8=%E2%9C%93&query=${query}",
    icon = "favicon",
    keyword = "gs"
  },
  ["go to gem on rubygems.org"] = {
    url = "https://rubygems.org/gems/${query}",
    icon = "favicon",
    keyword = "g"
  },
  ["google image search, size setting: large"] = {
    url = "https://www.google.com/search?tbm=isch&tbs=isz%3Al&q=${query}", -- TODO url escape multi word queries
    icon = "favicon",
    keyword = "gi"
  }
}
local_files.each("config", "spoon_", function(locals)
  for name, action in pairs(locals) do
    actions[name] = action
  end
end)

spoon.SpoonInstall:andUse("Seal", {
  fn = function(s)
    s:loadPlugins({ "apps", "calc", "useractions" })
    s.plugins.useractions.actions = actions
    s:refreshAllCommands()
  end,
  start = true
})

local mappings = {
  v = function()
    spoon.ClipboardTool:toggleClipboard()
  end,
  space = function()
    spoon.Seal:toggle()
  end,
}
hyper.bindAll(mappings)
