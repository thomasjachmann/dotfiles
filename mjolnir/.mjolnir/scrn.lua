local scrn = {}

local window = require "mjolnir.window"

function scrn.movetonext()
  return function()
    local win              = window.focusedwindow()

    -- taken from https://github.com/ledbettj/config-files/blob/master/mjolnir.lua
    local old_screen       = win:screen()
    local old_screen_frame = old_screen:frame()
    local win_frame        = win:frame()
    local new_screen       = old_screen:next()
    local new_frame        = new_screen:frame()
    local off_x_pct        = (win_frame.x - old_screen_frame.x) / (old_screen_frame.w)
    local off_y_pct        = (win_frame.y - old_screen_frame.y) / (old_screen_frame.h)

    local w_pct = win_frame.w / old_screen_frame.w
    local h_pct = win_frame.h / old_screen_frame.h

    win_frame.x = new_frame.x + (off_x_pct * new_frame.w)
    win_frame.y = new_frame.y + (off_y_pct * new_frame.h)
    win_frame.w = w_pct * new_frame.w
    win_frame.h = h_pct * new_frame.h

    win:setframe(win_frame)
  end
end

return scrn
