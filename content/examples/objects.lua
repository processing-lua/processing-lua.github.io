--[[
  Objects
  by hbarragan.

  Move the cursor across the image to change the speed and positions
  of the geometry. The class MRect defines a group of lines.
]]

local r1
local r2
local r3
local r4

function setup()
  size(640, 360)
  fill(255, 204)
  noStroke()
  r1 = MRect.new(1, 134.0, 0.532, 0.1 * height, 10.0, 60.0)
  r2 = MRect.new(2, 44.0, 0.166, 0.3 * height, 5.0, 50.0)
  r3 = MRect.new(2, 58.0, 0.332, 0.4 * height, 10.0, 35.0)
  r4 = MRect.new(1, 120.0, 0.0498, 0.9 * height, 15.0, 60.0)
end

function draw()
  background(0)

  r1:display()
  r2:display()
  r3:display()
  r4:display()

  r1:move(mouseX - (width / 2), mouseY + (height * 0.1), 30)
  r2:move((mouseX + (width * 0.05)) % width, mouseY + (height * 0.025), 20)
  r3:move(mouseX / 4, mouseY - (height * 0.025), 40)
  r4:move(mouseX - (width / 2), (height - mouseY), 50)
end

MRect = {}
MRect.__index = MRect

-- single bar width
-- rect xposition
-- rect height
-- rect yposition
-- single bar distance
-- number of bars
function MRect.new(iw, ixp, ih, iyp, id, it)
  local self = setmetatable({}, MRect)
  self.w = iw
  self.xpos = ixp
  self.h = ih
  self.ypos = iyp
  self.d = id
  self.t = it
  return self
end

function MRect:move(posX, posY, damping)
  local dif = self.ypos - posY
  if abs(dif) > 1 then
    self.ypos = self.ypos - (dif / damping)
  end
  dif = self.xpos - posX
  if abs(dif) > 1 then
    self.xpos = self.xpos - (dif / damping)
  end
end

function MRect:display()
  for i = 0, self.t - 1 do
    rect(self.xpos + (i * (self.d + self.w)), self.ypos, self.w, height * self.h)
  end
end
