--[[
  Iteration.

  Iteration with a "for" structure to construct repetitive forms.
]]

function setup()
  local y
  local num = 14

  size(640, 360)
  background(102)
  noStroke()

  -- White bars
  fill(255)
  y = 60
  for i = 1, num // 3 do
    rect(50, y, 475, 10)
    y = y + 20
  end

  -- Gray bars
  fill(51)
  y = 40
  for i = 1, num do
    rect(405, y, 30, 10)
    y = y + 20
  end
  y = 50
  for i = 1, num do
    rect(425, y, 30, 10)
    y = y + 20
  end

  -- Thin lines
  y = 45
  fill(0)
  for i = 1, num - 1 do
    rect(120, y, 40, 1)
    y = y + 20
  end
end
