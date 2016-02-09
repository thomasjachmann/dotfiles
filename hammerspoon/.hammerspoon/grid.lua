local grid = {}

local function resetGrid()
  hs.grid.setGrid('12x12')
end

resetGrid()
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

function grid.show()
  grid = hs.grid.getGrid()
  hs.grid.hide() -- in case it was open already, but only after we got our current grid size

  if grid._w == 12 or grid._w == 3 then
    hs.grid.setGrid("4x4")
    hs.grid.HINTS = {
      {"0", "0", "0", "0"}, -- this is ignored
      {"4", "5", "6", "7"},
      {"R", "T", "Z", "U"},
      {"F", "G", "H", "J"},
      {"V", "B", "N", "M"}
    }
  elseif grid._w == 4 then
    hs.grid.setGrid("3x3")
    hs.grid.HINTS = {
      {"0", "0", "0"}, -- this is ignored
      {"0", "0", "0"}, -- this is ignored
      {"R", "T", "Z"},
      {"F", "G", "H"},
      {"V", "B", "N"}
    }
  end

  hs.grid.show(resetGrid)
end

return grid
