local hyper = require "lib.hyper"
local local_files = require "lib.local_files"
local kitty = require "apps.kitty"

local projects = {
  {text="dotfiles vault", subText=hs.execute("~/bin/dotfiles home", true):match("(.-)%s*$")},
}
local_files.requireEach("config", "project_chooser_", function(locals)
  for _, project in pairs(locals) do
    table.insert(projects, project)
  end
end)

local projectChooser = hs.chooser.new(function(choice)
  if choice then
    -- TODO: Make this a real tmux window?
    -- TODO: Or at least make the editor backgroundable with Ctrl-z?
    kitty.focusOrLaunch{title=choice.text, cmd="cd " .. choice.subText .. " && nvim || sleep 5"}()
  end
end):choices(projects):placeholderText("Projekt"):searchSubText(true)

local mappings = {
  -- p = kitty.focusOrLaunch{cmd="open-project"},
  p = function() projectChooser:show() end,
}
hyper.bindAll(mappings)
