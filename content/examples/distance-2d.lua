--[[
  Distance 2D.

  Move the mouse across the image to obscure and reveal the matrix.
  Measures the distance from the mouse to each square and sets the
  size proportionally.
]]

local max_distance = 0

function setup()
  size(640, 360)
  noStroke()
  max_distance = dist(0, 0, width, height)
end

function draw()
  background(0)

  for i = 0, width, 20 do
    for j = 0, height, 20 do
      local size = dist(mouseX, mouseY, i, j)
      size = size / max_distance * 66
      ellipse(i, j, size, size)
    end
  end
end
