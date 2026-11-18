--[[
  Forces (Gravity and Fluid Resistence) with Vectors
  by Daniel Shiffman.

  Demonstration of multiple forces acting on bodies.
  Bodies experience gravity continuously and fluid
  resistance when in "water".
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

-- Five moving bodies

--[[
  Forces (Gravity and Fluid Resistence) with Vectors
  by Daniel Shiffman.

  Demonstration of multiple force acting on bodies (Mover class)
  Bodies experience gravity continuously
  Bodies experience fluid resistance when in "water"
]]

Liquid = {}
Liquid.__index = Liquid

-- Liquid is a rectangle
-- Coefficient of drag
function Liquid.new(x_, y_, w_, h_, c_)
  local self = setmetatable({}, Liquid)
  self.x = x_
  self.y = y_
  self.w = w_
  self.h = h_
  self.c = c_
  return self
end

-- Is the Mover in the Liquid?
function Liquid:contains(m)
  local l = m.position
  if l.x > self.x and l.x < self.x + self.w and l.y > self.y and l.y < self.y + self.h then
    return true
  else
    return false
  end
end

-- Calculate drag force
function Liquid:drag(m)
  -- Magnitude is coefficient * speed squared
  local speed = m.velocity:mag()
  local dragMagnitude = self.c * speed * speed

  -- Direction is inverse of velocity
  local drag = m.velocity:copy()
  drag:mult(-1)

  -- Scale according to magnitude
  drag:setMag(dragMagnitude)
  return drag
end

function Liquid:display()
  noStroke()
  fill(127)
  rect(self.x, self.y, self.w, self.h)
end

--[[
  Forces (Gravity and Fluid Resistence) with Vectors
  by Daniel Shiffman.

  Demonstration of multiple force acting on bodies (Mover class)
  Bodies experience gravity continuously
  Bodies experience fluid resistance when in "water"
]]

Mover = {}
Mover.__index = Mover

-- position, velocity, and acceleration
-- Mass is tied to size
function Mover.new(m, x, y)
  local self = setmetatable({}, Mover)
  self.mass = m
  self.position = createVector(x, y)
  self.velocity = createVector(0, 0)
  self.acceleration = createVector(0, 0)
  return self
end

-- Newton's 2nd law: F = M * A
-- or A = F / M
function Mover:applyForce(force)
  -- Divide by mass
  local f = (force / self.mass)
  -- Accumulate all forces in acceleration
  self.acceleration:add(f)
end

function Mover:update()
  -- Velocity changes according to acceleration
  self.velocity:add(self.acceleration)
  -- position changes by velocity
  self.position:add(self.velocity)
  -- We must clear acceleration each frame
  self.acceleration:mult(0)
end

-- Draw Mover
function Mover:display()
  stroke(255)
  strokeWeight(2)
  fill(255, 200)
  ellipse(self.position.x, self.position.y, self.mass * 16, self.mass * 16)
end

-- Bounce off bottom of window
function Mover:checkEdges()
  if self.position.y > height then
    self.velocity.y = self.velocity.y * -0.9  -- A little dampening when hitting the bottom
    self.position.y = height
  end
end

local movers = newArray(10, nil)

-- Liquid
local liquid

function setup()
  size(640, 360)
  reset()
  -- Create liquid object
  liquid = Liquid.new(0, height / 2, width, height / 2, 0.1)
end

function draw()
  background(0)

  -- Draw water
  liquid:display()

  for _, mover in ipairs(movers) do
    -- Is the Mover in the liquid?
    if liquid:contains(mover) then
      -- Calculate drag force
      local drag = liquid:drag(mover)
      -- Apply drag force to Mover
      mover:applyForce(drag)
    end

    -- Gravity is scaled by mass here!
    local gravity = createVector(0, 0.1 * mover.mass)
    -- Apply gravity
    mover:applyForce(gravity)

    -- Update and display
    mover:update()
    mover:display()
    mover:checkEdges()
  end

  fill(255)
  text("click mouse to reset", 10, 30)
end

function mousePressed()
  reset()
end

-- Restart all the Mover objects randomly
function reset()
  for i = 0, #movers - 1 do
    movers[i + 1] = Mover.new(random(0.5, 3), 40 + i * 70, 0)
  end
end
