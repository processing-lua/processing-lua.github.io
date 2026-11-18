--[[
  Tickle.

  The word "tickle" jitters when the cursor hovers over.
  Sometimes, it can be tickled off the screen.
]]

local message = "tickle"
local x, y = 0, 0  -- X and Y coordinates of text
local hr, vr = 0, 0  -- horizontal and vertical radius of the text

function setup()
  size(640, 360)

  -- Create the font
  textFont(createFont("SourceCodePro-Regular.ttf", 36))
  textAlign(CENTER, CENTER)

  hr = textWidth(message) / 2
  vr = (textAscent() + textDescent()) / 2
  noStroke()
  x = width / 2
  y = height / 2
end

function draw()
  -- Instead of clearing the background, fade it by drawing
  -- a semi-transparent rectangle on top
  fill(204, 120)
  rect(0, 0, width, height)

  -- If the cursor is over the text, change the position
  if abs(mouseX - x) < hr and abs(mouseY - y) < vr then
    x = x + random(-5, 5)
    y = y + random(-5, 5)
  end
  fill(0)
  text("tickle", x, y)
end
