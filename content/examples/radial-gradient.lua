--[[
  Radial Gradient.

  Draws a series of concentric circles to create a gradient
  from one color to another.
]]

local dim = 0

function setup()
  size(640, 360)
  dim = width // 2
  background(0)
  colorMode(HSB, 360, 100, 100)
  noStroke()
  ellipseMode(RADIUS)
  frameRate(1)
end

function draw()
  background(0)
  for x = 0, width, dim do
    drawGradient(x, height / 2)
  end
end

function drawGradient(x, y)
  local radius = dim // 2
  local h = random(0, 360)
  for r = radius, 1, -1 do
    fill(h, 90, 90)
    ellipse(x, y, r, r)
    h = (h + 1) % 360
  end
end
