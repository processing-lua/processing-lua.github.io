--[[
  Mouse Signals

  Move and click the mouse to generate signals.
  The top row is the signal from "mouseX",
  the middle row is the signal from "mouseY",
  and the bottom row is the signal from "mousePressed".
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local xvals
local yvals
local bvals

function setup()
  size(640, 360)
  noSmooth()
  xvals = newArray(width, 0)
  yvals = newArray(width, 0)
  bvals = newArray(width, 0)
end

function draw()
  background(102)

  for i = 1, width - 1 do
    xvals[i] = xvals[i + 1]
    yvals[i] = yvals[i + 1]
    bvals[i] = bvals[i + 1]
  end
  -- Add the new values to the end of the array
  xvals[width] = mouseX
  yvals[width] = mouseY

  if mousePressed == true then
    bvals[width] = 0
  else
    bvals[width] = height // 3
  end

  fill(255)
  noStroke()
  rect(0, height / 3, width, height / 3 + 1)

  for i = 1, width - 1 do
    -- Draw the x-values
    stroke(255)
    point(i, map(xvals[i + 1], 0, width, 0, height / 3 - 1))

    -- Draw the y-values
    stroke(0)
    point(i, height / 3 + yvals[i + 1] / 3)

    -- Draw the mouse presses
    stroke(255)
    line(i, (2 * height / 3) + bvals[i + 1], i, (2 * height / 3) + bvals[i])
  end
end
