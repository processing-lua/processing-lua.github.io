--[[
  Mouse Functions.

  Click on the box and drag it across the screen.
]]

local bx = 0
local by = 0
local boxSize = 75
local overBox = false
local locked = false
local xOffset = 0.0
local yOffset = 0.0

function setup()
  size(640, 360)
  bx = width / 2.0
  by = height / 2.0
  rectMode(RADIUS)
end

function draw()
  background(0)

  -- Test if the cursor is over the box
  if mouseX > bx - boxSize and mouseX < bx + boxSize and mouseY > by - boxSize and mouseY < by + boxSize then
    overBox = true
    if not locked then
      stroke(255)
      fill(153)
    end
  else
    stroke(153)
    fill(153)
    overBox = false
  end

  -- Draw the box
  rect(bx, by, boxSize, boxSize)
end

function mousePressed()
  if overBox then
    locked = true
    fill(255, 255, 255)
  else
    locked = false
  end
  xOffset = mouseX - bx
  yOffset = mouseY - by
end

function mouseDragged()
  if locked then
    bx = mouseX - xOffset
    by = mouseY - yOffset
  end
end

function mouseReleased()
  locked = false
end
