local tmux = {}

local apps = require "apps"

-- Executes a shell command and returns the result (without trailing whitespace)
function exec(cmd)
  -- TODO use hs.task
  local handle = io.popen(cmd, "r")
  local output = handle:read("*a")
  handle:close()
  return output:match("(.-)%s*$")
end

local tmux_cmd = "/usr/local/bin/tmux -L kitty "
local kitty_cmd = "/usr/local/bin/kitty @ --to=unix:/tmp/kitty.sock "

-- Returns a multiline string where each line is a tmux pane with the requested
-- command as main process in the format:
--
-- 39233:11 @0 %0 zsh
--
-- * pid of the tmux session's client
-- * activity indicators for window and pane after the colon
-- * tmux window ID
-- * tmux pane ID
-- * main process
function find(cmd)
  local found = exec(tmux_cmd .. "list-panes -a -F '#{session_id}:#{window_active}#{pane_active} #{window_id} #{pane_id} #{pane_current_command}' | grep " .. cmd)

  clientPids = {}
  return found:gsub("($%d+)", function(sessionID)
    if clientPids[sessionID] == nil then
      clientPids[sessionID] = exec(tmux_cmd .. "list-clients -t '" .. sessionID .. "' -F '#{client_pid}'")
    end
    return clientPids[sessionID]
  end)
end

function tmux.activate(cmd, opts)
  local opts = opts or {}
  return function(silent)
    local found = find(cmd)
    if found == "" then
      if silent ~= true then
        hs.alert.show("no process \"" .. cmd .. "\" found")
      end
      return false
    end

    activePid = exec(kitty_cmd .. "ls | /usr/local/bin/jq '.[].tabs | .[].windows | map(select(.is_focused)) | .[].pid'")
    local panes = {}
    local total = 0
    local active = nil
    local bestMatches = {nil, nil, nil, nil, nil}
    for line in (found .. "\n"):gmatch('([^\n]*)\n') do
      total = total + 1
      panes[total] = line
      if line:find(activePid .. ":11") == 1 then
        active = total
      elseif bestMatches[1] == nil and line:find(activePid .. ":10") == 1 then
        -- active session, active window, another pane
        bestMatches[1] = total
      elseif bestMatches[2] == nil and line:find(activePid) == nil and line:find(":11") ~= nil then
        -- another session, active window, active pane
        bestMatches[2] = total
      elseif bestMatches[3] == nil and line:find(activePid) == nil and line:find(":10") ~= nil then
        -- another session, active window, another pane
        bestMatches[3] = total
      elseif bestMatches[4] == nil and line:find(activePid .. ":01") == 1 then
        -- active session, another window, active pane
        bestMatches[4] = total
      elseif bestMatches[5] == nil and line:find(activePid .. ":00") == 1 then
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
      if win ~= nil and win:application():title() == "kitty" then
        active = active + 1
      end
      if active > total then
        active = 1
      end
    end

    panes[active]:gsub("(.*):[01][01] (@[0-9]+) (%%[0-9]+)", function(clientPid, windowID, paneID)
      exec(kitty_cmd .. "focus-window --no-response --match pid:" .. clientPid)
      exec(tmux_cmd .. "select-window -t '" .. windowID .. "' && " .. tmux_cmd .. "select-pane -t '" .. paneID .. "'")
    end)

    return true
  end
end

function tmux.launch(cmd, opts)
  local opts = opts or {}
  local activate = tmux.activate(cmd, opts)
  return function()
    local active = activate(true)
    if not active then
      if opts.startcmd then
        cmd = opts.startcmd
      end
      exec("~/bin/open-in-kitty --command '" .. cmd .. "' --exit-after")
    end
  end
end

return tmux
