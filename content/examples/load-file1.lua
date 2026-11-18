--[[
  LoadFile 1

  Loads a text file that contains two numbers separated by a tab ('\t').
  A new pair of numbers is loaded each frame and used to draw a point on the screen.
]]

local lines
local index = 0

function setup()
  size(640, 360)
  background(0)
  stroke(255)
  frameRate(12)
  lines = loadStrings("positions.txt")
end

function draw()
  if index < #lines then
    local pieces = split(lines[index + 1], "\t")
    if #pieces == 2 then
      -- Scale the coordinates to match the size of the sketch window
      local x = map(float(pieces[1]), 0, 100, 0, width)
      local y = map(float(pieces[2]), 0, 100, 0, height)
      point(x, y)
    end
    -- Go to the next line for the next run through draw()
    index = index + 1
  end
end
