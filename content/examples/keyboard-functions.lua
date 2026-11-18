--[[
  Keyboard Functions
  by Martin Gomez

  Click on the window to give it focus and press the letter keys to type colors.
  The keyboard function keyPressed() is called whenever
  a key is pressed. keyReleased() is another keyboard
  function that is called when a key is released.

  Original 'Color Typewriter' concept by John Maeda.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

local maxHeight = 40
local minHeight = 20
local letterHeight = maxHeight  -- Height of the letters
local letterWidth = 20  -- Width of the letter

local x = -letterWidth  -- X position of the letters
local y = 0  -- Y position of the letters

local newletter = false

local numChars = 26  -- There are 26 characters in the alphabet
local colors = newArray(numChars, 0)

function setup()
  size(640, 360)
  noStroke()
  colorMode(HSB, numChars)
  background(numChars / 2)
  -- Set a hue value for each key
  for i = 0, numChars - 1 do
    colors[i + 1] = color(i, numChars, numChars)
  end
end

function draw()
  if newletter == true then
    -- Draw the "letter"
    local y_pos
    if letterHeight == maxHeight then
      y_pos = y
      rect(x, y_pos, letterWidth, letterHeight)
    else
      y_pos = y + minHeight
      rect(x, y_pos, letterWidth, letterHeight)
      fill(numChars / 2)
      rect(x, y_pos - minHeight, letterWidth, letterHeight)
    end
    newletter = false
  end
end

function keyPressed()
  -- If the key is between 'A'(65) to 'Z' and 'a' to 'z'(122)
  if (key >= "A" and key <= "Z") or (key >= "a" and key <= "z") then
    local keyIndex
    if key <= "Z" then
      keyIndex = key - "A"
      letterHeight = maxHeight
      fill(colors[keyIndex + 1])
    else
      keyIndex = key - "a"
      letterHeight = minHeight
      fill(colors[keyIndex + 1])
    end
  else
    fill(0)
    letterHeight = 10
  end

  newletter = true

  -- Update the "letter" position
  x = (x + letterWidth)

  -- Wrap horizontally
  if x > width - letterWidth then
    x = 0
    y = y + maxHeight
  end

  -- Wrap vertically
  if y > height - letterHeight then
    y = 0  -- reset y to 0
  end
end
