--[[
  Sine.

  Smoothly scaling size with the sin() function.
]]

local diameter = 0
local angle = 0

function setup()
  size(640, 360)
  diameter = height - 10
  noStroke()
  fill(255, 204, 0)
end

function draw()
  background(0)

  local d1 = 10 + (sin(angle) * diameter / 2) + diameter / 2
  local d2 = 10 + (sin(angle + PI / 2) * diameter / 2) + diameter / 2
  local d3 = 10 + (sin(angle + PI) * diameter / 2) + diameter / 2

  ellipse(0, height / 2, d1, d1)
  ellipse(width / 2, height / 2, d2, d2)
  ellipse(width, height / 2, d3, d3)

  angle = angle + 0.02
end
