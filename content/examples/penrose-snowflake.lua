--[[
  Penrose Snowflake L-System
  by Geraldine Sarmiento.

  This example was based on Patrick Dwyer's L-System class.
]]

local ps

function setup()
  size(640, 360)
  stroke(255)
  noFill()
  ps = PenroseSnowflakeLSystem.new()
  ps:simulate(4)
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

PenroseSnowflakeLSystem = setmetatable({}, { __index = LSystem })
PenroseSnowflakeLSystem.__index = PenroseSnowflakeLSystem

function PenroseSnowflakeLSystem.new()
  local self = setmetatable(LSystem.new(), PenroseSnowflakeLSystem)
  self.axiom = "F3-F3-F3-F3-F"
  self.ruleF = "F3-F3-F45-F++F3-F"
  self.startLength = 450.0
  self.theta = radians(18)
  self:reset()
  return self
end

function PenroseSnowflakeLSystem:useRule(r_)
  self.rule = r_
end

function PenroseSnowflakeLSystem:useAxiom(a_)
  self.axiom = a_
end

function PenroseSnowflakeLSystem:useLength(l_)
  self.startLength = l_
end

function PenroseSnowflakeLSystem:useTheta(t_)
  self.theta = radians(t_)
end

function PenroseSnowflakeLSystem:reset()
  self.production = self.axiom
  self.drawLength = self.startLength
  self.generations = 0
end

function PenroseSnowflakeLSystem:getAge()
  return self.generations
end

function PenroseSnowflakeLSystem:render()
  translate(width, height)
  local repeats = 1

  self.steps = self.steps + 3
  if self.steps > #self.production then
    self.steps = #self.production
  end

  for i = 0, self.steps - 1 do
    local step = self.production:sub(i + 1, i + 1)
    if step == "F" then
      for j = 1, repeats do
        line(0, 0, 0, -self.drawLength)
        translate(0, -self.drawLength)
      end
      repeats = 1
    elseif step == "+" then
      for j = 1, repeats do
        rotate(self.theta)
      end
      repeats = 1
    elseif step == "-" then
      for j = 1, repeats do
        rotate(-self.theta)
      end
      repeats = 1
    elseif step == "[" then
      pushMatrix()
    elseif step == "]" then
      popMatrix()
    elseif step >= "0" and step <= "9" then
      repeats = repeats + tonumber(step)
    end
  end
end

function PenroseSnowflakeLSystem:iterate(prod_, rule_)
  local newProduction = ""
  for i = 0, #prod_ - 1 do
    local step = self.production:sub(i + 1, i + 1)
    if step == "F" then
      newProduction = newProduction .. self.ruleF
    else
      if step ~= "F" then
        newProduction = newProduction .. step
      end
    end
  end
  self.drawLength = self.drawLength * 0.4
  self.generations = self.generations + 1
  return newProduction
end
