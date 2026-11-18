--[[
  Increment Decrement.

  Writing "a++" is equivalent to "a = a + 1".
  Writing "a--" is equivalent to "a = a - 1".
]]

local a = 0
local b = 0
local direction = false

function setup()
  size(640, 360)
  colorMode(RGB, width)
  a = 0
  b = width
  direction = true
  frameRate(30)
end

function draw()
  a = a + 1
  if a > width then
    a = 0
    direction = not direction
  end
  if direction == true then
    stroke(a)
  else
    stroke(width - a)
  end
  line(a, 0, a, height / 2)

  b = b - 1
  if b < 0 then
    b = width
  end
  if direction == true then
    stroke(width - b)
  else
    stroke(b)
  end
  line(b, height / 2 + 1, b, height)
end
