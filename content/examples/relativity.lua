--[[
  Relativity.

  Each color is perceived in relation to other colors. The top and bottom
  bars each contain the same component colors, but a different display order
  causes individual colors to appear differently.
]]

local a, b, c, d, e = 0, 0, 0, 0, 0

function setup()
  size(640, 360)
  noStroke()
  a = color(165, 167, 20)
  b = color(77, 86, 59)
  c = color(42, 106, 105)
  d = color(165, 89, 20)
  e = color(146, 150, 127)
  noLoop()  -- Draw only one time
end

function draw()
  drawBand(a, b, c, d, e, 0, width / 128)
  drawBand(c, a, d, b, e, height / 2, width / 128)
end

function drawBand(v, w, x, y, z, ypos, barWidth)
  local num = 5
  local colorOrder = {v, w, x, y, z}
  for i = 0, width - 1, barWidth * num do
    for j = 0, num - 1 do
      fill(colorOrder[j + 1])
      rect(i + j * barWidth, ypos, barWidth, height / 2)
    end
  end
end
