--[[
  Easing.

  Move the mouse across the screen and the symbol will follow.
  Between drawing each frame of the animation, the program
  calculates the difference between the position of the
  symbol and the cursor. If the distance is larger than
  1 pixel, the symbol moves part of the distance (0.05) from its
  current position toward the cursor.
]]

local x = 0
local y = 0
local easing = 0.05

function setup()
  size(640, 360)
  noStroke()
end

function draw()
  background(51)

  local targetX = mouseX
  local dx = targetX - x
  x = x + (dx * easing)

  local targetY = mouseY
  local dy = targetY - y
  y = y + (dy * easing)

  ellipse(x, y, 66, 66)
end
