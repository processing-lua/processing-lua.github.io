--[[
  Pointillism
  by Daniel Shiffman.

  Mouse horizontal location controls size of dots.
  Creates a simple pointillist effect using ellipses colored
  according to pixels in an image.
]]

local img
local smallPoint, largePoint = 0, 0

function setup()
  size(640, 360)
  img = loadImage("moonwalk.jpg")
  smallPoint = 4
  largePoint = 40
  imageMode(CENTER)
  noStroke()
  background(255)
end

function draw()
  local pointillize = map(mouseX, 0, width, smallPoint, largePoint)
  local x = int(random(img.width))
  local y = int(random(img.height))
  local pix = img:get(x, y)
  fill(pix, 128)
  ellipse(x, y, pointillize, pointillize)
end
