local apps = {}

local logger = require'lib.logging'.new(apps, 'lib.apps')

function inspect(data)
  return hs.inspect(data, {newline=" ", indent=""})
end

-- try and launch an app either by name or by bundle id
function launchOrFocus(appName)
  if (hs.application.launchOrFocus(appName)) then return true end
  if (hs.application.launchOrFocusByBundleID(appName)) then return true end
  return false
end

-- TODO Allow to specify multiple apps that are cycled:
-- * cycle through all the windows if active
-- * switch to the most recently active of the apps if inactive
--
-- opts:
-- * fn function to call after launching the app
-- * forceToggle whether to force toggling the app even though it has more than
--   one window
-- * noToggle whether to prevent toggling the app even though it has just one
--   window
function apps.launch(appName, opts)
  local opts = opts or {}
  local fn = opts.fn
  local forceToggle = opts.forceToggle
  local noToggle = opts.noToggle
  return function()
    logger.d("Launching app", appName, inspect({forceToggle=forceToggle, noToggle=noToggle}))
    local app = hs.application.get(appName)
    if (app) then
      logger.d("  found")
      if app:isFrontmost() then
        -- frontmost: we need to decide whether to toggle or cycle through windows
        windows = app:visibleWindows()
        logger.d("  is frontmost and has", #windows, "windows:")
        for i, win in ipairs(windows) do
          logger.d("   ", win:id(), win)
          logger.d("     ", inspect({isStandard=win:isStandard(), isVisible=win:isVisible(), role=win:role(), subrole=win:subrole(), width=win:size().w, height=win:size().h}))
          logger.d("     ", inspect(win:frame()))
        end
        -- only toggle if it's not forbidden and either we only have one window or are forced to toggle
        if not noToggle and (#windows == 1 or forceToggle) then
          logger.d("  hiding app")
          app:hide()
          return
        elseif (#windows > 0) then
          local nextWin = windows[#windows]
          logger.d("  selecting window", nextWin:id(), nextWin)
          nextWin:focus()
          if (fn) then; fn(); end
          return
        end
      end
    else
      logger.d("  not found")
    end
    logger.d("  launching/focussing app")
    launchOrFocus(appName)
    if (fn) then; fn(); end
  end
end

function apps.launchOrNewWindow(appName, opts)
  local opts = opts or {}
  local newWindowFn = opts.newWindowFn
  local raiseWindow = opts.raiseWindow
  return function()
    local app = hs.application.get(appName)
    if (app) then
      if (newWindowFn) then
        -- watcher needs to be declared outside the if in order to be available
        -- inside of the handler function
        local watcher
        if (raiseWindow) then
          watcher = app:newWatcher(function(win, event)
            win:focus()
            win:raise()
            watcher:stop()
          end)
          watcher:start({hs.uielement.watcher.windowCreated})
        end

        newWindowFn(app)
      end
    else
      launchOrFocus(appName)
    end
  end
end

-- Cmd-H
function apps.hideCurrent()
  local app = hs.application.frontmostApplication()
  if (app) then; app:hide(); end
end

-- Cmd-M
function apps.minimizeCurrentWindow()
  local win = hs.window.focusedWindow()
  if (win) then; win:minimize(); end
end

function apps.showAppAndWindowInfo()
  local infos = {}

  local app = hs.application.frontmostApplication()
  if (app) then
    table.insert(infos, "App Title: " .. app:title())
    table.insert(infos, "App Bundle-ID: " .. app:bundleID())
  end

  local win = hs.window.focusedWindow()
  if (win) then
    table.insert(infos, "Window Title: " .. win:title())
    table.insert(infos, "Window Info: " .. hs.inspect(win))
  end

  if next(infos) then; hs.alert(table.concat(infos, "\n")); end
end

return apps
