--[[
  Loading Tabular Data
  by Daniel Shiffman.

  This example demonstrates how to use loadTable()
  to retrieve data from a CSV file and make objects
  from that data.

  Here is what the CSV looks like:

   x,y,diameter,name
   160,103,43.19838,Happy
   372,137,52.42526,Sad
   273,235,61.14072,Joyous
   121,179,44.758068,Melancholy
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

-- An Array of Bubble objects
local bubbles
-- A Table object
local table

function setup()
  size(640, 360)
  loadData()
end

function draw()
  background(255)
  -- Display all bubbles
  for _, b in ipairs(bubbles) do
    b:display()
    b:rollover(mouseX, mouseY)
  end

  textAlign(LEFT)
  fill(0)
  text("Click to add bubbles.", 10, height - 10)
end

function loadData()
  -- Load CSV file into a Table object
  -- "header" option indicates the file has a header row
  table = loadTable("data.csv", "header")

  -- The size of the array of Bubble objects is determined by the total number of rows in the CSV
  bubbles = newArray(table:getRowCount(), nil)

  -- You can access iterate over all the rows in a table
  local rowCount = 0
  for row in table:rows() do
    -- You can access the fields via their column name (or index)
    local x = row:getFloat("x")
    local y = row:getFloat("y")
    local d = row:getFloat("diameter")
    local n = row:getString("name")
    -- Make a Bubble object out of the data read
    bubbles[rowCount + 1] = Bubble.new(x, y, d, n)
    rowCount = rowCount + 1
  end
end

function mousePressed()
  -- Create a new row
  local row = table:addRow()
  -- Set the values of that row
  row:setFloat("x", mouseX)
  row:setFloat("y", mouseY)
  row:setFloat("diameter", random(40, 80))
  row:setString("name", "Blah")

  -- If the table has more than 10 rows
  if table:getRowCount() > 10 then
    -- Delete the oldest row
    table:removeRow(0)
  end

  -- Writing the CSV back to the same file
  saveTable(table, "data/data.csv")
  -- And reloading it
  loadData()
end

-- A Bubble class

Bubble = {}
Bubble.__index = Bubble

-- Create  the Bubble
function Bubble.new(x_, y_, diameter_, s)
  local self = setmetatable({}, Bubble)
  self.over = false
  self.x = x_
  self.y = y_
  self.diameter = diameter_
  self.name = s
  return self
end

-- CHecking if mouse is over the Bubble
function Bubble:rollover(px, py)
  local d = dist(px, py, self.x, self.y)
  if d < self.diameter / 2 then
    self.over = true
  else
    self.over = false
  end
end

-- Display the Bubble
function Bubble:display()
  stroke(0)
  strokeWeight(2)
  noFill()
  ellipse(self.x, self.y, self.diameter, self.diameter)
  if self.over then
    fill(0)
    textAlign(CENTER)
    text(self.name, self.x, self.y + self.diameter / 2 + 20)
  end
end
