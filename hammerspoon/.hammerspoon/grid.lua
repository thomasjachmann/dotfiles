local grid = {}

-- TODO dynamic grid with visual chooser à la:
-- slate.opstr('grid 1440x900:6,6 2560x1440:6,6')

hs.grid.setGrid('12x12')
hs.grid.setMargins('0,0')
hs.grid.ui.textSize = 100
hs.grid.ui.showExtraKeys = false
hs.window.animationDuration = 0

local frames = {}

function grid.move(grids)
  return function()
    local win = hs.window.focusedWindow()
    if (win) then
      local nextGridIndex = -1
      local currentGrid = hs.grid.get(win)
      for i = 1, #grids do
        if hs.geometry.rect(grids[i]) == currentGrid then
          nextGridIndex = i + 1
          break
        end
      end
      if nextGridIndex == -1 then
        frames[win:id()] = win:frame()
        nextGridIndex = 1
      end
      if nextGridIndex > #grids then
        local frame = frames[win:id()]
        if (frame) then; win:setFrame(frame); end
        return
      end
      hs.grid.set(win, grids[nextGridIndex], win:screen())
    end
  end
end

return grid
