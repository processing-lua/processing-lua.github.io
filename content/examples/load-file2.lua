--[[
  LoadFile 2

  This example loads a data file about cars. Each element is separated
  with a tab and corresponds to a different aspect of each car. The file stores
  the miles per gallon, cylinders, displacement, etc., for more than 400 different
  makes and models. Press a mouse button to advance to the next group of entries.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local records
local lines
local recordCount = 0
local body
local num = 9  -- Display this many entries on each screen.
local startingEntry = 0  -- Display from this entry number

function setup()
  size(640, 360)
  fill(255)
  noLoop()

  body = loadFont("TheSans-Plain-12.vlw")
  textFont(body)
  textSize(20)

  lines = loadStrings("cars2.tsv")
  records = newArray(#lines, nil)
  for i = 1, #lines do
    local pieces = split(lines[i], TAB)  -- Load data into array
    if #pieces == 9 then
      records[recordCount + 1] = Record.new(pieces)
      recordCount = recordCount + 1
    end
  end
  if recordCount ~= #records then
    records = subset(records, 0, recordCount)
  end
end

function draw()
  background(0)
  for i = 0, num - 1 do
    local thisEntry = startingEntry + i
    if thisEntry < recordCount then
      text(thisEntry .. " > " .. records[thisEntry + 1].name, 20, 20 + i * 20)
    end
  end
end

function mousePressed()
  startingEntry = startingEntry + num
  if startingEntry > #records then
    startingEntry = 0  -- go back to the beginning
  end
  redraw()
end

Record = {}
Record.__index = Record

function Record.new(pieces)
  local self = setmetatable({}, Record)
  self.name = pieces[1]
  self.mpg = float(pieces[2])
  self.cylinders = int(pieces[3])
  self.displacement = float(pieces[4])
  self.horsepower = float(pieces[5])
  self.weight = float(pieces[6])
  self.acceleration = float(pieces[7])
  self.year = int(pieces[8])
  self.origin = float(pieces[9])
  return self
end
