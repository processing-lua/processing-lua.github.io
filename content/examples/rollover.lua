--[[
  Rollover.

  Roll over the colored squares in the center of the image
  to change the color of the outside rectangle.
]]

local rectX, rectY = 0, 0  -- Position of square button
local circleX, circleY = 0, 0  -- Position of circle button
local rectSize = 90  -- Diameter of rect
local circleSize = 93  -- Diameter of circle

local rectColor = 0
local circleColor = 0
local baseColor = 0

local rectOver = false
local circleOver = false

function setup()
  size(640, 360)
  rectColor = color(0)
  circleColor = color(255)
  baseColor = color(102)
  circleX = width // 2 + circleSize // 2 + 10
  circleY = height // 2
  rectX = width // 2 - rectSize - 10
  rectY = height // 2 - rectSize // 2
  ellipseMode(CENTER)
end

function draw()
  update(mouseX, mouseY)

  noStroke()
  if rectOver then
    background(rectColor)
  elseif circleOver then
    background(circleColor)
  else
    background(baseColor)
  end

  stroke(255)
  fill(rectColor)
  rect(rectX, rectY, rectSize, rectSize)
  stroke(0)
  fill(circleColor)
  ellipse(circleX, circleY, circleSize, circleSize)
end

function update(x, y)
  if overCircle(circleX, circleY, circleSize) then
    circleOver = true
    rectOver = false
  elseif overRect(rectX, rectY, rectSize, rectSize) then
    rectOver = true
    circleOver = false
  else
    rectOver = false
    circleOver = rectOver
  end
end

function overRect(x, y, width, height)
  if mouseX >= x and mouseX <= x + width and mouseY >= y and mouseY <= y + height then
    return true
  else
    return false
  end
end

function overCircle(x, y, diameter)
  local disX = x - mouseX
  local disY = y - mouseY
  if sqrt(sq(disX) + sq(disY)) < diameter / 2 then
    return true
  else
    return false
  end
end
