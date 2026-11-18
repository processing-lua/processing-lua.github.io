--[[
  Additive Wave
  by Daniel Shiffman.

  Create a more complex wave by adding two waves together.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local xspacing = 8  -- How far apart should each horizontal location be spaced
local w = 0  -- Width of entire wave
local maxwaves = 4  -- total # of waves to add together

local theta = 0.0
local amplitude = newArray(maxwaves, 0)  -- Height of wave
local dx = newArray(maxwaves, 0)  -- Value for incrementing X, to be calculated as a function of period and xspacing
local yvalues  -- Using an array to store height values for the wave (not entirely necessary)

function setup()
  size(640, 360)
  frameRate(30)
  colorMode(RGB, 255, 255, 255, 100)
  w = width + 16

  for i = 1, maxwaves do
    amplitude[i] = random(10, 30)
    local period = random(100, 300)  -- How many pixels before the wave repeats
    dx[i] = (TWO_PI / period) * xspacing
  end

  yvalues = newArray(w // xspacing, 0)
end

function draw()
  background(0)
  calcWave()
  renderWave()
end

function calcWave()
  -- Increment theta (try different values for 'angular velocity' here
  theta = theta + 0.02

  -- Set all height values to zero
  for i = 1, #yvalues do
    yvalues[i] = 0
  end

  -- Accumulate wave height values
  for j = 0, maxwaves - 1 do
    local x = theta
    for i = 1, #yvalues do
      -- Every other wave is cosine instead of sine
      if j % 2 == 0 then
        yvalues[i] = yvalues[i] + (sin(x) * amplitude[j + 1])
      else
        yvalues[i] = yvalues[i] + (cos(x) * amplitude[j + 1])
      end
      x = x + dx[j + 1]
    end
  end
end

function renderWave()
  -- A simple way to draw the wave with an ellipse at each location
  noStroke()
  fill(255, 50)
  ellipseMode(CENTER)
  for x = 0, #yvalues - 1 do
    ellipse(x * xspacing, height / 2 + yvalues[x + 1], 16, 16)
  end
end
