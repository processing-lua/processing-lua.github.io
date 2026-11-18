--[[
  Wolfram Cellular Automata
  by Daniel Shiffman.

  Simple demonstration of a Wolfram's 1-dimensional
  cellular automata. When the system reaches bottom
  of the window, it restarts with a new ruleset.
  Mouse click restarts as well.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local ca  -- An instance object to the cellular automata

function setup()
  size(640, 360)
  local ruleset = {0, 1, 0, 1, 1, 0, 1, 0}  -- An initial rule system
  ca = CA.new(ruleset)  -- Initialize CA
  background(0)
end

function draw()
  ca:render()  -- Draw the CA
  ca:generate()  -- Generate the next level

  -- If we're done, clear the screen,
  -- pick a new ruleset and restart
  if ca:finished() then
    background(0)
    ca:randomize()
    ca:restart()
  end
end

function mousePressed()
  background(0)
  ca:randomize()
  ca:restart()
end

CA = {}
CA.__index = CA

-- An array of 0s and 1s
-- How many generations?
-- How many pixels wide/high is each cell?
-- Array to store the rules, for example {0,1,1,0,1,1,0,1}
function CA.new(r)
  local self = setmetatable({}, CA)
  self.generation = 0
  self.rules = r
  self.scl = 1
  self.cells = newArray(width // self.scl, 0)
  self:restart()
  return self
end

-- Set the rules of the CA
function CA:setRules(r)
  self.rules = r
end

-- Make a random ruleset
function CA:randomize()
  for i = 1, 8 do
    self.rules[i] = int(random(2))
  end
end

-- Reset to generation 0
function CA:restart()
  for i = 1, #self.cells do
    self.cells[i] = 0
  end
  -- We arbitrarily start with just the middle
  -- cell having a state of "1"
  self.cells[#self.cells // 2 + 1] = 1
  self.generation = 0
end

-- The process of creating the new generation
function CA:generate()
  -- First we create an empty array for the new values
  local nextgen = newArray(#self.cells, 0)
  -- For every spot, determine new state by examing current
  -- state, and neighbor states
  -- Ignore edges that only have one neighor
  for i = 1, #self.cells - 1 - 1 do
    local left = self.cells[i]  -- Left neighbor state
    local me = self.cells[i + 1]  -- Current state
    local right = self.cells[i + 1 + 1]  -- Right neighbor state
    -- Compute next generation state based on ruleset
    nextgen[i + 1] = self:executeRules(left, me, right)
  end
  -- Copy the array into current value
  for i = 1, #self.cells - 1 - 1 do
    self.cells[i + 1] = nextgen[i + 1]
  end
  --cells = (int[]) nextgen.clone();
  self.generation = self.generation + 1
end

-- This is the easy part, just draw the cells,
-- fill 255 for '1', fill 0 for '0'
function CA:render()
  for i = 0, #self.cells - 1 do
    if self.cells[i + 1] == 1 then
      fill(255)
    else
      fill(0)
    end
    noStroke()
    rect(i * self.scl, self.generation * self.scl, self.scl, self.scl)
  end
end

-- Implementing the Wolfram rules
-- Could be improved and made more concise,
-- but here we can explicitly see what is going on for each case
function CA:executeRules(a, b, c)
  if a == 1 and b == 1 and c == 1 then
    return self.rules[1]
  end
  if a == 1 and b == 1 and c == 0 then
    return self.rules[2]
  end
  if a == 1 and b == 0 and c == 1 then
    return self.rules[3]
  end
  if a == 1 and b == 0 and c == 0 then
    return self.rules[4]
  end
  if a == 0 and b == 1 and c == 1 then
    return self.rules[5]
  end
  if a == 0 and b == 1 and c == 0 then
    return self.rules[6]
  end
  if a == 0 and b == 0 and c == 1 then
    return self.rules[7]
  end
  if a == 0 and b == 0 and c == 0 then
    return self.rules[8]
  end
  return 0
end

-- The CA is done if it reaches the bottom of the screen
function CA:finished()
  if self.generation > height / self.scl then
    return true
  else
    return false
  end
end
