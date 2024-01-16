local hyper = require "lib.hyper"
local apps = require "lib.apps"
local scrn = require "lib.scrn"
local grid = require "lib.grid"

local mappings = {
  f2 = apps.showAppAndWindowInfo,

  ["tab"] = scrn.moveToNext,

  ["^"] = grid.show,
  ["1"] = grid.move({"0,0,12x12"}),

  -- vertically oriented window moves
  ["2"] = grid.move({"0,0,6x12", "6,0,6x12", "3,0,6x12"}),
  ["3"] = grid.move({"0,0,8x12", "4,0,8x12", "0,0,4x12", "4,0,4x12", "8,0,4x12"}),
  ["4"] = grid.move({"0,0,9x12", "3,0,9x12", "0,0,3x12", "3,0,3x12", "6,0,3x12", "9,0,3x12"}),

  -- horizontally oriented window moves
  [{"alt", "2"}] = grid.move({"0,0,12x6", "0,6,12x6", "0,3,12x6"}),
  [{"alt", "3"}] = grid.move({"0,0,12x8", "0,4,12x8", "0,0,12x4", "0,4,12x4", "0,8,12x4"}),
  [{"alt", "4"}] = grid.move({"0,0,12x9", "0,3,12x9", "0,0,12x3", "0,3,12x3", "0,6,12x3", "0,9,12x3"}),

  -- specially oriented window moves
  [{"shift", "4"}] = grid.move({"0,0,6x6", "6,0,6x6", "6,6,6x6", "0,6,6x6"}),

  -- push window moves
  ["6"] = hs.grid.pushWindowLeft,
  ["7"] = hs.grid.pushWindowDown,
  ["8"] = hs.grid.pushWindowUp,
  ["9"] = hs.grid.pushWindowRight,
}
hyper.bindAll(mappings)
