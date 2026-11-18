--[[
  Milliseconds.

  A millisecond is 1/1000 of a second.
  Processing keeps track of the number of milliseconds a program has run.
  By modifying this number with the modulo(%) operator,
  different patterns in time are created.
]]

local scale = 0

function setup()
  size(640, 360)
  noStroke()
  scale = width / 20
end

function draw()
  for i = 0, scale - 1 do
    colorMode(RGB, (i + 1) * scale * 10)
    fill(millis() % ((i + 1) * scale * 10))
    rect(i * scale, 0, scale, height)
  end
end
