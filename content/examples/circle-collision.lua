--[[
  Circle Collision with Swapping Velocities
  by Ira Greenberg.

  Based on Keith Peter's Solution in
  Foundation Actionscript Animation: Making Things Move!
]]

local balls

Ball = {}
Ball.__index = Ball

function Ball.new(x, y, r_)
  local self = setmetatable({}, Ball)
  self.position = createVector(x, y)
  self.velocity = PVector.random2D()
  self.velocity:mult(3)
  self.radius = r_
  self.m = self.radius * 0.1
  return self
end

function Ball:update()
  self.position:add(self.velocity)
end

function Ball:checkBoundaryCollision()
  if self.position.x > width - self.radius then
    self.position.x = width - self.radius
    self.velocity.x = self.velocity.x * -1
  elseif self.position.x < self.radius then
    self.position.x = self.radius
    self.velocity.x = self.velocity.x * -1
  elseif self.position.y > height - self.radius then
    self.position.y = height - self.radius
    self.velocity.y = self.velocity.y * -1
  elseif self.position.y < self.radius then
    self.position.y = self.radius
    self.velocity.y = self.velocity.y * -1
  end
end

function Ball:checkCollision(other)
  -- Get distances between the balls components
  local distanceVect = (other.position - self.position)

  -- Calculate magnitude of the vector separating the balls
  local distanceVectMag = distanceVect:mag()

  -- Minimum distance before they are touching
  local minDistance = self.radius + other.radius

  if distanceVectMag < minDistance then
    local distanceCorrection = (minDistance - distanceVectMag) / 2.0
    local d = distanceVect:copy()
    local correctionVector = d:normalize():mult(distanceCorrection)
    other.position:add(correctionVector)
    self.position:sub(correctionVector)

    -- get angle of distanceVect
    local theta = distanceVect:heading()
    -- precalculate trig values
    local sine = sin(theta)
    local cosine = cos(theta)

    --[[
       bTemp will hold rotated ball positions. You
             just need to worry about bTemp[1] position
    ]]
    local bTemp = {createVector(), createVector()}

    --[[
       this ball's position is relative to the other
             so you can use the vector between them (bVect) as the
             reference point in the rotation expressions.
             bTemp[0].position.x and bTemp[0].position.y will initialize
             automatically to 0.0, which is what you want
             since b[1] will rotate around b[0]
    ]]
    bTemp[2].x = cosine * distanceVect.x + sine * distanceVect.y
    bTemp[2].y = cosine * distanceVect.y - sine * distanceVect.x

    -- rotate Temporary velocities
    local vTemp = {createVector(), createVector()}

    vTemp[1].x = cosine * self.velocity.x + sine * self.velocity.y
    vTemp[1].y = cosine * self.velocity.y - sine * self.velocity.x
    vTemp[2].x = cosine * other.velocity.x + sine * other.velocity.y
    vTemp[2].y = cosine * other.velocity.y - sine * other.velocity.x

    --[[
       Now that velocities are rotated, you can use 1D
             conservation of momentum equations to calculate
             the final velocity along the x-axis.
    ]]
    local vFinal = {createVector(), createVector()}

    -- final rotated velocity for b[0]
    vFinal[1].x = ((self.m - other.m) * vTemp[1].x + 2 * other.m * vTemp[2].x) / (self.m + other.m)
    vFinal[1].y = vTemp[1].y

    -- final rotated velocity for b[0]
    vFinal[2].x = ((other.m - self.m) * vTemp[2].x + 2 * self.m * vTemp[1].x) / (self.m + other.m)
    vFinal[2].y = vTemp[2].y

    -- hack to avoid clumping
    bTemp[1].x = bTemp[1].x + vFinal[1].x
    bTemp[2].x = bTemp[2].x + vFinal[2].x

    --[[
       Rotate ball positions and velocities back
             Reverse signs in trig expressions to rotate
             in the opposite direction
    ]]
    -- rotate balls
    local bFinal = {createVector(), createVector()}

    bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y
    bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x
    bFinal[2].x = cosine * bTemp[2].x - sine * bTemp[2].y
    bFinal[2].y = cosine * bTemp[2].y + sine * bTemp[2].x

    -- update balls to screen position
    other.position.x = self.position.x + bFinal[2].x
    other.position.y = self.position.y + bFinal[2].y

    self.position:add(bFinal[1])

    -- update velocities
    self.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y
    self.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x
    other.velocity.x = cosine * vFinal[2].x - sine * vFinal[2].y
    other.velocity.y = cosine * vFinal[2].y + sine * vFinal[2].x
  end
end

function Ball:display()
  noStroke()
  fill(204)
  ellipse(self.position.x, self.position.y, self.radius * 2, self.radius * 2)
end

balls = {Ball.new(100, 400, 20), Ball.new(700, 400, 80)}

function setup()
  size(640, 360)
end

function draw()
  background(51)

  for _, b in ipairs(balls) do
    b:update()
    b:display()
    b:checkBoundaryCollision()
  end

  balls[1]:checkCollision(balls[2])
end
