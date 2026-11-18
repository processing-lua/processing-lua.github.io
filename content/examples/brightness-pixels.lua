--[[
  Brightness Pixels
  by Daniel Shiffman.

  This program adjusts the brightness of a part of the image by
  calculating the distance of each pixel to the mouse.
]]

local img

function setup()
  size(640, 360)
  frameRate(30)
  img = loadImage("moon-wide.jpg")
  img:loadPixels()
  -- Only need to load the pixels[] array once, because we're only
  -- manipulating pixels[] inside draw(), not drawing shapes.
  loadPixels()
end

function draw()
  for x = 0, img.width - 1 do
    for y = 0, img.height - 1 do
      -- Calculate the 1D location from a 2D grid
      local loc = x + y * img.width
      -- Get the R,G,B values from image
      local r
      local g
      local b
      r = red(img.pixels[loc])
      --g = green (img.pixels[loc]);
      --b = blue (img.pixels[loc]);
      -- Calculate an amount to change brightness based on proximity to the mouse
      local maxdist = 50  --dist(0,0,width,height);
      local d = dist(x, y, mouseX, mouseY)
      local adjustbrightness = 255 * (maxdist - d) / maxdist
      r = r + adjustbrightness
      --g += adjustbrightness;
      --b += adjustbrightness;
      -- Constrain RGB to make sure they are within 0-255 color range
      r = constrain(r, 0, 255)
      --g = constrain(g, 0, 255);
      --b = constrain(b, 0, 255);
      -- Make a new color and set pixel in the window
      --color c = color(r, g, b);
      local c = color(r)
      pixels[y * width + x] = c
    end
  end
  updatePixels()
end
