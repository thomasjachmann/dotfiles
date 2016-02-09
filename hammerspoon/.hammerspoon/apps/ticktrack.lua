local ticktrack = {}

local webview = nil

function ticktrack.toggle()
  if webview == nil then
    rect = hs.screen.primaryScreen():frame()
    rect.x = rect.w - 350
    rect.w = 350
    webview = hs.webview.new(rect)
    webview:url("http://ticktrack.herokuapp.com")
    webview:allowTextEntry(true)
  end

  win = webview:asHSWindow()
  if win and win:application():isFrontmost() then
    webview:hide()
  else
    webview:show()
    hs.application.get("Hammerspoon"):activate()
  end
end

return ticktrack
