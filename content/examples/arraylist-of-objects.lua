--[[
  ArrayList of objects
  by Daniel Shiffman.

  This example demonstrates how to use a Java ArrayList to store
  a variable number of objects.  Items can be added and removed
  from the ArrayList.

  Click the mouse to add bouncing balls.
]]

local balls
local ballWidth = 48

function setup()
  size(640, 360)
  noStroke()

  -- Create an empty ArrayList (will store Ball objects)
  balls = {}

  -- Start by adding one element
  table.insert(balls, Ball.new(width / 2, 0, ballWidth))
end

function draw()
  background(255)

  -- With an array, we say balls.length, with an ArrayList, we say balls.size()
  -- The length of an ArrayList is dynamic
  -- Notice how we are looping through the ArrayList backwards
  -- This is because we are deleting elements from the list
  for i = #balls - 1, 0, -1 do
    -- An ArrayList doesn't know what it is storing so we have to cast the object coming out
    local ball = balls[i + 1]
    ball:move()
    ball:display()
    if ball:finished() then
      -- Items can be deleted with remove()
      table.remove(balls, i + 1)
    end
  end
end

function mousePressed()
  -- A new ball object is added to the ArrayList (by default to the end)
  table.insert(balls, Ball.new(mouseX, mouseY, ballWidth))
end

-- Simple bouncing ball class

Ball = {}
Ball.__index = Ball

function Ball.new(tempX, tempY, tempW)
  local self = setmetatable({}, Ball)
  self.life = 255
  self.x = tempX
  self.y = tempY
  self.w = tempW
  self.speed = 0
  self.gravity = 0.1
  return self
end

function Ball:move()
  -- Add gravity to speed
  self.speed = self.speed + self.gravity
  -- Add speed to y location
  self.y = self.y + self.speed
  -- If square reaches the bottom
  -- Reverse speed
  if self.y > height then
    -- Dampening
    self.speed = self.speed * -0.8
    self.y = height
  end
end

function Ball:finished()
  -- Balls fade out
  self.life = self.life - 1
  if self.life < 0 then
    return true
  else
    return false
  end
end

function Ball:display()
  -- Display the circle
  fill(0, self.life)
  --stroke(0,life);
  ellipse(self.x, self.y, self.w, self.w)
end
