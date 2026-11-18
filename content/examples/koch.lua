--[[
  Koch Curve
  by Daniel Shiffman.

  Renders a simple fractal, the Koch snowflake.
  Each recursive level is drawn in sequence.
]]

local k

function setup()
  size(640, 360)
  frameRate(1)  -- Animate slowly
  k = KochFractal.new()
end

function draw()
  background(0)
  -- Draws the snowflake!
  k:render()
  -- Iterate
  k:nextLevel()
  -- Let's not do it more than 5 times. . .
  if k:getCount() > 5 then
    k:restart()
  end
end

-- Koch Curve
-- A class to manage the list of line segments in the snowflake pattern

KochFractal = {}
KochFractal.__index = KochFractal

-- A PVector for the start
-- A PVector for the end
-- A list to keep track of all the lines
function KochFractal.new()
  local self = setmetatable({}, KochFractal)
  self.count = 0
  self.start = createVector(0, height - 20)
  self.end_ = createVector(width, height - 20)
  self.lines = {}
  self:restart()
  return self
end

function KochFractal:nextLevel()
  -- For every line that is in the arraylist
  -- create 4 more lines in a new arraylist
  self.lines = self:iterate(self.lines)
  self.count = self.count + 1
end

function KochFractal:restart()
  self.count = 0  -- Reset count
  for i = #self.lines, 1, -1 do self.lines[i] = nil end  -- Empty the array list
  table.insert(self.lines, KochLine.new(self.start, self.end_))  -- Add the initial line (from one end PVector to the other)
end

function KochFractal:getCount()
  return self.count
end

-- This is easy, just draw all the lines
function KochFractal:render()
  for _, l in ipairs(self.lines) do
    l:display()
  end
end

-- This is where the **MAGIC** happens
-- Step 1: Create an empty arraylist
-- Step 2: For every line currently in the arraylist
--   - calculate 4 line segments based on Koch algorithm
--   - add all 4 line segments into the new arraylist
-- Step 3: Return the new arraylist and it becomes the list of line segments for the structure
-- As we do this over and over again, each line gets broken into 4 lines, which gets broken into 4 lines, and so on. . .
function KochFractal:iterate(before)
  local now = {}  -- Create emtpy list
  for _, l in ipairs(before) do
    -- Calculate 5 koch PVectors (done for us by the line object)
    local a = l:start()
    local b = l:kochleft()
    local c = l:kochmiddle()
    local d = l:kochright()
    local e = l:end_()
    -- Make line segments between all the PVectors and add them
    table.insert(now, KochLine.new(a, b))
    table.insert(now, KochLine.new(b, c))
    table.insert(now, KochLine.new(c, d))
    table.insert(now, KochLine.new(d, e))
  end
  return now
end

-- The Nature of Code
-- Daniel Shiffman
-- http://natureofcode.com

-- Koch Curve
-- A class to describe one line segment in the fractal
-- Includes methods to calculate midPVectors along the line according to the Koch algorithm

KochLine = {}
KochLine.__index = KochLine

-- Two PVectors,
-- a is the "left" PVector and
-- b is the "right PVector
function KochLine.new(start, end_)
  local self = setmetatable({}, KochLine)
  self.a = start:copy()
  self.b = end_:copy()
  return self
end

function KochLine:display()
  stroke(255)
  line(self.a.x, self.a.y, self.b.x, self.b.y)
end

function KochLine:start()
  return self.a:copy()
end

function KochLine:end_()
  return self.b:copy()
end

-- This is easy, just 1/3 of the way
function KochLine:kochleft()
  local v = (self.b - self.a)
  v:div(3)
  v:add(self.a)
  return v
end

-- More complicated, have to use a little trig to figure out where this PVector is!
function KochLine:kochmiddle()
  local v = (self.b - self.a)
  v:div(3)

  local p = self.a:copy()
  p:add(v)

  v:rotate(-radians(60))
  p:add(v)

  return p
end

-- Easy, just 2/3 of the way
function KochLine:kochright()
  local v = (self.a - self.b)
  v:div(3)
  v:add(self.b)
  return v
end
