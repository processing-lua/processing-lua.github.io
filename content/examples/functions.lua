--[[
  Functions.

  The drawTarget() function makes it easy to draw many distinct targets.
  Each call to drawTarget() specifies the position, size, and number of
  rings for each target.
]]

function setup()
  size(640, 360)
  background(51)
  noStroke()
  noLoop()
end

function draw()
  drawTarget(width * 0.25, height * 0.4, 200, 4)
  drawTarget(width * 0.5, height * 0.5, 300, 10)
  drawTarget(width * 0.75, height * 0.3, 120, 6)
end

function drawTarget(xloc, yloc, size, num)
  local grayvalues = 255 / num
  local steps = size / num
  for i = 0, num - 1 do
    fill(i * grayvalues)
    ellipse(xloc, yloc, size - i * steps, size - i * steps)
  end
end
