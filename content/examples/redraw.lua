--[[
  Redraw.

  The redraw() function makes draw() execute once.
  In this example, draw() is executed once every time
  the mouse is clicked.
]]

local y = 0

-- The statements in the setup() function
-- execute once when the program begins
function setup()
  size(640, 360)  -- Size should be the first statement
  stroke(255)  -- Set line drawing color to white
  noLoop()
  y = height * 0.5
end

-- The code in draw() is run until the program
-- is stopped. Each statement is executed in
-- sequence and after the last line is read,
-- the first line is run again.
function draw()
  background(0)  -- Set the background to black
  y = y - 4
  if y < 0 then
    y = height
  end
  line(0, y, width, y)
end

function mousePressed()
  redraw()
end
