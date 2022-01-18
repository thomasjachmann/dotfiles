local ticktrack = {}

local webview = nil

function ticktrack.toggle()
  if webview == nil then
    rect = hs.screen.primaryScreen():frame()
    rect.x = rect.w - 560
    rect.w = 560
    webview = hs.webview.newBrowser(rect, {developerExtrasEnabled=true})
    webview:url("https://ticktrack.herokuapp.com")
    webview:behavior(hs.drawing.windowBehaviors.moveToActiveSpace)
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
