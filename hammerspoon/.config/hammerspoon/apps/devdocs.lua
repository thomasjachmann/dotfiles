local devdocs = {}

local webview = nil

function devdocs.toggle()
  if webview == nil then
    rect = hs.screen.primaryScreen():frame()
    webview = hs.webview.newBrowser(rect, {developerExtrasEnabled=true})
    webview:url("https://devdocs.io")
    webview:behavior(hs.drawing.windowBehaviors.moveToActiveSpace)
  end

  win = webview:hswindow()
  if win and win:application():isFrontmost() then
    webview:hide()
  else
    webview:show()
    webview:hswindow():application():activate()
    webview:evaluateJavaScript("window.setTimeout(function() { $('input._search-input').focus(); $('input._search-input').select(); }, 100);")
    -- webview:evaluateJavaScript("window.setTimeout(function() { $('button._search-clear').click();")
  end
end

return devdocs
