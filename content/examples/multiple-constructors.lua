--[[
  Multiple constructors

  A class can have multiple constructors that assign the fields in different ways.
  Sometimes it's beneficial to specify every aspect of an object's data by assigning
  parameters to the fields, but other times it might be appropriate to define only
  one or a few.
]]

local sp1
local sp2

function setup()
  size(640, 360)
  background(204)
  noLoop()
  -- Run the constructor without parameters
  sp1 = Spot.new()
  -- Run the constructor with three parameters
  sp2 = Spot.new(width * 0.5, height * 0.5, 120)
end

function draw()
  sp1:display()
  sp2:display()
end

Spot = {}
Spot.__index = Spot

-- Lua has one function per name, so both versions of the constructor
-- live in Spot.new. With no arguments the fields get default values;
-- with three they are assigned from the parameters.
function Spot.new(xpos, ypos, r)
  if xpos == nil then
    local self = setmetatable({}, Spot)
    self.radius = 40
    self.x = width * 0.25
    self.y = height * 0.5
    return self
  end
  local self = setmetatable({}, Spot)
  self.x = xpos
  self.y = ypos
  self.radius = r
  return self
end

function Spot:display()
  ellipse(self.x, self.y, self.radius * 2, self.radius * 2)
end
