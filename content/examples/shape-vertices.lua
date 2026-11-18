--[[
  Shape Vertices.

  How to iterate over the vertices of a shape.
  When loading an obj or SVG, getVertexCount()
  will typically return 0 since all the vertices
  are in the child shapes.

  You should iterate through the children and then
  iterate through their vertices.
]]

-- The shape
local uk

function setup()
  size(640, 360)
  -- Load the shape
  uk = loadShape("uk.svg")
end

function draw()
  background(51)
  -- Center where we will draw all the vertices
  translate(width / 2 - uk.width / 2, height / 2 - uk.height / 2)

  -- Iterate over the children
  local children = uk:getChildCount()
  for i = 0, children - 1 do
    local child = uk:getChild(i)
    local total = child:getVertexCount()

    -- Now we can actually get the vertices from each child
    for j = 0, total - 1 do
      local v = child:getVertex(j)
      -- Cycling brightness for each vertex
      stroke((frameCount + (i + 1) * j) % 255)
      -- Just a dot for each one
      point(v.x, v.y)
    end
  end
end
