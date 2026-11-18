--[[
  Reach 3
  based on code from Keith Peters.

  The arm follows the position of the ball by
  calculating the angles with atan2().
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local numSegments = 8
local x = newArray(numSegments, 0)
local y = newArray(numSegments, 0)
local angle = newArray(numSegments, 0)
local segLength = 26
local targetX, targetY = 0, 0

local ballX = 50
local ballY = 50
local ballXDirection = 1
local ballYDirection = -1

function setup()
  size(640, 360)
  strokeWeight(20.0)
  stroke(255, 100)
  noFill()
  x[#x] = width / 2  -- Set base x-coordinate
  y[#x] = height  -- Set base y-coordinate
end

function draw()
  background(0)

  strokeWeight(20)
  ballX = ballX + 1.0 * ballXDirection
  ballY = ballY + 0.8 * ballYDirection
  if ballX > width - 25 or ballX < 25 then
    ballXDirection = ballXDirection * -1
  end
  if ballY > height - 25 or ballY < 25 then
    ballYDirection = ballYDirection * -1
  end
  ellipse(ballX, ballY, 30, 30)

  reachSegment(0, ballX, ballY)
  for i = 1, numSegments - 1 do
    reachSegment(i, targetX, targetY)
  end
  for i = #x - 1, 1, -1 do
    positionSegment(i, i - 1)
  end
  for i = 0, #x - 1 do
    segment(x[i + 1], y[i + 1], angle[i + 1], (i + 1) * 2)
  end
end

function positionSegment(a, b)
  x[b + 1] = x[a + 1] + cos(angle[a + 1]) * segLength
  y[b + 1] = y[a + 1] + sin(angle[a + 1]) * segLength
end

function reachSegment(i, xin, yin)
  local dx = xin - x[i + 1]
  local dy = yin - y[i + 1]
  angle[i + 1] = atan2(dy, dx)
  targetX = xin - cos(angle[i + 1]) * segLength
  targetY = yin - sin(angle[i + 1]) * segLength
end

function segment(x, y, a, sw)
  strokeWeight(sw)
  pushMatrix()
  translate(x, y)
  rotate(a)
  line(0, 0, segLength, 0)
  popMatrix()
end
