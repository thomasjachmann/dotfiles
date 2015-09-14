local tmux = {}

local apps = require "apps"

local applescript = require "mjolnir._asm.hydra.applescript"
local window = require "mjolnir.window"

-- Executes a shell command and returns the result (without trailing whitespace)
function exec(cmd)
  local handle = io.popen(cmd, "r")
  local output = handle:read("*a")
  handle:close()
  return output:match("(.-)%s*$")
end

-- Returns a multiline string where each line is a pane with the requested
-- command as main process in the format:
--
-- /dev/ttys000:11 @0 %0 zsh
--
-- * TTY of the tmux session
-- * activity indicators for window and pane after the colon
-- * tmux window ID
-- * tmux pane ID
-- * main process
function find(cmd)
  local found = exec("/usr/local/bin/tmux list-panes -a -F '#{session_id}:#{window_active}#{pane_active} #{window_id} #{pane_id} #{pane_current_command}' | grep " .. cmd)

  sessionttys = {}
  return found:gsub("($%d+)", function(sessionid)
    if sessionttys[sessionid] == nil then
      sessionttys[sessionid] = exec("/usr/local/bin/tmux list-clients -t '" .. sessionid .. "' -F '#{client_tty}'")
    end
    return sessionttys[sessionid]
  end)
end

function tmux.launch(cmd)
  return function()
    local found = find(cmd)
    if found == "" then
      -- no panes with the specified command found => just activate/launch iTerm
      apps.launch("iTerm")()
      return
    end

    local erg, activetty = applescript.applescript('tell application "iTerm" to tty of current session of current terminal')
    local panes = {}
    local total = 0
    local active = 0
    for line in (found .. "\n"):gmatch('([^\n]*)\n') do
      total = total + 1
      panes[total] = line
      if line:find(activetty .. ":11") == 1 then
        active = total
      end
    end

    if active == 0 then
      active = 1
    else
      local win = window.focusedwindow()
      if win ~= nil and win:application():title() == "iTerm" then
        active = active + 1
      end
      if active > total then
        active = 1
      end
    end

    panes[active]:gsub("(.*):[01][01] (@[0-9]+) (%%[0-9]+)", function(tty, windowid, paneid)
      exec("/usr/bin/osascript apps/tmux-activate.scpt " .. tty)
      exec("/usr/local/bin/tmux select-window -t '" .. windowid .. "' && /usr/local/bin/tmux select-pane -t '" .. paneid .. "'")
    end)
  end
end

return tmux
