--[[
  Composite Objects

  An object can include several other objects. Creating such composite objects
  is a good way to use the principles of modularity and build higher levels of
  abstraction within a program.
]]

local er1
local er2

function setup()
  size(640, 360)
  er1 = EggRing.new(width * 0.45, height * 0.5, 2, 120)
  er2 = EggRing.new(width * 0.65, height * 0.8, 10, 180)
end

function draw()
  background(0)
  er1:transmit()
  er2:transmit()
end

Egg = {}
Egg.__index = Egg

-- X-coordinate, y-coordinate
-- Left and right angle offset
-- Used to define the tilt
-- Height of the egg
-- Constructor
function Egg.new(xpos, ypos, r, s)
  local self = setmetatable({}, Egg)
  self.angle = 0
  self.x = xpos
  self.y = ypos
  self.tilt = 0
  self.scalar = s / 100.0
  self.range = r
  return self
end

function Egg:wobble()
  self.tilt = cos(self.angle) / self.range
  self.angle = self.angle + 0.1
  --print (angle + "-");
end

function Egg:display()
  noStroke()
  fill(255)
  pushMatrix()
  translate(self.x, self.y)
  rotate(self.tilt)
  scale(self.scalar)
  beginShape()
  vertex(0, -100)
  bezierVertex(25, -100, 40, -65, 40, -40)
  bezierVertex(40, -15, 25, 0, 0, 0)
  bezierVertex(-25, 0, -40, -15, -40, -40)
  bezierVertex(-40, -65, -25, -100, 0, -100)
  endShape()
  popMatrix()
end

EggRing = {}
EggRing.__index = EggRing

function EggRing.new(x, y, t, sp)
  local self = setmetatable({}, EggRing)
  self.circle = Ring.new()
  self.ovoid = Egg.new(x, y, t, sp)
  self.circle:start(x, y - sp / 2)
  return self
end

function EggRing:transmit()
  self.ovoid:wobble()
  self.ovoid:display()
  self.circle:grow()
  self.circle:display()
  if self.circle.on == false then
    self.circle.on = true
  end
end

Ring = {}
Ring.__index = Ring

-- X-coordinate, y-coordinate
-- Diameter of the ring
-- Turns the display on and off
function Ring:start(xpos, ypos)
  self.x = xpos
  self.y = ypos
  self.on = true
  self.diameter = 1
end

function Ring:grow()
  if self.on == true then
    self.diameter = self.diameter + 0.5
    if self.diameter > width * 2 then
      self.diameter = 0.0
    end
  end
end

function Ring:display()
  if self.on == true then
    noFill()
    strokeWeight(4)
    stroke(155, 153)
    ellipse(self.x, self.y, self.diameter, self.diameter)
  end
end

function Ring.new()
  local self = setmetatable({}, Ring)
  self.x = 0
  self.y = 0
  self.diameter = 0
  self.on = false
  return self
end
