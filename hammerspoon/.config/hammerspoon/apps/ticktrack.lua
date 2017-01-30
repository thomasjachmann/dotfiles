local ticktrack = {}

local webview = nil

function ticktrack.toggle()
  if webview == nil then
    rect = hs.screen.primaryScreen():frame()
    rect.x = rect.w - 370
    rect.w = 370
    webview = hs.webview.new(rect)
    webview:url("https://ticktrack.herokuapp.com")
    webview:allowTextEntry(true)
    webview:windowStyle({"titled", "closable", "resizable"}) --, "fullSizeContentView"})
  end

  win = webview:hswindow()
  if win and win:application():isFrontmost() then
    webview:hide()
  else
    webview:show()
    hs.application.get("Hammerspoon"):activate()
  end
end

return ticktrack
