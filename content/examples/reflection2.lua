--[[
  Non-orthogonal Collision with Multiple Ground Segments
  by Ira Greenberg.

  Based on Keith Peter's Solution in
  Foundation Actionscript Animation: Making Things Move!
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local gravity, ground, orb

Ground = {}
Ground.__index = Ground

-- Constructor
function Ground.new(x1, y1, x2, y2)
  local self = setmetatable({}, Ground)
  self.x1 = x1
  self.y1 = y1
  self.x2 = x2
  self.y2 = y2
  self.x = (x1 + x2) / 2
  self.y = (y1 + y2) / 2
  self.len = dist(x1, y1, x2, y2)
  self.rot = atan2((y2 - y1), (x2 - x1))
  return self
end

Orb = {}
Orb.__index = Orb

-- Orb has positio and velocity
-- A damping of 80% slows it down when it hits the ground
function Orb.new(x, y, r_)
  local self = setmetatable({}, Orb)
  self.damping = 0.8
  self.position = createVector(x, y)
  self.velocity = createVector(0.5, 0)
  self.r = r_
  return self
end

function Orb:move()
  -- Move orb
  self.velocity:add(gravity)
  self.position:add(self.velocity)
end

function Orb:display()
  -- Draw orb
  noStroke()
  fill(200)
  ellipse(self.position.x, self.position.y, self.r * 2, self.r * 2)
end

-- Check boundaries of window
function Orb:checkWallCollision()
  if self.position.x > width - self.r then
    self.position.x = width - self.r
    self.velocity.x = self.velocity.x * -self.damping
  elseif self.position.x < self.r then
    self.position.x = self.r
    self.velocity.x = self.velocity.x * -self.damping
  end
end

function Orb:checkGroundCollision(groundSegment)
  -- Get difference between orb and ground
  local deltaX = self.position.x - groundSegment.x
  local deltaY = self.position.y - groundSegment.y

  -- Precalculate trig values
  local cosine = cos(groundSegment.rot)
  local sine = sin(groundSegment.rot)

  --[[
     Rotate ground and velocity to allow
         orthogonal collision calculations
  ]]
  local groundXTemp = cosine * deltaX + sine * deltaY
  local groundYTemp = cosine * deltaY - sine * deltaX
  local velocityXTemp = cosine * self.velocity.x + sine * self.velocity.y
  local velocityYTemp = cosine * self.velocity.y - sine * self.velocity.x

  --[[
     Ground collision - check for surface
         collision and also that orb is within
         left/rights bounds of ground segment
  ]]
  if groundYTemp > -self.r and self.position.x > groundSegment.x1 and self.position.x < groundSegment.x2 then
    -- keep orb from going into ground
    groundYTemp = -self.r
    -- bounce and slow down orb
    velocityYTemp = velocityYTemp * -1.0
    velocityYTemp = velocityYTemp * self.damping
  end

  -- Reset ground, velocity and orb
  deltaX = cosine * groundXTemp - sine * groundYTemp
  deltaY = cosine * groundYTemp + sine * groundXTemp
  self.velocity.x = cosine * velocityXTemp - sine * velocityYTemp
  self.velocity.y = cosine * velocityYTemp + sine * velocityXTemp
  self.position.x = groundSegment.x + deltaX
  self.position.y = groundSegment.y + deltaY
end

gravity = createVector(0, 0.05)
-- The ground is an array of "Ground" objects
local segments = 40
ground = newArray(segments, nil)

function setup()
  size(640, 360)
  -- An orb object that will fall and bounce around
  orb = Orb.new(50, 50, 3)

  -- Calculate ground peak heights
  local peakHeights = newArray(segments + 1, 0)
  for i = 1, #peakHeights do
    peakHeights[i] = random(height - 40, height - 30)
  end

  --[[
     Float value required for segment width (segs)
       calculations so the ground spans the entire
       display window, regardless of segment number.
  ]]
  local segs = segments
  for i = 0, segments - 1 do
    ground[i + 1] = Ground.new(width / segs * i, peakHeights[i + 1], width / segs * (i + 1), peakHeights[i + 1 + 1])
  end
end

function draw()
  -- Background
  noStroke()
  fill(0, 15)
  rect(0, 0, width, height)

  -- Move and display the orb
  orb:move()
  orb:display()
  -- Check walls
  orb:checkWallCollision()

  -- Check against all the ground segments
  for i = 1, segments do
    orb:checkGroundCollision(ground[i])
  end

  -- Draw ground
  fill(127)
  beginShape()
  for i = 1, segments do
    vertex(ground[i].x1, ground[i].y1)
    vertex(ground[i].x2, ground[i].y2)
  end
  vertex(ground[segments].x2, height)
  vertex(ground[1].x1, height)
  endShape(CLOSE)
end
