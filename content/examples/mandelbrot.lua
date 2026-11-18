--[[
  The Mandelbrot Set
  by Daniel Shiffman.
  (slight modification by l8l)

  Simple rendering of the Mandelbrot set.
]]

function setup()
  size(640, 360)
  noLoop()
  background(255)

  -- Establish a range of values on the complex plane
  -- A different range will allow us to "zoom" in or out on the fractal

  -- It all starts with the width, try higher or lower values
  local w = 4
  local h = (w * height) / width

  -- Start at negative half the width and height
  local xmin = -w / 2
  local ymin = -h / 2

  -- Make sure we can write to the pixels[] array.
  -- Only need to do this once since we don't do any other drawing.
  loadPixels()

  -- Maximum number of iterations for each point on the complex plane
  local maxiterations = 100

  -- x goes from xmin to xmax
  local xmax = xmin + w
  -- y goes from ymin to ymax
  local ymax = ymin + h

  -- Calculate amount we increment x,y for each pixel
  local dx = (xmax - xmin) / (width)
  local dy = (ymax - ymin) / (height)

  -- Start y
  local y = ymin
  for j = 0, height - 1 do
    -- Start x
    local x = xmin
    for i = 0, width - 1 do
      -- Now we test, as we iterate z = z^2 + c does z tend towards infinity?
      local a = x
      local b = y
      local n = 0
      local max = 4.0  -- Infinity in our finite world is simple, let's just consider it 4
      local absOld = 0.0
      local convergeNumber = maxiterations  -- this will change if the while loop breaks due to non-convergence
      while n < maxiterations do
        -- We suppose z = a+ib
        local aa = a * a
        local bb = b * b
        local abs = sqrt(aa + bb)
        if abs > max then
          -- |z| = sqrt(a^2+b^2)
          -- Now measure how much we exceeded the maximum:
          local diffToLast = (abs - absOld)
          local diffToMax = (max - absOld)
          convergeNumber = n + diffToMax / diffToLast
          break  -- Bail
        end
        local twoab = 2.0 * a * b
        a = aa - bb + x  -- this operation corresponds to z -> z^2+c where z=a+ib c=(x,y)
        b = twoab + y
        n = n + 1
        absOld = abs
      end

      -- We color each pixel based on how long it takes to get to infinity
      -- If we never got there, let's pick the color black
      if n == maxiterations then
        pixels[i + j * width] = color(0)
      else
        -- Gosh, we could make fancy colors here if we wanted
        local norm = map(convergeNumber, 0, maxiterations, 0, 1)
        pixels[i + j * width] = color(map(sqrt(norm), 0, 1, 0, 255))
      end
      x = x + dx
    end
    y = y + dy
  end
  updatePixels()
end
