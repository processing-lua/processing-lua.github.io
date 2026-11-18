--[[
  Inheritance

  A class can be defined using another class as a foundation. In object-oriented
  programming terminology, one class can inherit fi elds and methods from another.
  An object that inherits from another is called a subclass, and the object it
  inherits from is called a superclass. A subclass extends the superclass.
]]

local spots
local arm

function setup()
  size(640, 360)
  arm = SpinArm.new(width / 2, height / 2, 0.01)
  spots = SpinSpots.new(width / 2, height / 2, -0.02, 90.0)
end

function draw()
  background(204)
  arm:update()
  arm:display()
  spots:update()
  spots:display()
end

Spin = {}
Spin.__index = Spin

function Spin.new(xpos, ypos, s)
  local self = setmetatable({}, Spin)
  self.angle = 0.0
  self.x = xpos
  self.y = ypos
  self.speed = s
  return self
end

function Spin:update()
  self.angle = self.angle + self.speed
end

SpinArm = setmetatable({}, { __index = Spin })
SpinArm.__index = SpinArm

function SpinArm.new(x, y, s)
  local self = setmetatable(Spin.new(x, y, s), SpinArm)
  return self
end

function SpinArm:display()
  strokeWeight(1)
  stroke(0)
  pushMatrix()
  translate(self.x, self.y)
  self.angle = self.angle + self.speed
  rotate(self.angle)
  line(0, 0, 165, 0)
  popMatrix()
end

SpinSpots = setmetatable({}, { __index = Spin })
SpinSpots.__index = SpinSpots

function SpinSpots.new(x, y, s, d)
  local self = setmetatable(Spin.new(x, y, s), SpinSpots)
  self.dim = d
  return self
end

function SpinSpots:display()
  noStroke()
  pushMatrix()
  translate(self.x, self.y)
  self.angle = self.angle + self.speed
  rotate(self.angle)
  ellipse(-self.dim / 2, 0, self.dim, self.dim)
  ellipse(self.dim / 2, 0, self.dim, self.dim)
  popMatrix()
end
