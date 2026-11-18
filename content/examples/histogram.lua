--[[
  Histogram.

  Calculates the histogram of an image.
  A histogram is the frequency distribution
  of the gray levels with the number of pure black values
  displayed on the left and number of pure white values on the right.

  Note that this sketch will behave differently on Android,
  since most images will no longer be full 24-bit color.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

function setup()
  size(640, 360)

  -- Load an image from the data directory
  -- Load a different image by modifying the comments
  local img = loadImage("frontier.jpg")
  image(img, 0, 0)
  local hist = newArray(256, 0)

  -- Calculate the histogram
  for i = 0, img.width - 1 do
    for j = 0, img.height - 1 do
      local bright = int(brightness(get(i, j)))
      hist[bright + 1] = hist[bright + 1] + 1
    end
  end

  -- Find the largest value in the histogram
  local histMax = math.max(table.unpack(hist))

  stroke(255)
  -- Draw half of the histogram (skip every second value)
  for i = 0, img.width - 1, 2 do
    -- Map i (from 0..img.width) to a location in the histogram (0..255)
    local which = int(map(i, 0, img.width, 0, 255))
    -- Convert the histogram value to a location between
    -- the bottom and the top of the picture
    local y = int(map(hist[which + 1], 0, histMax, img.height, 0))
    line(i, img.height, i, y)
  end
end
