--[[
  Acceleration with Vectors
  by Daniel Shiffman.

  Demonstration of the basics of motion with vector.
  A "Mover" object stores location, velocity, and
  acceleration as vectors. The motion is controlled by
  affecting the acceleration (in this case towards the mouse).
]]

-- A Mover object
local mover

function setup()
  size(640, 360)
  mover = Mover.new()
end

function draw()
  background(0)

  -- Update the location
  mover:update()
  -- Display the Mover
  mover:display()
end

--[[
  Acceleration with Vectors
  by Daniel Shiffman.

  Demonstration of the basics of motion with vector.
  A "Mover" object stores location, velocity, and acceleration as vectors
  The motion is controlled by affecting the acceleration (in this case towards the mouse)
]]

Mover = {}
Mover.__index = Mover

-- The Mover tracks location, velocity, and acceleration
-- The Mover's maximum speed
function Mover.new()
  local self = setmetatable({}, Mover)
  -- Start in the center
  self.location = createVector(width / 2, height / 2)
  self.velocity = createVector(0, 0)
  self.topspeed = 5
  return self
end

function Mover:update()
  -- Compute a vector that points from location to mouse
  local mouse = createVector(mouseX, mouseY)
  local acceleration = (mouse - self.location)
  -- Set magnitude of acceleration
  acceleration:setMag(0.2)

  -- Velocity changes according to acceleration
  self.velocity:add(acceleration)
  -- Limit the velocity by topspeed
  self.velocity:limit(self.topspeed)
  -- Location changes by velocity
  self.location:add(self.velocity)
end

function Mover:display()
  stroke(255)
  strokeWeight(2)
  fill(127)
  ellipse(self.location.x, self.location.y, 48, 48)
end
