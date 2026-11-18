--[[
  Pentigree L-System
  by Geraldine Sarmiento.

  This example was based on Patrick Dwyer's L-System class.
]]

local ps

function setup()
  size(640, 360)
  ps = PentigreeLSystem.new()
  ps:simulate(3)
end

function draw()
  background(0)
  ps:render()
end

LSystem = {}
LSystem.__index = LSystem

function LSystem.new()
  local self = setmetatable({}, LSystem)
  self.steps = 0
  self.production = nil
  self.drawLength = 0
  self.generations = 0
  self.axiom = "F"
  self.rule = "F+F-F"
  self.startLength = 90.0
  self.theta = radians(120.0)
  self:reset()
  return self
end

function LSystem:reset()
  self.production = self.axiom
  self.drawLength = self.startLength
  self.generations = 0
end

function LSystem:getAge()
  return self.generations
end

function LSystem:render()
  translate(width / 2, height / 2)
  self.steps = self.steps + 5
  if self.steps > #self.production then
    self.steps = #self.production
  end
  for i = 0, self.steps - 1 do
    local step = self.production:sub(i + 1, i + 1)
    if step == "F" then
      rect(0, 0, -self.drawLength, -self.drawLength)
      noFill()
      translate(0, -self.drawLength)
    elseif step == "+" then
      rotate(self.theta)
    elseif step == "-" then
      rotate(-self.theta)
    elseif step == "[" then
      pushMatrix()
    elseif step == "]" then
      popMatrix()
    end
  end
end

function LSystem:simulate(gen)
  while self:getAge() < gen do
    self.production = self:iterate(self.production, self.rule)
  end
end

function LSystem:iterate(prod_, rule_)
  self.drawLength = self.drawLength * 0.6
  self.generations = self.generations + 1
  local newProduction = prod_
  newProduction = newProduction:gsub("F", rule_)
  return newProduction
end

PentigreeLSystem = setmetatable({}, { __index = LSystem })
PentigreeLSystem.__index = PentigreeLSystem

function PentigreeLSystem.new()
  local self = setmetatable(LSystem.new(), PentigreeLSystem)
  self.steps = 0
  self.somestep = 0.1
  self.xoff = 0.01
  self.axiom = "F-F-F-F-F"
  self.rule = "F-F++F+F-F-F"
  self.startLength = 60.0
  self.theta = radians(72)
  self:reset()
  return self
end

function PentigreeLSystem:useRule(r_)
  self.rule = r_
end

function PentigreeLSystem:useAxiom(a_)
  self.axiom = a_
end

function PentigreeLSystem:useLength(l_)
  self.startLength = l_
end

function PentigreeLSystem:useTheta(t_)
  self.theta = radians(t_)
end

function PentigreeLSystem:reset()
  self.production = self.axiom
  self.drawLength = self.startLength
  self.generations = 0
end

function PentigreeLSystem:getAge()
  return self.generations
end

function PentigreeLSystem:render()
  translate(width / 4, height / 2)
  self.steps = self.steps + 3
  if self.steps > #self.production then
    self.steps = #self.production
  end

  for i = 0, self.steps - 1 do
    local step = self.production:sub(i + 1, i + 1)
    if step == "F" then
      noFill()
      stroke(255)
      line(0, 0, 0, -self.drawLength)
      translate(0, -self.drawLength)
    elseif step == "+" then
      rotate(self.theta)
    elseif step == "-" then
      rotate(-self.theta)
    elseif step == "[" then
      pushMatrix()
    elseif step == "]" then
      popMatrix()
    end
  end
end
