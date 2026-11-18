--[[
  Reach 1
  based on code from Keith Peters.

  The arm follows the position of the mouse by
  calculating the angles with atan2().
]]

local segLength = 80
local x, y, x2, y2 = 0, 0, 0, 0

function setup()
  size(640, 360)
  strokeWeight(20.0)
  stroke(255, 100)

  x = width / 2
  y = height / 2
  x2 = x
  y2 = y
end

function draw()
  background(0)

  local dx = mouseX - x
  local dy = mouseY - y
  local angle1 = atan2(dy, dx)

  local tx = mouseX - cos(angle1) * segLength
  local ty = mouseY - sin(angle1) * segLength
  dx = tx - x2
  dy = ty - y2
  local angle2 = atan2(dy, dx)
  x = x2 + cos(angle2) * segLength
  y = y2 + sin(angle2) * segLength

  segment(x, y, angle1)
  segment(x2, y2, angle2)
end

function segment(x, y, a)
  pushMatrix()
  translate(x, y)
  rotate(a)
  line(0, 0, segLength, 0)
  popMatrix()
end
