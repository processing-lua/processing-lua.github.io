--[[
  Noise2D
  by Daniel Shiffman.

  Using 2D noise to create simple texture.
]]

local increment = 0.02

function setup()
  size(640, 360)
end

function draw()
  loadPixels()

  local xoff = 0.0  -- Start xoff at 0
  local detail = map(mouseX, 0, width, 0.1, 0.6)
  noiseDetail(8, detail)

  -- For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for x = 0, width - 1 do
    xoff = xoff + increment  -- Increment xoff
    local yoff = 0.0  -- For every xoff, start yoff at 0
    for y = 0, height - 1 do
      yoff = yoff + increment  -- Increment yoff

      -- Calculate noise and scale by 255
      local bright = noise(xoff, yoff) * 255

      -- Try using this line instead
      --float bright = random(0,255);

      -- Set each pixel onscreen to a grayscale value
      pixels[x + y * width] = color(bright)
    end
  end

  updatePixels()
end
