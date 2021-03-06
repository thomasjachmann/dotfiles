local apps = {}

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
    app = hs.application.get(appName)
    if (app) then
      windows = app:visibleWindows()
      if not noToggle and (#windows == 1 or forceToggle) and app == hs.application.frontmostApplication() then
        app:hide()
        return
      elseif (#windows > 1) then
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
