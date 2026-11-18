--[[
  Double Random
  by Ira Greenberg.

  Using two random() calls and the point() function
  to create an irregular sawtooth line.
]]

local totalPts = 300
local steps = totalPts + 1

function setup()
  size(640, 360)
  stroke(255)
  frameRate(1)
end

function draw()
  background(0)
  local rand = 0
  for i = 1, steps - 1 do
    point((width / steps) * i, (height / 2) + random(-rand, rand))
    rand = rand + random(-5, 5)
  end
end
