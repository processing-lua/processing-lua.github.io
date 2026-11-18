--[[
  Rotate 1.

  Rotating simultaneously in the X and Y axis.
  Transformation functions such as rotate() are additive.
  Successively calling rotate(1.0) and rotate(2.0)
  is equivalent to calling rotate(3.0).
]]

local a = 0.0
local rSize = 0  -- rectangle size

function setup()
  size(640, 360, P3D)
  rSize = width / 6
  noStroke()
  fill(204, 204)
end

function draw()
  background(126)

  a = a + 0.005
  if a > TWO_PI then
    a = 0.0
  end

  translate(width / 2, height / 2)

  rotateX(a)
  rotateY(a * 2.0)
  fill(255)
  rect(-rSize, -rSize, rSize * 2, rSize * 2)

  rotateX(a * 1.001)
  rotateY(a * 2.002)
  fill(0)
  rect(-rSize, -rSize, rSize * 2, rSize * 2)
end
