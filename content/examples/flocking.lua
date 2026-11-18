--[[
  Flocking
  by Daniel Shiffman.

  An implementation of Craig Reynold's Boids program to simulate
  the flocking behavior of birds. Each boid steers itself based on
  rules of avoidance, alignment, and coherence.

  Click the mouse to add a new boid.
]]

local flock

function setup()
  size(640, 360)
  flock = Flock.new()
  -- Add an initial set of boids into the system
  for i = 1, 150 do
    flock:addBoid(Boid.new(width / 2, height / 2))
  end
end

function draw()
  background(50)
  flock:run()
end

-- Add a new boid into the System
function mousePressed()
  flock:addBoid(Boid.new(mouseX, mouseY))
end

-- The Boid class

Boid = {}
Boid.__index = Boid

-- Maximum steering force
-- Maximum speed
function Boid.new(x, y)
  local self = setmetatable({}, Boid)
  self.acceleration = createVector(0, 0)

  -- This is a new PVector method not yet implemented in JS
  -- velocity = PVector.random2D();

  -- Leaving the code temporarily this way so that this example runs in JS
  local angle = random(TWO_PI)
  self.velocity = createVector(cos(angle), sin(angle))

  self.position = createVector(x, y)
  self.r = 2.0
  self.maxspeed = 2
  self.maxforce = 0.03
  return self
end

function Boid:run(boids)
  self:flock(boids)
  self:update()
  self:borders()
  self:render()
end

function Boid:applyForce(force)
  -- We could add mass here if we want A = F / M
  self.acceleration:add(force)
end

-- We accumulate a new acceleration each time based on three rules
function Boid:flock(boids)
  local sep = self:separate(boids)  -- Separation
  local ali = self:align(boids)  -- Alignment
  local coh = self:cohesion(boids)  -- Cohesion
  -- Arbitrarily weight these forces
  sep:mult(1.5)
  ali:mult(1.0)
  coh:mult(1.0)
  -- Add the force vectors to acceleration
  self:applyForce(sep)
  self:applyForce(ali)
  self:applyForce(coh)
end

-- Method to update position
function Boid:update()
  -- Update velocity
  self.velocity:add(self.acceleration)
  -- Limit speed
  self.velocity:limit(self.maxspeed)
  self.position:add(self.velocity)
  -- Reset accelertion to 0 each cycle
  self.acceleration:mult(0)
end

-- A method that calculates and applies a steering force towards a target
-- STEER = DESIRED MINUS VELOCITY
function Boid:seek(target)
  local desired = (target - self.position)  -- A vector pointing from the position to the target
  -- Scale to maximum speed
  desired:normalize()
  desired:mult(self.maxspeed)

  -- Above two lines of code below could be condensed with new PVector setMag() method
  -- Not using this method until Processing.js catches up
  -- desired.setMag(maxspeed);

  -- Steering = Desired minus Velocity
  local steer = (desired - self.velocity)
  steer:limit(self.maxforce)  -- Limit to maximum steering force
  return steer
end

function Boid:render()
  -- Draw a triangle rotated in the direction of velocity
  local theta = self.velocity:heading2D() + radians(90)
  -- heading2D() above is now heading() but leaving old syntax until Processing.js catches up

  fill(200, 100)
  stroke(255)
  pushMatrix()
  translate(self.position.x, self.position.y)
  rotate(theta)
  beginShape(TRIANGLES)
  vertex(0, -self.r * 2)
  vertex(-self.r, self.r * 2)
  vertex(self.r, self.r * 2)
  endShape()
  popMatrix()
end

-- Wraparound
function Boid:borders()
  if self.position.x < -self.r then
    self.position.x = width + self.r
  end
  if self.position.y < -self.r then
    self.position.y = height + self.r
  end
  if self.position.x > width + self.r then
    self.position.x = -self.r
  end
  if self.position.y > height + self.r then
    self.position.y = -self.r
  end
end

-- Separation
-- Method checks for nearby boids and steers away
function Boid:separate(boids)
  local desiredseparation = 25.0
  local steer = createVector(0, 0, 0)
  local count = 0
  -- For every boid in the system, check if it's too close
  for _, other in ipairs(boids) do
    local d = self.position:dist(other.position)
    -- If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
    if (d > 0) and (d < desiredseparation) then
      -- Calculate vector pointing away from neighbor
      local diff = (self.position - other.position)
      diff:normalize()
      diff:div(d)  -- Weight by distance
      steer:add(diff)
      count = count + 1  -- Keep track of how many
    end
  end
  -- Average -- divide by how many
  if count > 0 then
    steer:div(count)
  end

  -- As long as the vector is greater than 0
  if steer:mag() > 0 then
    -- First two lines of code below could be condensed with new PVector setMag() method
    -- Not using this method until Processing.js catches up
    -- steer.setMag(maxspeed);

    -- Implement Reynolds: Steering = Desired - Velocity
    steer:normalize()
    steer:mult(self.maxspeed)
    steer:sub(self.velocity)
    steer:limit(self.maxforce)
  end
  return steer
end

-- Alignment
-- For every nearby boid in the system, calculate the average velocity
function Boid:align(boids)
  local neighbordist = 50
  local sum = createVector(0, 0)
  local count = 0
  for _, other in ipairs(boids) do
    local d = self.position:dist(other.position)
    if (d > 0) and (d < neighbordist) then
      sum:add(other.velocity)
      count = count + 1
    end
  end
  if count > 0 then
    sum:div(count)
    -- First two lines of code below could be condensed with new PVector setMag() method
    -- Not using this method until Processing.js catches up
    -- sum.setMag(maxspeed);

    -- Implement Reynolds: Steering = Desired - Velocity
    sum:normalize()
    sum:mult(self.maxspeed)
    local steer = (sum - self.velocity)
    steer:limit(self.maxforce)
    return steer
  else
    return createVector(0, 0)
  end
end

-- Cohesion
-- For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
function Boid:cohesion(boids)
  local neighbordist = 50
  local sum = createVector(0, 0)  -- Start with empty vector to accumulate all positions
  local count = 0
  for _, other in ipairs(boids) do
    local d = self.position:dist(other.position)
    if (d > 0) and (d < neighbordist) then
      sum:add(other.position)  -- Add position
      count = count + 1
    end
  end
  if count > 0 then
    sum:div(count)
    return self:seek(sum)  -- Steer towards the position
  else
    return createVector(0, 0)
  end
end

-- The Flock (a list of Boid objects)

Flock = {}
Flock.__index = Flock

-- An ArrayList for all the boids
function Flock.new()
  local self = setmetatable({}, Flock)
  self.boids = {}  -- Initialize the ArrayList
  return self
end

function Flock:run()
  for _, b in ipairs(self.boids) do
    b:run(self.boids)  -- Passing the entire list of boids to each boid individually
  end
end

function Flock:addBoid(b)
  table.insert(self.boids, b)
end
