--[[
  Bouncing Ball with Vectors
  by Daniel Shiffman.

  Demonstration of using vectors to control motion
  of a body. This example is not object-oriented
  See AccelerationWithVectors for an example of how
  to simulate motion using vectors in an object.
]]

local location  -- Location of shape
local velocity  -- Velocity of shape
local gravity  -- Gravity acts at the shape's acceleration

function setup()
  size(640, 360)
  location = createVector(100, 100)
  velocity = createVector(1.5, 2.1)
  gravity = createVector(0, 0.2)
end

function draw()
  background(0)

  -- Add velocity to the location.
  location:add(velocity)
  -- Add gravity to velocity
  velocity:add(gravity)

  -- Bounce off edges
  if (location.x > width) or (location.x < 0) then
    velocity.x = velocity.x * -1
  end
  if location.y > height then
    -- We're reducing velocity ever so slightly
    -- when it hits the bottom of the window
    velocity.y = velocity.y * -0.95
    location.y = height
  end

  -- Display circle at location vector
  stroke(255)
  strokeWeight(2)
  fill(127)
  ellipse(location.x, location.y, 48, 48)
end
