--[[
  Sine Cosine.

  Linear movement with sin() and cos().
  Numbers between 0 and PI*2 (TWO_PI which angles roughly 6.28)
  are put into these functions and numbers between -1 and 1 are
  returned. These values are then scaled to produce larger movements.
]]

local x1, x2, y1, y2 = 0, 0, 0, 0
local angle1, angle2 = 0, 0
local scalar = 70

function setup()
  size(640, 360)
  noStroke()
  rectMode(CENTER)
end

function draw()
  background(0)

  local ang1 = radians(angle1)
  local ang2 = radians(angle2)

  x1 = width / 2 + (scalar * cos(ang1))
  x2 = width / 2 + (scalar * cos(ang2))

  y1 = height / 2 + (scalar * sin(ang1))
  y2 = height / 2 + (scalar * sin(ang2))

  fill(255)
  rect(width * 0.5, height * 0.5, 140, 140)

  fill(0, 102, 153)
  ellipse(x1, height * 0.5 - 120, scalar, scalar)
  ellipse(x2, height * 0.5 + 120, scalar, scalar)

  fill(255, 204, 0)
  ellipse(width * 0.5 - 120, y1, scalar, scalar)
  ellipse(width * 0.5 + 120, y2, scalar, scalar)

  angle1 = angle1 + 2
  angle2 = angle2 + 3
end
