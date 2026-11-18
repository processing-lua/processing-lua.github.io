--[[
  Random.

  Random numbers create the basis of this image.
  Each time the program is loaded the result is different.
]]

function setup()
  size(640, 360)
  background(0)
  strokeWeight(20)
  frameRate(2)
end

function draw()
  for i = 0, width - 1 do
    local r = random(255)
    stroke(r)
    line(i, 0, i, height)
  end
end
