--[[
  Convolution
  by Daniel Shiffman.

  Applies a convolution matrix to a portion of an image. Move mouse to
  apply filter to different parts of the image. Click mouse to cycle
  through different effects (kernels).
]]

local img
local effect = 0
local w = 120

-- It's possible to convolve the image with many different
-- matrices to produce different effects.  Here are some
-- example kernels to try.
local identity = {{0, 0, 0}, {0, 1, 0}, {0, 0, 0}}

local darken = {{0, 0, 0}, {0, 0.5, 0}, {0, 0, 0}}

local lighten = {{0, 0, 0}, {0, 2, 0}, {0, 0, 0}}

local sharpen = {{0, -1, 0}, {-1, 5, -1}, {0, -1, 0}}

local sharpen2 = {{-1, -1, -1}, {-1, 9, -1}, {-1, -1, -1}}

local box_blur = {{1.0 / 9.0, 1.0 / 9.0, 1.0 / 9.0}, {1.0 / 9.0, 1.0 / 9.0, 1.0 / 9.0}, {1.0 / 9.0, 1.0 / 9.0, 1.0 / 9.0}}

local edge_det = {{0, 1, 0}, {1, -4, 1}, {0, 1, 0}}

local emboss = {{-2, -1, 0}, {-1, 1, 1}, {0, 1, 2}}

-- collect the kernels and names into arrays for our program
local kernels = {identity, darken, lighten, sharpen, sharpen2, box_blur, edge_det, emboss}

local effect_names = {"Identity (no change)", "Darken", "Lighten", "Sharpen", "Sharpen More", "Box Blur", "Edge Detect", "Emboss"}

--
function setup()
  size(640, 360)
  img = loadImage("moon-wide.jpg")

  noLoop()
end

-- Clicking the mouse advances to the next effect
function mousePressed()
  effect = effect + 1
  if effect >= #effect_names then
    effect = 0
  end

  redraw()
end

-- Moving the mouse triggers a screen redraw
function mouseMoved()
  redraw()
end
function mouseDragged()
  redraw()
end

function draw()
  -- We're only going to process a portion of the image
  -- so let's set the whole image as the background first
  image(img, 0, 0)

  -- Calculate the small rectangle we will process
  local xstart = constrain(mouseX - w / 2, 0, img.width)
  local ystart = constrain(mouseY - w / 2, 0, img.height)
  local xend = constrain(mouseX + w / 2, 0, img.width)
  local yend = constrain(mouseY + w / 2, 0, img.height)
  local matrixsize = 3
  loadPixels()
  -- Begin our loop for every pixel in the smaller image
  for x = xstart, xend - 1 do
    for y = ystart, yend - 1 do
      local c = convolution(x, y, kernels[effect + 1], matrixsize, img)
      local loc = x + y * img.width
      pixels[loc] = c
    end
  end
  updatePixels()

  textSize(24)
  text(effect_names[effect + 1], 4, 24)
end

function convolution(x, y, matrix, matrixsize, img)
  local rtotal = 0.0
  local gtotal = 0.0
  local btotal = 0.0
  local offset = matrixsize // 2
  for i = 0, matrixsize - 1 do
    for j = 0, matrixsize - 1 do
      -- What pixel are we testing
      local xloc = x + i - offset
      local yloc = y + j - offset
      local loc = xloc + img.width * yloc
      -- Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc, 0, #img.pixels - 1)
      -- Calculate the convolution
      rtotal = rtotal + (red(img.pixels[loc]) * matrix[i + 1][j + 1])
      gtotal = gtotal + (green(img.pixels[loc]) * matrix[i + 1][j + 1])
      btotal = btotal + (blue(img.pixels[loc]) * matrix[i + 1][j + 1])
    end
  end
  -- Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255)
  gtotal = constrain(gtotal, 0, 255)
  btotal = constrain(btotal, 0, 255)
  -- Return the resulting color
  return color(rtotal, gtotal, btotal)
end
