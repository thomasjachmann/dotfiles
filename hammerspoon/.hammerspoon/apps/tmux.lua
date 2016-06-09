local tmux = {}

local apps = require "apps"

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

  sessionTTYs = {}
  return found:gsub("($%d+)", function(sessionID)
    if sessionTTYs[sessionID] == nil then
      sessionTTYs[sessionID] = exec("/usr/local/bin/tmux list-clients -t '" .. sessionID .. "' -F '#{client_tty}'")
    end
    return sessionTTYs[sessionID]
  end)
end

function tmux.activate(cmd)
  return function(silent)
    local found = find(cmd)
    if found == "" then
      -- no panes with the specified command found => just activate/launch iTerm
      apps.launch("iTerm")()
      if silent ~= true then
        exec("/usr/local/bin/tmux display-message 'process \"" .. cmd .. "\" not found, switched to first iTerm pane'")
      end
      return false
    end

    local _, activeTTY = hs.applescript.applescript('tell application "iTerm" to tty of current session of current tab of current window')
    local panes = {}
    local total = 0
    local active = nil
    local bestMatches = {nil, nil, nil, nil, nil}
    for line in (found .. "\n"):gmatch('([^\n]*)\n') do
      total = total + 1
      panes[total] = line
      if line:find(activeTTY .. ":11") == 1 then
        active = total
      elseif bestMatches[1] == nil and line:find(activeTTY .. ":10") == 1 then
        -- active session, active window, another pane
        bestMatches[1] = total
      elseif bestMatches[2] == nil and line:find(activeTTY) == nil and line:find(":11") ~= nil then
        -- another session, active window, active pane
        bestMatches[2] = total
      elseif bestMatches[3] == nil and line:find(activeTTY) == nil and line:find(":10") ~= nil then
        -- another session, active window, another pane
        bestMatches[3] = total
      elseif bestMatches[4] == nil and line:find(activeTTY .. ":01") == 1 then
        -- active session, another window, active pane
        bestMatches[4] = total
      elseif bestMatches[5] == nil and line:find(activeTTY .. ":00") == 1 then
        -- active session, another window, another pane
        bestMatches[5] = total
      end
    end

    if active == nil then
      if bestMatches[1] ~= nil then
        active = bestMatches[1]
      elseif bestMatches[2] ~= nil then
        active = bestMatches[2]
      elseif bestMatches[3] ~= nil then
        active = bestMatches[3]
      elseif bestMatches[4] ~= nil then
        active = bestMatches[4]
      elseif bestMatches[5] ~= nil then
        active = bestMatches[5]
      else
        active = 1
      end
    else
      local win = hs.window.focusedWindow()
      if win ~= nil and win:application():title() == "iTerm" then
        active = active + 1
      end
      if active > total then
        active = 1
      end
    end

    panes[active]:gsub("(.*):[01][01] (@[0-9]+) (%%[0-9]+)", function(tty, windowID, paneID)
      exec("/usr/bin/osascript apps/tmux-activate.scpt " .. tty)
      exec("/usr/local/bin/tmux select-window -t '" .. windowID .. "' && /usr/local/bin/tmux select-pane -t '" .. paneID .. "'")
    end)

    return true
  end
end

function tmux.launch(cmd)
  local activate = tmux.activate(cmd)
  return function()
    local active = activate(true)
    if not active then
      hs.applescript.applescript('tell application "iTerm" to create window with default profile command "/usr/local/bin/zsh -l -c ' .. cmd .. '"')
    end
  end
end

return tmux
