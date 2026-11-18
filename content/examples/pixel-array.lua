--[[
  Pixel Array.

  Click and drag the mouse up and down to control the signal and
  press and hold any key to see the current pixel being read.
  This program sequentially reads the color of every pixel of an image
  and displays this color to fill the window.
]]

local img
local direction = 1
local signal = 0

function setup()
  size(640, 360)
  noFill()
  stroke(255)
  frameRate(30)
  img = loadImage("sea.jpg")
end

function draw()
  if signal > img.width * img.height - 1 or signal < 0 then
    direction = direction * -1
  end

  if mousePressed then
    local mx = constrain(mouseX, 0, img.width - 1)
    local my = constrain(mouseY, 0, img.height - 1)
    signal = my * img.width + mx
  else
    signal = signal + (0.33 * direction)
  end

  local sx = int(signal) % img.width
  local sy = int(signal) // img.width

  if keyPressed then
    set(0, 0, img)  -- fast way to draw an image
    point(sx, sy)
    rect(sx - 5, sy - 5, 10, 10)
  else
    local c = img:get(sx, sy)
    background(c)
  end
end
