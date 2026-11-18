--[[
  Create Image.

  The createImage() function provides a fresh buffer of pixels to play with.
  This example creates an image gradient.
]]

local img

function setup()
  size(640, 360)
  img = createImage(230, 230, ARGB)
  for i = 0, #img.pixels - 1 do
    local a = map(i, 0, #img.pixels, 255, 0)
    img.pixels[i] = color(0, 153, 204, a)
  end
end

function draw()
  background(0)
  image(img, 90, 80)
  image(img, mouseX - img.width / 2, mouseY - img.height / 2)
end
