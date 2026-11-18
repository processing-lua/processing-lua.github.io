--[[
  Request Image
  by Ira Greenberg

  Shows how to use the requestImage() function with preloader animation.
  The requestImage() function loads images on a separate thread so that
  the sketch does not freeze while they load. It's useful when you are
  loading large images. These images are small for a quick download, but
  try it with your own huge images to get the full effect.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local imgCount = 12
local imgs = newArray(imgCount, nil)
local imgW = 0

-- Keeps track of loaded images (true or false)
local loadStates = newArray(imgCount, false)

-- For loading animation
local loaderX, loaderY, theta = 0, 0, 0

function setup()
  size(640, 360)
  imgW = width / imgCount

  -- Load images asynchronously
  for i = 0, imgCount - 1 do
    imgs[i + 1] = requestImage("PT_anim" .. nf(i, 4) .. ".gif")
  end
end

function draw()
  background(0)

  -- Start loading animation
  runLoaderAni()

  for i = 1, #imgs do
    -- Check if individual images are fully loaded
    if (imgs[i].width ~= 0) and (imgs[i].width ~= -1) then
      -- As images are loaded set true in boolean array
      loadStates[i] = true
    end
  end
  -- When all images are loaded draw them to the screen
  if checkLoadStates() then
    drawImages()
  end
end

function drawImages()
  local y = (height - imgs[1].height) // 2
  for i = 0, #imgs - 1 do
    image(imgs[i + 1], width / #imgs * i, y, imgs[i + 1].height, imgs[i + 1].height)
  end
end

-- Loading animation
function runLoaderAni()
  -- Only run when images are loading
  if not checkLoadStates() then
    ellipse(loaderX, loaderY, 10, 10)
    loaderX = loaderX + 2
    loaderY = height / 2 + sin(theta) * (height / 8)
    theta = theta + (PI / 22)
    -- Reposition ellipse if it goes off the screen
    if loaderX > width + 5 then
      loaderX = -5
    end
  end
end

-- Return true when all images are loaded - no false values left in array
function checkLoadStates()
  for i = 1, #imgs do
    if loadStates[i] == false then
      return false
    end
  end
  return true
end
