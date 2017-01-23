local apps = {}

-- TODO Allow to specify multiple apps that are cycled:
-- * cycle through all the windows if active
-- * switch to the most recently active of the apps if inactive
function apps.launch(appName, fn)
  return function()
    app = hs.application.get(appName)
    if (app) then
      windows = app:visibleWindows()
      if (#windows > 1) then
        focusedWindow = hs.window.focusedWindow()
        for _, window in pairs(windows) do
          if (window == focusedWindow) then
            windows[#windows]:focus()
            if (fn) then; fn(); end
            return
          end
        end
      end
    end
    hs.application.launchOrFocus(appName)
    if (fn) then; fn(); end
  end
end

function apps.hideCurrent()
  local app = hs.application.frontmostApplication()
  if (app) then; app:hide(); end
end

function apps.showCurrentTitle()
  local app = hs.application.frontmostApplication()
  if (app) then; hs.alert(app:title()); end
end

function apps.showCurrentBundleID()
  local app = hs.application.frontmostApplication()
  if (app) then; hs.alert(app:bundleID()); end
end

return apps
