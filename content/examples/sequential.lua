--[[
  Sequential
  by James Paterson.

  Displaying a sequence of images creates the illusion of motion.
  Twelve images are loaded and each is displayed individually in a loop.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local numFrames = 12  -- The number of frames in the animation
local currentFrame = 0
local images = newArray(numFrames, nil)

function setup()
  size(640, 360)
  frameRate(24)

  images[1] = loadImage("PT_anim0000.gif")
  images[2] = loadImage("PT_anim0001.gif")
  images[3] = loadImage("PT_anim0002.gif")
  images[4] = loadImage("PT_anim0003.gif")
  images[5] = loadImage("PT_anim0004.gif")
  images[6] = loadImage("PT_anim0005.gif")
  images[7] = loadImage("PT_anim0006.gif")
  images[8] = loadImage("PT_anim0007.gif")
  images[9] = loadImage("PT_anim0008.gif")
  images[10] = loadImage("PT_anim0009.gif")
  images[11] = loadImage("PT_anim0010.gif")
  images[12] = loadImage("PT_anim0011.gif")

  -- If you don't want to load each image separately
  -- and you know how many frames you have, you
  -- can create the filenames as the program runs.
  -- The nf() command does number formatting, which will
  -- ensure that the number is (in this case) 4 digits.
  --for (int i = 0; i < numFrames; i++) {
  --  String imageName = "PT_anim" + nf(i, 4) + ".gif";
  --  images[i] = loadImage(imageName);
  --}
end

function draw()
  background(0)
  currentFrame = (currentFrame + 1) % numFrames  -- Use % to cycle through frames
  local offset = 0
  for x = -100, width - 1, images[1].width do
    image(images[(currentFrame + offset) % numFrames + 1], x, -20)
    offset = offset + 2
    image(images[(currentFrame + offset) % numFrames + 1], x, height / 2)
    offset = offset + 2
  end
end
