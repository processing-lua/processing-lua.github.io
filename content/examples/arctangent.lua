--[[
  Arctangent.

  Move the mouse to change the direction of the eyes.
  The atan2() function computes the angle from each eye
  to the cursor.
]]

local e1
local e2
local e3

function setup()
  size(640, 360)
  noStroke()
  e1 = Eye.new(250, 16, 120)
  e2 = Eye.new(164, 185, 80)
  e3 = Eye.new(420, 230, 220)
end

function draw()
  background(102)

  e1:update(mouseX, mouseY)
  e2:update(mouseX, mouseY)
  e3:update(mouseX, mouseY)

  e1:display()
  e2:display()
  e3:display()
end

Eye = {}
Eye.__index = Eye

function Eye.new(tx, ty, ts)
  local self = setmetatable({}, Eye)
  self.angle = 0.0
  self.x = tx
  self.y = ty
  self.size = ts
  return self
end

function Eye:update(mx, my)
  self.angle = atan2(my - self.y, mx - self.x)
end

function Eye:display()
  pushMatrix()
  translate(self.x, self.y)
  fill(255)
  ellipse(0, 0, self.size, self.size)
  rotate(self.angle)
  fill(153, 204, 0)
  ellipse(self.size / 4, 0, self.size / 2, self.size / 2)
  popMatrix()
end
