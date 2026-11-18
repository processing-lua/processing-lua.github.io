--[[
  Handles.

  Click and drag the white boxes to change their position.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local handles

--True if a mouse button has just been pressed while no other button was.
local firstMousePress = false

function setup()
  size(640, 360)
  local num = height // 15
  handles = newArray(num, nil)
  local hsize = 10
  for i = 0, #handles - 1 do
    handles[i + 1] = Handle.new(width / 2, 10 + i * 15, 50 - hsize / 2, 10, handles)
  end
end

function draw()
  background(153)

  for i = 1, #handles do
    handles[i]:update()
    handles[i]:display()
  end

  fill(0)
  rect(0, 0, width / 2, height)

  --After it has been used in the sketch, set it back to false
  if firstMousePress then
    firstMousePress = false
  end
end

function mousePressed()
  if not firstMousePress then
    firstMousePress = true
  end
end

function mouseReleased()
  for i = 1, #handles do
    handles[i]:releaseEvent()
  end
end

Handle = {}
Handle.__index = Handle

function Handle.new(ix, iy, il, is, o)
  local self = setmetatable({}, Handle)
  self.over = false
  self.press = false
  self.locked = false
  self.otherslocked = false
  self.x = ix
  self.y = iy
  self.stretch = il
  self.size = is
  self.boxx = self.x + self.stretch - self.size // 2
  self.boxy = self.y - self.size // 2
  self.others = o
  return self
end

function Handle:update()
  self.boxx = self.x + self.stretch
  self.boxy = self.y - self.size // 2

  for i = 1, #self.others do
    if self.others[i].locked == true then
      self.otherslocked = true
      break
    else
      self.otherslocked = false
    end
  end

  if self.otherslocked == false then
    self:overEvent()
    self:pressEvent()
  end

  if self.press then
    self.stretch = lock(mouseX - width / 2 - self.size / 2, 0, width / 2 - self.size - 1)
  end
end

function Handle:overEvent()
  if overRect(self.boxx, self.boxy, self.size, self.size) then
    self.over = true
  else
    self.over = false
  end
end

function Handle:pressEvent()
  if self.over and firstMousePress or self.locked then
    self.press = true
    self.locked = true
  else
    self.press = false
  end
end

function Handle:releaseEvent()
  self.locked = false
end

function Handle:display()
  line(self.x, self.y, self.x + self.stretch, self.y)
  fill(255)
  stroke(0)
  rect(self.boxx, self.boxy, self.size, self.size)
  if self.over or self.press then
    line(self.boxx, self.boxy, self.boxx + self.size, self.boxy + self.size)
    line(self.boxx, self.boxy + self.size, self.boxx + self.size, self.boxy)
  end
end

function overRect(x, y, width, height)
  if mouseX >= x and mouseX <= x + width and mouseY >= y and mouseY <= y + height then
    return true
  else
    return false
  end
end

function lock(val, minv, maxv)
  return min(max(val, minv), maxv)
end
