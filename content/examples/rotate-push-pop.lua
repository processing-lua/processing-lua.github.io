--[[
  Rotate Push Pop.

  The push() and pop() functions allow for more control over transformations.
  The push function saves the current coordinate system to the stack
  and pop() restores the prior coordinate system.
]]

local a = 0  -- Angle of rotation
local offset = PI / 24.0  -- Angle offset between boxes
local num = 12  -- Number of boxes

function setup()
  size(640, 360, P3D)
  noStroke()
end

function draw()
  lights()

  background(0, 0, 26)
  translate(width / 2, height / 2)

  for i = 0, num - 1 do
    local gray = map(i, 0, num - 1, 0, 255)
    pushMatrix()
    fill(gray)
    rotateY(a + offset * i)
    rotateX(a / 2 + offset * i)
    box(200)
    popMatrix()
  end

  a = a + 0.01
end
