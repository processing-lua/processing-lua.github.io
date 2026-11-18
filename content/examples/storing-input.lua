--[[
  Storing Input.

  Move the mouse across the screen to change the position
  of the circles. The positions of the mouse are recorded
  into an array and played back every frame. Between each
  frame, the newest value are added to the end of each array
  and the oldest value is deleted.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local num = 60
local mx = newArray(num, 0)
local my = newArray(num, 0)

function setup()
  size(640, 360)
  noStroke()
  fill(255, 153)
end

function draw()
  background(51)

  -- Cycle through the array, using a different entry on each frame.
  -- Using modulo (%) like this is faster than moving all the values over.
  local which = frameCount % num
  mx[which + 1] = mouseX
  my[which + 1] = mouseY

  for i = 0, num - 1 do
    -- which+1 is the smallest (the oldest in the array)
    local index = (which + 1 + i) % num
    ellipse(mx[index + 1], my[index + 1], i, i)
  end
end
