--[[
  Follow 2
  based on code from Keith Peters.

  A two-segmented arm follows the cursor position. The relative
  angle between the segments is calculated with atan2() and the
  position calculated with sin() and cos().
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local x = newArray(2, 0)
local y = newArray(2, 0)
local segLength = 50

function setup()
  size(640, 360)
  strokeWeight(20.0)
  stroke(255, 100)
end

function draw()
  background(0)
  dragSegment(0, mouseX, mouseY)
  dragSegment(1, x[1], y[1])
end

function dragSegment(i, xin, yin)
  local dx = xin - x[i + 1]
  local dy = yin - y[i + 1]
  local angle = atan2(dy, dx)
  x[i + 1] = xin - cos(angle) * segLength
  y[i + 1] = yin - sin(angle) * segLength
  segment(x[i + 1], y[i + 1], angle)
end

function segment(x, y, a)
  pushMatrix()
  translate(x, y)
  rotate(a)
  line(0, 0, segLength, 0)
  popMatrix()
end
