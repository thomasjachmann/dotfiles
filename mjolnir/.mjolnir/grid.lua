local grid = {}

local window = require "mjolnir.window"
local bggrid = require "mjolnir.bg.grid"

-- TODO dynamic grid with visual chooser à la:
-- slate.opstr('grid 1440x900:6,6 2560x1440:6,6')

bggrid.MARGINX = 0
bggrid.MARGINY = 0

function grid.init(w, h)
  bggrid.GRIDHEIGHT = w
  bggrid.GRIDWIDTH = h
end

local frames = {}

function grid.move(grids)
  return function()
    local win = window.focusedwindow()
    if (win) then
      local nextwin = -1
      local cg = bggrid.get(win) -- current grid
      for i = 1, #grids do
        local pg = grids[i] -- possible grid
        if cg.x == pg.x and cg.y == pg.y and cg.w == pg.w and cg.h == pg.h then
          nextwin = i + 1
          break
        end
      end
      if nextwin == -1 then
        frames[win:id()] = win:frame()
        nextwin = 1
      end
      if nextwin > #grids then
        local frame = frames[win:id()]
        if (frame) then; win:setframe(frame); end
        return
      end
      bggrid.set(win, grids[nextwin], win:screen())
    end
  end
end

function grid.nudge(x, y)
  return function()
    local win = window.focusedwindow()
    if (win) then
      local cell = bggrid.get(win)
      if x ~= nil then
        cell.x = math.max(0, math.min(cell.x + x, bggrid.GRIDWIDTH))
      end
      if y ~= nil then
        cell.y = math.max(0, math.min(cell.y + y, bggrid.GRIDHEIGHT))
      end
      bggrid.set(win, cell, win:screen())
    end
  end
end

return grid
