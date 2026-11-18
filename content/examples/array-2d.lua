--[[
  Array 2D.

  Demonstrates the syntax for creating a two-dimensional (2D) array.
  Values in a 2D array are accessed through two index values.
  2D arrays are useful for storing images. In this example, each dot
  is colored in relation to its distance from the center of the image.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local distances
local maxDistance = 0
local spacer = 0

function setup()
  size(640, 360)
  maxDistance = dist(width / 2, height / 2, width, height)
  distances = newArray(width, height, 0)
  for y = 0, height - 1 do
    for x = 0, width - 1 do
      local distance = dist(width / 2, height / 2, x, y)
      distances[x + 1][y + 1] = distance / maxDistance * 255
    end
  end
  spacer = 10
  strokeWeight(6)
  noLoop()  -- Run once and stop
end

function draw()
  background(0)
  -- This embedded loop skips over values in the arrays based on
  -- the spacer variable, so there are more values in the array
  -- than are drawn here. Change the value of the spacer variable
  -- to change the density of the points
  for y = 0, height - 1, spacer do
    for x = 0, width - 1, spacer do
      stroke(distances[x + 1][y + 1])
      point(x + spacer / 2, y + spacer / 2)
    end
  end
end
