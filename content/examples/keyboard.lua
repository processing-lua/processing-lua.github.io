--[[
  Keyboard.

  Click on the image to give it focus and press the letter keys
  to create forms in time and space. Each key has a unique identifying
  number. These numbers can be used to position shapes in space.
]]

local rectWidth = 0

function setup()
  size(640, 360)
  noStroke()
  background(0)
  rectWidth = width // 4
end

function draw()
  -- keep draw() here to continue looping while waiting for keys
end

function keyPressed()
  local keyIndex = -1
  if key >= "A" and key <= "Z" then
    keyIndex = key - "A"
  elseif key >= "a" and key <= "z" then
    keyIndex = key - "a"
  end
  if keyIndex == -1 then
    -- If it's not a letter key, clear the screen
    background(0)
  else
    -- It's a letter key, fill a rectangle
    fill(millis() % 255)
    local x = map(keyIndex, 0, 25, 0, width - rectWidth)
    rect(x, 0, rectWidth, height)
  end
end
