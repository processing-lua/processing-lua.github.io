--[[
  Transparency.

  Move the pointer left and right across the image to change
  its position. This program overlays one image over another
  by modifying the alpha value of the image with the tint() function.
]]

local img
local offset = 0
local easing = 0.05

function setup()
  size(640, 360)
  img = loadImage("moonwalk.jpg")  -- Load an image into the program
end

function draw()
  image(img, 0, 0)  -- Display at full opacity
  local dx = (mouseX - img.width / 2) - offset
  offset = offset + (dx * easing)
  tint(255, 127)  -- Display at half opacity
  image(img, offset, 0)
end
