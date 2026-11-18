--[[
  Embedding Iteration.

  Embedding "for" structures allows repetition in two dimensions.
]]

function setup()
  size(640, 360)
  background(0)

  local gridSize = 40

  for x = gridSize, width - gridSize, gridSize do
    for y = gridSize, height - gridSize, gridSize do
      noStroke()
      fill(255)
      rect(x - 1, y - 1, 3, 3)
      stroke(255, 100)
      line(x, y, width / 2, height / 2)
    end
  end
end
