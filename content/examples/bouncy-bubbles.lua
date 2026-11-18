--[[
  Bouncy Bubbles
  based on code from Keith Peters.

  Multiple-object collision.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local friction, gravity, numBalls, spring

Ball = {}
Ball.__index = Ball

function Ball.new(xin, yin, din, idin, oin)
  local self = setmetatable({}, Ball)
  self.vx = 0
  self.vy = 0
  self.x = xin
  self.y = yin
  self.diameter = din
  self.id = idin
  self.others = oin
  return self
end

function Ball:collide()
  for i = self.id + 1, numBalls - 1 do
    local dx = self.others[i + 1].x - self.x
    local dy = self.others[i + 1].y - self.y
    local distance = sqrt(dx * dx + dy * dy)
    local minDist = self.others[i + 1].diameter / 2 + self.diameter / 2
    if distance < minDist then
      local angle = atan2(dy, dx)
      local targetX = self.x + cos(angle) * minDist
      local targetY = self.y + sin(angle) * minDist
      local ax = (targetX - self.others[i + 1].x) * spring
      local ay = (targetY - self.others[i + 1].y) * spring
      self.vx = self.vx - ax
      self.vy = self.vy - ay
      self.others[i + 1].vx = self.others[i + 1].vx + ax
      self.others[i + 1].vy = self.others[i + 1].vy + ay
    end
  end
end

function Ball:move()
  self.vy = self.vy + gravity
  self.x = self.x + self.vx
  self.y = self.y + self.vy
  if self.x + self.diameter / 2 > width then
    self.x = width - self.diameter / 2
    self.vx = self.vx * friction
  elseif self.x - self.diameter / 2 < 0 then
    self.x = self.diameter / 2
    self.vx = self.vx * friction
  end
  if self.y + self.diameter / 2 > height then
    self.y = height - self.diameter / 2
    self.vy = self.vy * friction
  elseif self.y - self.diameter / 2 < 0 then
    self.y = self.diameter / 2
    self.vy = self.vy * friction
  end
end

function Ball:display()
  ellipse(self.x, self.y, self.diameter, self.diameter)
end

numBalls = 12
spring = 0.05
gravity = 0.03
friction = -0.9
local balls = newArray(numBalls, nil)

function setup()
  size(640, 360)
  for i = 0, numBalls - 1 do
    balls[i + 1] = Ball.new(random(width), random(height), random(30, 70), i, balls)
  end
  noStroke()
  fill(255, 204)
end

function draw()
  background(0)
  for _, ball in ipairs(balls) do
    ball:collide()
    ball:move()
    ball:display()
  end
end
