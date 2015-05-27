local scrn = {}

local window = require "mjolnir.window"

function scrn.movetonext()
  return function()
    local win        = window.focusedwindow()
    local win_frame  = win:frame()

    local old_screen = win:screen()
    local old_frame  = old_screen:frame()
    local new_screen = old_screen:next()
    local new_frame  = new_screen:frame()

    local relative_x = win_frame.x - old_frame.x
    local relative_y = win_frame.y - old_frame.y

    if win_frame.w >= new_frame.w then
      win_frame.x = new_frame.x
      win_frame.w = new_frame.w
    elseif relative_x + win_frame.w > new_frame.w then
      win_frame.x = new_frame.x + new_frame.w - win_frame.w
    else
      win_frame.x = new_frame.x + relative_x
    end
    if win_frame.h >= new_frame.h then
      win_frame.y = new_frame.y
      win_frame.h = new_frame.h
    elseif relative_y + win_frame.h > new_frame.h then
      win_frame.y = new_frame.y + new_frame.h - win_frame.h
    else
      win_frame.y = new_frame.y + relative_y
    end

    win:setframe(win_frame)
  end
end

return scrn
