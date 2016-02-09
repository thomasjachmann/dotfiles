local scrn = {}

-- In contrast to `win:moveToScreen(win:screen():next())`, which would retain
-- the moved window's relative position and size, this keeps its absolute
-- position and size as long as it fits the new screens dimensions.
function scrn.moveToNext()
  local win = hs.window.focusedWindow()
  if (win) then
    local winFrame  = win:frame()

    local oldScreen = win:screen()
    local oldScreenFrame = oldScreen:frame()
    local newScreenFrame  = oldScreen:next():frame()

    local relative_x = winFrame.x - oldScreenFrame.x
    local relative_y = winFrame.y - oldScreenFrame.y

    if winFrame.w >= newScreenFrame.w then
      winFrame.x = newScreenFrame.x
      winFrame.w = newScreenFrame.w
    elseif relative_x + winFrame.w > newScreenFrame.w then
      winFrame.x = newScreenFrame.x + newScreenFrame.w - winFrame.w
    else
      winFrame.x = newScreenFrame.x + relative_x
    end
    if winFrame.h >= newScreenFrame.h then
      winFrame.y = newScreenFrame.y
      winFrame.h = newScreenFrame.h
    elseif relative_y + winFrame.h > newScreenFrame.h then
      winFrame.y = newScreenFrame.y + newScreenFrame.h - winFrame.h
    else
      winFrame.y = newScreenFrame.y + relative_y
    end

    win:setFrame(winFrame)
  end
end

return scrn
