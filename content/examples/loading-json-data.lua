--[[
  Loading JSON Data
  by Daniel Shiffman.

  This example demonstrates how to use loadJSON()
  to retrieve data from a JSON file and make objects
  from that data.

  Here is what the JSON looks like (partial):

   {
   "bubbles": [
   {
   "position": {
   "x": 160,
   "y": 103
   },
   "diameter": 43.19838,
   "label": "Happy"
   },
   {
   "position": {
   "x": 372,
   "y": 137
   },
   "diameter": 52.42526,
   "label": "Sad"
   }
   ]
   }
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
-- A JSON object
local json

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
  --
  textAlign(LEFT)
  fill(0)
  text("Click to add bubbles.", 10, height - 10)
end
function loadData()
  -- Load JSON file
  -- Temporary full path until path problem resolved.
  json = loadJSONObject("data.json")

  local bubbleData = json:getJSONArray("bubbles")

  -- The size of the array of Bubble objects is determined by the total XML elements named "bubble"
  bubbles = newArray(bubbleData:size(), nil)

  for i = 0, bubbleData:size() - 1 do
    -- Get each object in the array
    local bubble = bubbleData:getJSONObject(i)
    -- Get a position object
    local position = bubble:getJSONObject("position")
    -- Get x,y from position
    local x = position:getInt("x")
    local y = position:getInt("y")

    -- Get diamter and label
    local diameter = bubble:getFloat("diameter")
    local label = bubble:getString("label")

    -- Put object in array
    bubbles[i + 1] = Bubble.new(x, y, diameter, label)
  end
end

function mousePressed()
  -- Create a new JSON bubble object
  local newBubble = JSONObject()

  -- Create a new JSON position object
  local position = JSONObject()
  position:setInt("x", mouseX)
  position:setInt("y", mouseY)

  -- Add position to bubble
  newBubble:setJSONObject("position", position)

  -- Add diamater and label to bubble
  newBubble:setFloat("diameter", random(40, 80))
  newBubble:setString("label", "New label")

  -- Append the new JSON bubble object to the array
  local bubbleData = json:getJSONArray("bubbles")
  bubbleData:append(newBubble)

  if bubbleData:size() > 10 then
    bubbleData:remove(0)
  end

  -- Save new data
  saveJSONObject(json, "data/data.json")
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
