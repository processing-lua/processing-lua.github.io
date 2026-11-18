--[[
  Scrollbar.

  Move the scrollbars left and right to change the positions of the images.
]]

--True if a mouse button was pressed while no other button was.
local firstMousePress = false
local hs1
local hs2  -- Two scrollbars
local img1
local img2  -- Two images to load

function setup()
  size(640, 360)
  noStroke()

  hs1 = HScrollbar.new(0, height / 2 - 8, width, 16, 16)
  hs2 = HScrollbar.new(0, height / 2 + 8, width, 16, 16)

  -- Load images
  img1 = loadImage("seedTop.jpg")
  img2 = loadImage("seedBottom.jpg")
end

function draw()
  background(255)

  -- Get the position of the img1 scrollbar
  -- and convert to a value to display the img1 image
  local img1Pos = hs1:getPos() - width / 2
  fill(255)
  image(img1, width / 2 - img1.width / 2 + img1Pos * 1.5, 0)

  -- Get the position of the img2 scrollbar
  -- and convert to a value to display the img2 image
  local img2Pos = hs2:getPos() - width / 2
  fill(255)
  image(img2, width / 2 - img2.width / 2 + img2Pos * 1.5, height / 2)

  hs1:update()
  hs2:update()
  hs1:display()
  hs2:display()

  stroke(0)
  line(0, height / 2, width, height / 2)

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

HScrollbar = {}
HScrollbar.__index = HScrollbar

-- width and height of bar
-- x and y position of bar
-- x position of slider
-- max and min values of slider
-- how loose/heavy
-- is the mouse over the slider?
function HScrollbar.new(xp, yp, sw, sh, l)
  local self = setmetatable({}, HScrollbar)
  self.over = false
  self.locked = false
  self.swidth = sw
  self.sheight = sh
  local widthtoheight = sw - sh
  self.ratio = sw / widthtoheight
  self.xpos = xp
  self.ypos = yp - self.sheight / 2
  self.spos = self.xpos + self.swidth / 2 - self.sheight / 2
  self.newspos = self.spos
  self.sposMin = self.xpos
  self.sposMax = self.xpos + self.swidth - self.sheight
  self.loose = l
  return self
end

function HScrollbar:update()
  if self:overEvent() then
    self.over = true
  else
    self.over = false
  end
  if firstMousePress and self.over then
    self.locked = true
  end
  if not mousePressed then
    self.locked = false
  end
  if self.locked then
    self.newspos = self:constrain(mouseX - self.sheight / 2, self.sposMin, self.sposMax)
  end
  if abs(self.newspos - self.spos) > 1 then
    self.spos = self.spos + (self.newspos - self.spos) / self.loose
  end
end

function HScrollbar:constrain(val, minv, maxv)
  return min(max(val, minv), maxv)
end

function HScrollbar:overEvent()
  if mouseX > self.xpos and mouseX < self.xpos + self.swidth and mouseY > self.ypos and mouseY < self.ypos + self.sheight then
    return true
  else
    return false
  end
end

function HScrollbar:display()
  noStroke()
  fill(204)
  rect(self.xpos, self.ypos, self.swidth, self.sheight)
  if self.over or self.locked then
    fill(0, 0, 0)
  else
    fill(102, 102, 102)
  end
  rect(self.spos, self.ypos, self.sheight, self.sheight)
end

function HScrollbar:getPos()
  -- Convert spos to be values between
  -- 0 and the total width of the scrollbar
  return self.spos * self.ratio
end
