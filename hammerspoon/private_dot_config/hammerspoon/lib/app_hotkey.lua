local app_hotkey = {}

local logger = require'lib.logging'.new(app_hotkey, 'lib.app_hotkey')

local modals = {}

function app_hotkey.for_app(name)
  local modal = modals[name]
  if (modal) then
    logger.d("Reusing existing modal for app " .. name)
  else
    logger.d("Creating new modal for app " .. name)
    modal = hs.hotkey.modal.new()
    modals[name] = modal
  end
  return modal
end

local function change_hotkeys(name, event, app)
  local w = hs.application.watcher
  local modal = modals[name]
  if event == w.activated or event == w.unhidden then
    logger.d("> Entering app " .. hs.inspect(name))
    if (modal) then
      logger.d("  modal found, entering")
      modal:enter()
    end
  elseif event == w.deactivated or event == w.hidden then
    logger.d("< Exiting app " .. hs.inspect(name))
    if (modal) then
      logger.d("  modal found, exiting")
      modal:exit()
    end
  end
end

local app_watcher = hs.application.watcher.new(change_hotkeys)
app_watcher:start()

app_hotkey.app_watcher = app_watcher

return app_hotkey
