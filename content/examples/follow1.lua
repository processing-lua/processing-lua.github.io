--[[
  Follow 1
  based on code from Keith Peters.

  A line segment is pushed and pulled by the cursor.
]]

local x = 100
local y = 100
local angle1 = 0.0
local segLength = 50

function setup()
  size(640, 360)
  strokeWeight(20.0)
  stroke(255, 100)
end

function draw()
  background(0)

  local dx = mouseX - x
  local dy = mouseY - y
  angle1 = atan2(dy, dx)
  x = mouseX - (cos(angle1) * segLength)
  y = mouseY - (sin(angle1) * segLength)

  segment(x, y, angle1)
  ellipse(x, y, 20, 20)
end

function segment(x, y, a)
  pushMatrix()
  translate(x, y)
  rotate(a)
  line(0, 0, segLength, 0)
  popMatrix()
end
