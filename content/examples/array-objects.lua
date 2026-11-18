--[[
  Array Objects.

  Demonstrates the syntax for creating an array of custom objects.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local unit = 40
local count = 0
local mods

function setup()
  size(640, 360)
  noStroke()
  local wideCount = width // unit
  local highCount = height // unit
  count = wideCount * highCount
  mods = newArray(count, nil)

  local index = 0
  for y = 0, highCount - 1 do
    for x = 0, wideCount - 1 do
      mods[index + 1] = Module.new(x * unit, y * unit, unit / 2, unit / 2, random(0.05, 0.8), unit)
      index = index + 1
    end
  end
end

function draw()
  background(0)
  for _, mod in ipairs(mods) do
    mod:update()
    mod:display()
  end
end

Module = {}
Module.__index = Module

-- Contructor
function Module.new(xOffsetTemp, yOffsetTemp, xTemp, yTemp, speedTemp, tempUnit)
  local self = setmetatable({}, Module)
  self.xDirection = 1
  self.yDirection = 1
  self.xOffset = xOffsetTemp
  self.yOffset = yOffsetTemp
  self.x = xTemp
  self.y = yTemp
  self.speed = speedTemp
  self.unit = tempUnit
  return self
end

-- Custom method for updating the variables
function Module:update()
  self.x = self.x + (self.speed * self.xDirection)
  if self.x >= self.unit or self.x <= 0 then
    self.xDirection = self.xDirection * -1
    self.x = self.x + (1 * self.xDirection)
    self.y = self.y + (1 * self.yDirection)
  end
  if self.y >= self.unit or self.y <= 0 then
    self.yDirection = self.yDirection * -1
    self.y = self.y + (1 * self.yDirection)
  end
end

-- Custom method for drawing the object
function Module:display()
  fill(255)
  ellipse(self.xOffset + self.x, self.yOffset + self.y, 6, 6)
end
