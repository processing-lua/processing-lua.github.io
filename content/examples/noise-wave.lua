--[[
  Noise Wave
  by Daniel Shiffman.

  Using Perlin Noise to generate a wave-like pattern.
]]

local yoff = 0.0  -- 2nd dimension of perlin noise

function setup()
  size(640, 360)
end

function draw()
  background(51)

  fill(255)
  -- We are going to draw a polygon out of the wave points
  beginShape()

  local xoff = 0  -- Option #1: 2D Noise
  -- float xoff = yoff; // Option #2: 1D Noise

  -- Iterate over horizontal pixels
  for x = 0, width, 10 do
    -- Calculate a y value according to noise, map to
    local y = map(noise(xoff, yoff), 0, 1, 200, 300)  -- Option #1: 2D Noise
    -- float y = map(noise(xoff), 0, 1, 200,300);    // Option #2: 1D Noise

    -- Set the vertex
    vertex(x, y)
    -- Increment x dimension for noise
    xoff = xoff + 0.05
  end
  -- increment y dimension for noise
  yoff = yoff + 0.01
  vertex(width, height)
  vertex(0, height)
  endShape(CLOSE)
end
