--[[
  Brownian motion.

  Recording random movement as a continuous line.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local num = 2000
local range = 6

local ax = newArray(num, 0)
local ay = newArray(num, 0)

function setup()
  size(640, 360)
  for i = 1, num do
    ax[i] = width / 2
    ay[i] = height / 2
  end
  frameRate(30)
end

function draw()
  background(51)

  -- Shift all elements 1 place to the left
  for i = 1, num - 1 do
    ax[i] = ax[i + 1]
    ay[i] = ay[i + 1]
  end

  -- Put a new value at the end of the array
  ax[num] = ax[num] + random(-range, range)
  ay[num] = ay[num] + random(-range, range)

  -- Constrain all points to the screen
  ax[num] = constrain(ax[num], 0, width)
  ay[num] = constrain(ay[num], 0, height)

  -- Draw a line connecting the points
  for i = 1, num - 1 do
    local val = float(i) / num * 204.0 + 51
    stroke(val)
    line(ax[i], ay[i], ax[i + 1], ay[i + 1])
  end
end
