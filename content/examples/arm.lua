--[[
  Arm.

  The angle of each segment is controlled with the mouseX and
  mouseY position. The transformations applied to the first segment
  are also applied to the second segment because they are inside
  the same pushMatrix() and popMatrix() group.
]]

local x, y = 0, 0
local angle1 = 0.0
local angle2 = 0.0
local segLength = 100

function setup()
  size(640, 360)
  strokeWeight(30)
  stroke(255, 160)

  x = width * 0.3
  y = height * 0.5
end

function draw()
  background(0)

  angle1 = (mouseX / float(width) - 0.5) * -PI
  angle2 = (mouseY / float(height) - 0.5) * PI

  pushMatrix()
  segment(x, y, angle1)
  segment(segLength, 0, angle2)
  popMatrix()
end

function segment(x, y, a)
  translate(x, y)
  rotate(a)
  line(0, 0, segLength, 0)
end
