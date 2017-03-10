local grid = {}

local function resetGrid()
  hs.grid.setGrid('12x12')
end

resetGrid()
hs.grid.setMargins('0,0')
hs.grid.ui.textSize = 100
hs.grid.ui.showExtraKeys = false
hs.window.animationDuration = 0

local dataByWindowId = {}

function focusedWindowData()
  local win = hs.window.focusedWindow()
  if win ~= hs.window:desktop() then
    data = dataByWindowId[win:id()]
    if not data then
      data = {
        win           = win,
        originalFrame = nil,
        lastGridFrame = nil,
        grids         = nil,
        index         = 0
      }
      dataByWindowId[win:id()] = data
    end
    return data
  end
end

function grid.move(grids)
  return function()
    local data = focusedWindowData()
    if (data) then
      -- determine what to do
      if grids ~= data.grids or data.index == 0 or data.win:frame() ~= data.lastGridFrame then
        data.originalFrame = data.win:frame()
        data.grids = grids
        data.index = 1
      elseif data.index >= #grids then
        data.index = 0
      else
        data.index = data.index + 1
      end

      -- do it
      if data.index == 0 then
        data.win:setFrame(data.originalFrame)
      else
        hs.grid.set(data.win, grids[data.index], data.win:screen())
        data.lastGridFrame = data.win:frame()
      end
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
