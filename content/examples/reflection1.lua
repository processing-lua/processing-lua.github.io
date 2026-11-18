--[[
  Non-orthogonal Reflection
  by Ira Greenberg.

  Based on the equation (R = 2N(N*L)-L) where R is the
  reflection vector, N is the normal, and L is the incident
  vector.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

-- Position of left hand side of floor
local base1
-- Position of right hand side of floor
local base2
-- Length of floor
local baseLength = 0

-- An array of subpoints along the floor path
local coords

-- Variables related to moving ball
local position
local velocity
local r = 6
local speed = 3.5

function setup()
  size(640, 360)

  fill(128)
  base1 = createVector(0, height - 150)
  base2 = createVector(width, height)
  createGround()

  -- start ellipse at middle top of screen
  position = createVector(width / 2, 0)

  -- calculate initial random velocity
  velocity = PVector.random2D()
  velocity:mult(speed)
end

function draw()
  -- draw background
  fill(0, 12)
  noStroke()
  rect(0, 0, width, height)

  -- draw base
  fill(200)
  quad(base1.x, base1.y, base2.x, base2.y, base2.x, height, 0, height)

  -- calculate base top normal
  local baseDelta = (base2 - base1)
  baseDelta:normalize()
  local normal = createVector(-baseDelta.y, baseDelta.x)

  -- draw ellipse
  noStroke()
  fill(255)
  ellipse(position.x, position.y, r * 2, r * 2)

  -- move elipse
  position:add(velocity)

  -- normalized incidence vector
  local incidence = (velocity * -1)
  incidence:normalize()

  -- detect and handle collision
  for i = 1, #coords do
    -- check distance between ellipse and base top coordinates
    if position:dist(coords[i]) < r then
      -- calculate dot product of incident vector and base top normal
      local dot = incidence:dot(normal)

      -- calculate reflection vector
      -- assign reflection vector to direction vector
      velocity:set(2 * normal.x * dot - incidence.x, 2 * normal.y * dot - incidence.y, 0)
      velocity:mult(speed)

      -- draw base top normal at collision point
      stroke(255, 128, 0)
      line(position.x, position.y, position.x - normal.x * 100, position.y - normal.y * 100)
    end
  end

  -- detect boundary collision
  -- right
  if position.x > width - r then
    position.x = width - r
    velocity.x = velocity.x * -1
  end
  -- left
  if position.x < r then
    position.x = r
    velocity.x = velocity.x * -1
  end
  -- top
  if position.y < r then
    position.y = r
    velocity.y = velocity.y * -1
    -- randomize base top
    base1.y = random(height - 100, height)
    base2.y = random(height - 100, height)
    createGround()
  end
end

-- Calculate variables for the ground
function createGround()
  -- calculate length of base top
  baseLength = base1:dist(base2)

  -- fill base top coordinate array
  coords = newArray(ceil(baseLength), nil)
  for i = 0, #coords - 1 do
    coords[i + 1] = createVector()
    coords[i + 1].x = base1.x + ((base2.x - base1.x) / baseLength) * i
    coords[i + 1].y = base1.y + ((base2.y - base1.y) / baseLength) * i
  end
end
