--[[
  Letters.

  Draws letters to the screen. This requires loading a font,
  setting the font, and then drawing the letters.
]]

local f

function setup()
  size(640, 360)
  background(0)

  -- Create the font
  printArray(PFont.list())
  f = createFont("SourceCodePro-Regular.ttf", 24)
  textFont(f)
  textAlign(CENTER, CENTER)
end

function draw()
  background(0)

  -- Set the left and top margin
  local margin = 10
  translate(margin * 4, margin * 4)

  local gap = 46
  local counter = 35

  for y = 0, height - gap - 1, gap do
    for x = 0, width - gap - 1, gap do
      local letter = char(counter)

      if letter == "A" or letter == "E" or letter == "I" or letter == "O" or letter == "U" then
        fill(255, 204, 0)
      else
        fill(255)
      end

      -- Draw the letter to the screen
      text(letter, x, y)

      -- Increment the counter
      counter = counter + 1
    end
  end
end
