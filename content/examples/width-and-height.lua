--[[
  Width and Height.

  The 'width' and 'height' variables contain the width and height
  of the display window as defined in the size() function.
]]

function setup()
  size(640, 360)
end

function draw()
  background(127)
  noStroke()
  for i = 0, height - 1, 20 do
    fill(129, 206, 15)
    rect(0, i, width, 10)
    fill(255)
    rect(i, 0, 10, height)
  end
end
