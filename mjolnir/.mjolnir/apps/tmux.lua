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

    local _, activetty = applescript.applescript('tell application "iTerm" to tty of current session of current terminal')
    local panes = {}
    local total = 0
    local active = nil
    local bestmatches = {nil, nil, nil, nil, nil}
    for line in (found .. "\n"):gmatch('([^\n]*)\n') do
      total = total + 1
      panes[total] = line
      if line:find(activetty .. ":11") == 1 then
        active = total
      elseif bestmatches[1] == nil and line:find(activetty .. ":10") == 1 then
        -- active session, active window, another pane
        bestmatches[1] = total
      elseif bestmatches[2] == nil and line:find(activetty) == nil and line:find(":11") ~= nil then
        -- another session, active window, active pane
        bestmatches[2] = total
      elseif bestmatches[3] == nil and line:find(activetty) == nil and line:find(":10") ~= nil then
        -- another session, active window, another pane
        bestmatches[3] = total
      elseif bestmatches[4] == nil and line:find(activetty .. ":01") == 1 then
        -- active session, another window, active pane
        bestmatches[4] = total
      elseif bestmatches[5] == nil and line:find(activetty .. ":00") == 1 then
        -- active session, another window, another pane
        bestmatches[5] = total
      end
    end

    if active == nil then
      if bestmatches[1] ~= nil then
        active = bestmatches[1]
      elseif bestmatches[2] ~= nil then
        active = bestmatches[2]
      elseif bestmatches[3] ~= nil then
        active = bestmatches[3]
      elseif bestmatches[4] ~= nil then
        active = bestmatches[4]
      elseif bestmatches[5] ~= nil then
        active = bestmatches[5]
      else
        active = 1
      end
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
