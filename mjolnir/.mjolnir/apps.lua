local apps = {}

local appfinder = require "mjolnir.cmsj.appfinder"
local application = require "mjolnir.application"
local window = require "mjolnir.window"

function apps.launch(app, fn)
  return function()
    launchedapp = appfinder.app_from_name(app)
    if (launchedapp) then
      windows = launchedapp:visiblewindows()
      if (#windows > 1) then
        focused = window.focusedwindow()
        for _, window in pairs(windows) do
          if (window == focused) then
            windows[#windows]:focus()
            if (fn) then; fn(); end
            return
          end
        end
      end
    end
    application.launchorfocus(app)
    if (fn) then; fn(); end
  end
end

function apps.hidecurrent()
  local win = window.focusedwindow()
  if (win) then; win:application():hide(); end
end

return apps
