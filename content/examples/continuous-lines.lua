--[[
  Continuous Lines.

  Click and drag the mouse to draw a line.
]]

function setup()
  size(640, 360)
  background(102)
end

function draw()
  stroke(255)
  if mousePressed == true then
    line(mouseX, mouseY, pmouseX, pmouseY)
  end
end
