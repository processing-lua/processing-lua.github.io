--[[
  Mouse Press.

  Move the mouse to position the shape.
  Press the mouse button to invert the color.
]]

function setup()
  size(640, 360)
  noSmooth()
  fill(126)
  background(102)
end

function draw()
  if mousePressed then
    stroke(255)
  else
    stroke(0)
  end
  line(mouseX - 66, mouseY, mouseX + 66, mouseY)
  line(mouseX, mouseY - 66, mouseX, mouseY + 66)
end
