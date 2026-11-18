--[[
  Smoke Particle System
  by Daniel Shiffman.

  A basic smoke effect using a particle system. Each particle
  is rendered as an alpha masked image.
]]

local ps

function setup()
  size(640, 360)
  local img = loadImage("texture.png")
  ps = ParticleSystem.new(0, createVector(width / 2, height - 60), img)
end

function draw()
  background(0)

  -- Calculate a "wind" force based on mouse horizontal position
  local dx = map(mouseX, 0, width, -0.2, 0.2)
  local wind = createVector(dx, 0)
  ps:applyForce(wind)
  ps:run()
  for i = 1, 2 do
    ps:addParticle()
  end

  -- Draw an arrow representing the wind force
  drawVector(wind, createVector(width / 2, 50, 0), 500)
end

-- Renders a vector object 'v' as an arrow and a position 'loc'
function drawVector(v, loc, scayl)
  pushMatrix()
  local arrowsize = 4
  -- Translate to position to render vector
  translate(loc.x, loc.y)
  stroke(255)
  -- Call vector heading function to get direction (note that pointing up is a heading of 0) and rotate
  rotate(v:heading())
  -- Calculate length of vector & scale it to be bigger or smaller if necessary
  local len = v:mag() * scayl
  -- Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
  line(0, 0, len, 0)
  line(len, 0, len - arrowsize, arrowsize / 2)
  line(len, 0, len - arrowsize, -arrowsize / 2)
  popMatrix()
end

-- A simple Particle class, renders the particle as an image

Particle = {}
Particle.__index = Particle

function Particle.new(l, img_)
  local self = setmetatable({}, Particle)
  self.acc = createVector(0, 0)
  local vx = randomGaussian() * 0.3
  local vy = randomGaussian() * 0.3 - 1.0
  self.vel = createVector(vx, vy)
  self.loc = l:copy()
  self.lifespan = 100.0
  self.img = img_
  return self
end

function Particle:run()
  self:update()
  self:render()
end

-- Method to apply a force vector to the Particle object
-- Note we are ignoring "mass" here
function Particle:applyForce(f)
  self.acc:add(f)
end

-- Method to update position
function Particle:update()
  self.vel:add(self.acc)
  self.loc:add(self.vel)
  self.lifespan = self.lifespan - 2.5
  self.acc:mult(0)  -- clear Acceleration
end

-- Method to display
function Particle:render()
  imageMode(CENTER)
  tint(255, self.lifespan)
  image(self.img, self.loc.x, self.loc.y)
  -- Drawing a circle instead
  -- fill(255,lifespan);
  -- noStroke();
  -- ellipse(loc.x,loc.y,img.width,img.height);
end

-- Is the particle still useful?
function Particle:isDead()
  if self.lifespan <= 0.0 then
    return true
  else
    return false
  end
end

-- A class to describe a group of Particles
-- An ArrayList is used to manage the list of Particles

ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

-- An arraylist for all the particles
-- An origin point for where particles are birthed
function ParticleSystem.new(num, v, img_)
  local self = setmetatable({}, ParticleSystem)
  self.particles = {}  -- Initialize the arraylist
  self.origin = v:copy()  -- Store the origin point
  self.img = img_
  for i = 1, num do
    table.insert(self.particles, Particle.new(self.origin, self.img))  -- Add "num" amount of particles to the arraylist
  end
  return self
end

function ParticleSystem:run()
  for i = #self.particles - 1, 0, -1 do
    local p = self.particles[i + 1]
    p:run()
    if p:isDead() then
      table.remove(self.particles, i + 1)
    end
  end
end

-- Method to add a force vector to all particles currently in the system
function ParticleSystem:applyForce(dir)
  -- Enhanced loop!!!
  for _, p in ipairs(self.particles) do
    p:applyForce(dir)
  end
end

function ParticleSystem:addParticle()
  table.insert(self.particles, Particle.new(self.origin, self.img))
end
