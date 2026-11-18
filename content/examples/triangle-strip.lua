--[[
  Triangle Strip
  by Ira Greenberg.

  Generate a closed ring using the vertex() function and
  beginShape(TRIANGLE_STRIP) mode. The outsideRadius and insideRadius
  variables control ring's radii respectively.
]]

local x = 0
local y = 0
local outsideRadius = 150
local insideRadius = 100

function setup()
  size(640, 360)
  background(204)
  x = width // 2
  y = height // 2
end

function draw()
  background(204)

  local numPoints = int(map(mouseX, 0, width, 6, 60))
  local angle = 0
  local angleStep = 180.0 / numPoints

  beginShape(TRIANGLE_STRIP)
  for i = 0, numPoints do
    local px = x + cos(radians(angle)) * outsideRadius
    local py = y + sin(radians(angle)) * outsideRadius
    angle = angle + angleStep
    vertex(px, py)
    px = x + cos(radians(angle)) * insideRadius
    py = y + sin(radians(angle)) * insideRadius
    vertex(px, py)
    angle = angle + angleStep
  end
  endShape()
end
