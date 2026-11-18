--[[
  Morph.

  Changing one shape into another by interpolating
  vertices from one to another
]]

-- Two ArrayLists to store the vertices for two shapes
-- This example assumes that each shape will have the same
-- number of vertices, i.e. the size of each ArrayList will be the same
local circle = {}
local square = {}

-- An ArrayList for a third set of vertices, the ones we will be drawing
-- in the window
local morph = {}

-- This boolean variable will control if we are morphing to a circle or square
local state = false

function setup()
  size(640, 360)

  -- Create a circle using vectors pointing from center
  for angle = 0, 360 - 1, 9 do
    -- Note we are not starting from 0 in order to match the
    -- path of a circle.
    local v = PVector.fromAngle(radians(angle - 135))
    v:mult(100)
    table.insert(circle, v)
    -- Let's fill out morph ArrayList with blank PVectors while we are at it
    table.insert(morph, createVector())
  end

  -- A square is a bunch of vertices along straight lines
  -- Top of square
  for x = -50, 50 - 1, 10 do
    table.insert(square, createVector(x, -50))
  end
  -- Right side
  for y = -50, 50 - 1, 10 do
    table.insert(square, createVector(50, y))
  end
  -- Bottom
  for x = 50, -50 + 1, -10 do
    table.insert(square, createVector(x, 50))
  end
  -- Left side
  for y = 50, -50 + 1, -10 do
    table.insert(square, createVector(-50, y))
  end
end

function draw()
  background(51)

  -- We will keep how far the vertices are from their target
  local totalDistance = 0

  -- Look at each vertex
  for i = 1, #circle do
    local v1
    -- Are we lerping to the circle or square?
    if state then
      v1 = circle[i]
    else
      v1 = square[i]
    end
    -- Get the vertex we will draw
    local v2 = morph[i]
    -- Lerp to the target
    v2:lerp(v1, 0.1)
    -- Check how far we are from target
    totalDistance = totalDistance + v1:dist(v2)
  end

  -- If all the vertices are close, switch shape
  if totalDistance < 0.1 then
    state = not state
  end

  -- Draw relative to center
  translate(width / 2, height / 2)
  strokeWeight(4)
  -- Draw a polygon that makes up all the vertices
  beginShape()
  noFill()
  stroke(255)
  for _, v in ipairs(morph) do
    vertex(v.x, v.y)
  end
  endShape(CLOSE)
end
