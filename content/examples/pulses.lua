--[[
  Pulses.

  Software drawing instruments can follow a rhythm or abide by rules independent
  of drawn gestures. This is a form of collaborative drawing in which the draftsperson
  controls some aspects of the image and the software controls others.
]]

local angle = 0

function setup()
  size(640, 360)
  background(102)
  noStroke()
  fill(0, 102)
end

function draw()
  -- Draw only when mouse is pressed
  if mousePressed == true then
    angle = angle + 5
    local val = cos(radians(angle)) * 12.0
    for a = 0, 360 - 1, 75 do
      local xoff = cos(radians(a)) * val
      local yoff = sin(radians(a)) * val
      fill(0)
      ellipse(mouseX + xoff, mouseY + yoff, val, val)
    end
    fill(255)
    ellipse(mouseX, mouseY, 2, 2)
  end
end
