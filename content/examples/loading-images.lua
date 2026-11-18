--[[
  Loading Images.

  Processing applications can load images from the network.
]]

local img

function setup()
  size(640, 360)
  img = loadImage("https://processing.org/img/processing-web.png")
  noLoop()
end

function draw()
  background(0)
  if img ~= nil then
    for i = 0, 4 do
      image(img, 0, img.height * i)
    end
  end
end
