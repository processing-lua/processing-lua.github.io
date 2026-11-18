--[[
  Sine Wave
  by Daniel Shiffman.

  Render a simple sine wave.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local xspacing = 16  -- How far apart should each horizontal location be spaced
local w = 0  -- Width of entire wave

local theta = 0.0  -- Start angle at 0
local amplitude = 75.0  -- Height of wave
local period = 500.0  -- How many pixels before the wave repeats
local dx = 0  -- Value for incrementing X, a function of period and xspacing
local yvalues  -- Using an array to store height values for the wave

function setup()
  size(640, 360)
  w = width + 16
  dx = (TWO_PI / period) * xspacing
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

  -- For every x value, calculate a y value with sine function
  local x = theta
  for i = 1, #yvalues do
    yvalues[i] = sin(x) * amplitude
    x = x + dx
  end
end

function renderWave()
  noStroke()
  fill(255)
  -- A simple way to draw the wave with an ellipse at each location
  for x = 0, #yvalues - 1 do
    ellipse(x * xspacing, height / 2 + yvalues[x + 1], 16, 16)
  end
end
