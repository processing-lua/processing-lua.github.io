--[[
  Graphing 2D Equations
  by Daniel Shiffman.

  Graphics the following equation:
  sin(n*cos(r) + 5*theta)
  where n is a function of horizontal mouse location.
]]

function setup()
  size(640, 360)
end

function draw()
  loadPixels()
  local n = (mouseX * 10.0) / width
  local w = 16.0  -- 2D space width
  local h = 16.0  -- 2D space height
  local dx = w / width  -- Increment x this amount per pixel
  local dy = h / height  -- Increment y this amount per pixel
  local x = -w / 2  -- Start x at -1 * width / 2
  for i = 0, width - 1 do
    local y = -h / 2  -- Start y at -1 * height / 2
    for j = 0, height - 1 do
      local r = sqrt((x * x) + (y * y))  -- Convert cartesian to polar
      local theta = atan2(y, x)  -- Convert cartesian to polar
      -- Compute 2D polar coordinate function
      local val = sin(n * cos(r) + 5 * theta)  -- Results in a value between -1 and 1
      --float val = cos(r);                            // Another simple function
      --float val = sin(theta);                        // Another simple function
      -- Map resulting vale to grayscale value
      pixels[i + j * width] = color((val + 1.0) * 255.0 / 2.0)  -- Scale to between 0 and 255
      y = y + dy  -- Increment y
    end
    x = x + dx  -- Increment x
  end
  updatePixels()
end
