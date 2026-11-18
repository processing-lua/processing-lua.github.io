--[[
  Animated Sprite (Shifty + Teddy)
  by James Paterson.

  Press the mouse button to change animations.
  Demonstrates loading, displaying, and animating GIF images.
  It would be easy to write a program to display
  animated GIFs, but would not allow as much control over
  the display sequence and rate of display.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local animation1
local animation2

local xpos = 0
local ypos = 0
local drag = 30.0

function setup()
  size(640, 360)
  background(255, 204, 0)
  frameRate(24)
  animation1 = Animation.new("PT_Shifty_", 38)
  animation2 = Animation.new("PT_Teddy_", 60)
  ypos = height * 0.25
end

function draw()
  local dx = mouseX - xpos
  xpos = xpos + dx / drag

  -- Display the sprite at the position xpos, ypos
  if mousePressed then
    background(153, 153, 0)
    animation1:display(xpos - animation1:getWidth() / 2, ypos)
  else
    background(255, 204, 0)
    animation2:display(xpos - animation1:getWidth() / 2, ypos)
  end
end

-- Class for animating a sequence of GIFs

Animation = {}
Animation.__index = Animation

function Animation.new(imagePrefix, count)
  local self = setmetatable({}, Animation)
  self.frame = 0
  self.imageCount = count
  self.images = newArray(self.imageCount, nil)

  for i = 0, self.imageCount - 1 do
    -- Use nf() to number format 'i' into four digits
    local filename = imagePrefix .. nf(i, 4) .. ".gif"
    self.images[i + 1] = loadImage(filename)
  end
  return self
end

function Animation:display(xpos, ypos)
  self.frame = (self.frame + 1) % self.imageCount
  image(self.images[self.frame + 1], xpos, ypos)
end

function Animation:getWidth()
  return self.images[1].width
end
