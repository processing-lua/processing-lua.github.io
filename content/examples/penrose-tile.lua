--[[
  Penrose Tile L-System
  by Geraldine Sarmiento.

  This example was based on Patrick Dwyer's L-System class.
]]

local ds

function setup()
  size(640, 360)
  ds = PenroseLSystem.new()
  ds:simulate(4)
end

function draw()
  background(0)
  ds:render()
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
  self.startLength = 190.0
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

PenroseLSystem = setmetatable({}, { __index = LSystem })
PenroseLSystem.__index = PenroseLSystem

function PenroseLSystem.new()
  local self = setmetatable(LSystem.new(), PenroseLSystem)
  self.steps = 0
  self.somestep = 0.1
  self.axiom = "[X]++[X]++[X]++[X]++[X]"
  self.ruleW = "YF++ZF4-XF[-YF4-WF]++"
  self.ruleX = "+YF--ZF[3-WF--XF]+"
  self.ruleY = "-WF++XF[+++YF++ZF]-"
  self.ruleZ = "--YF++++WF[+ZF++++XF]--XF"
  self.startLength = 460.0
  self.theta = radians(36)
  self:reset()
  return self
end

function PenroseLSystem:useRule(r_)
  self.rule = r_
end

function PenroseLSystem:useAxiom(a_)
  self.axiom = a_
end

function PenroseLSystem:useLength(l_)
  self.startLength = l_
end

function PenroseLSystem:useTheta(t_)
  self.theta = radians(t_)
end

function PenroseLSystem:reset()
  self.production = self.axiom
  self.drawLength = self.startLength
  self.generations = 0
end

function PenroseLSystem:getAge()
  return self.generations
end

function PenroseLSystem:render()
  translate(width / 2, height / 2)
  local pushes = 0
  local repeats = 1
  self.steps = self.steps + 12
  if self.steps > #self.production then
    self.steps = #self.production
  end

  for i = 0, self.steps - 1 do
    local step = self.production:sub(i + 1, i + 1)
    if step == "F" then
      stroke(255, 60)
      for j = 1, repeats do
        line(0, 0, 0, -self.drawLength)
        noFill()
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
      pushes = pushes + 1
      pushMatrix()
    elseif step == "]" then
      popMatrix()
      pushes = pushes - 1
    elseif step >= "0" and step <= "9" then
      repeats = tonumber(step)
    end
  end

  -- Unpush if we need too
  while pushes > 0 do
    popMatrix()
    pushes = pushes - 1
  end
end

function PenroseLSystem:iterate(prod_, rule_)
  local newProduction = ""
  for i = 0, #prod_ - 1 do
    local step = self.production:sub(i + 1, i + 1)
    if step == "W" then
      newProduction = newProduction .. self.ruleW
    elseif step == "X" then
      newProduction = newProduction .. self.ruleX
    elseif step == "Y" then
      newProduction = newProduction .. self.ruleY
    elseif step == "Z" then
      newProduction = newProduction .. self.ruleZ
    else
      if step ~= "F" then
        newProduction = newProduction .. step
      end
    end
  end

  self.drawLength = self.drawLength * 0.5
  self.generations = self.generations + 1
  return newProduction
end
