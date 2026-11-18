--[[
  Noise3D.

  Using 3D noise to create simple animated texture.
  Here, the third dimension ('z') is treated as time.
]]

local increment = 0.01
-- The noise function's 3rd argument, a global variable that increments once per cycle
local zoff = 0.0
-- We will increment zoff differently than xoff and yoff
local zincrement = 0.02

function setup()
  size(640, 360)
  frameRate(30)
end

function draw()
  -- Optional: adjust noise detail here
  -- noiseDetail(8,0.65f);

  loadPixels()

  local xoff = 0.0  -- Start xoff at 0

  -- For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for x = 0, width - 1 do
    xoff = xoff + increment  -- Increment xoff
    local yoff = 0.0  -- For every xoff, start yoff at 0
    for y = 0, height - 1 do
      yoff = yoff + increment  -- Increment yoff

      -- Calculate noise and scale by 255
      local bright = noise(xoff, yoff, zoff) * 255

      -- Try using this line instead
      --float bright = random(0,255);

      -- Set each pixel onscreen to a grayscale value
      pixels[x + y * width] = color(bright, bright, bright)
    end
  end
  updatePixels()

  zoff = zoff + zincrement  -- Increment zoff
end
