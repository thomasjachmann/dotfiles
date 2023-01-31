local ticktrack = {}

local webview = nil
local storedKeepOpen = nil

function ticktrack.permanent()
  ticktrack.toggle({keepOpen=true})
end

function ticktrack.toggle(keepOpen)
  storedKeepOpen = keepOpen
  if webview == nil then
    rect = hs.screen.primaryScreen():frame()
    rect.x = rect.w - 560
    rect.w = 560
    webview = hs.webview.newBrowser(rect, {developerExtrasEnabled=true})
    webview:url("https://ticktrack.coderei.de")
    webview:behavior(hs.drawing.windowBehaviors.moveToActiveSpace)
    webview:windowCallback(function(event, webview, state)
      if not storedKeepOpen and event == "focusChange" and state == false then
        webview:hide()
      end
    end)
  end

  win = webview:hswindow()
  if win and win:application():isFrontmost() then
    webview:hide()
  else
    webview:show()
    webview:hswindow():application():activate()
    webview:evaluateJavaScript("$('.navigation-item:first').click();window.setTimeout(function() { $('input:first').focus(); }, 100);") -- TODO this is too early when opening view for the first time
  end
end

return ticktrack
