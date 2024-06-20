local hyper = require "lib.hyper"
local tmux = require "apps.tmux"
local kitty = require "apps.kitty"
local apps = require "lib.apps"

local mappings = {
  e = tmux.launch("nvim", {noToggle=true}), -- e for editor

  q = kitty.focusOrLaunch{title="taskwarrior-tui", cmd="taskwarrior-tui"},
  [{"shift", "q"}] = kitty.focusOrLaunch{title="taskwarrior", cmd="tasksh", text="next\n"},

  r = tmux.activate("ruby"), -- r anything that's running ruby (rails server, guard, formeman, rails console)

  t = apps.launch("net.kovidgoyal.kitty", {noToggle=true}), -- t for terminal
  [{"shift", "t"}] = kitty.focusOrLaunch(), -- always a new terminal window
  [{"alt", "t"}] = kitty.focusOrLaunch{shell=true}, -- terminal without tmux
  [{"ctrl", "t"}] = kitty.focusOrLaunch{shell=true, zdotdir="${HOME}/.config/zsh/blank"}, -- blank zsh

  x = kitty.focusOrLaunch{title="vimwiki", cmd="nvim -c 'call VimwikiOpen()'"},
}
hyper.bindAll(mappings)
