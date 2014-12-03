local apps = {}

local application = require "mjolnir.application"
local window = require "mjolnir.window"

function apps.launch(app, fn)
  return function()
    application.launchorfocus(app)
    if (fn) then; fn(); end
  end
end

function apps.hidecurrent()
  local win = window.focusedwindow()
  if (win) then; win:application():hide(); end
end

return apps
