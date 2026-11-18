--[[
  Loading URLs.

  Click on the button to open a URL in a browser.
]]

local overButton = false

function setup()
  size(640, 360)
end

function draw()
  background(204)

  if overButton == true then
    fill(255)
  else
    noFill()
  end
  rect(105, 60, 75, 75)
  line(135, 105, 155, 85)
  line(140, 85, 155, 85)
  line(155, 85, 155, 100)
end

function mousePressed()
  if overButton then
    link("http://www.processing.org")
  end
end

function mouseMoved()
  checkButtons()
end

function mouseDragged()
  checkButtons()
end

function checkButtons()
  if mouseX > 105 and mouseX < 180 and mouseY > 60 and mouseY < 135 then
    overButton = true
  else
    overButton = false
  end
end
