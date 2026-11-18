--[[
  Multiple Particle Systems
  by Daniel Shiffman.

  Click the mouse to generate a burst of particles
  at mouse position.

  Each burst is one instance of a particle system
  with Particles and CrazyParticles (a subclass of Particle).
  Note use of Inheritance and Polymorphism.
]]

local systems

function setup()
  size(640, 360)
  systems = {}
end

function draw()
  background(0)
  for _, ps in ipairs(systems) do
    ps:run()
    ps:addParticle()
  end
  if #systems == 0 then
    fill(255)
    textAlign(CENTER)
    text("click mouse to add particle systems", width / 2, height / 2)
  end
end

function mousePressed()
  table.insert(systems, ParticleSystem.new(1, createVector(mouseX, mouseY)))
end

-- A subclass of Particle

CrazyParticle = setmetatable({}, { __index = Particle })
CrazyParticle.__index = CrazyParticle

-- Just adding one new variable to a CrazyParticle
-- It inherits all other fields from "Particle", and we don't have to retype them!
-- The CrazyParticle constructor can call the parent class (super class) constructor
function CrazyParticle.new(l)
  local self = setmetatable(Particle.new(l), CrazyParticle)
  -- "super" means do everything from the constructor in Particle

  -- One more line of code to deal with the new variable, theta
  self.theta = 0.0
  return self
end

-- Notice we don't have the method run() here; it is inherited from Particle
-- This update() method overrides the parent class update() method
function CrazyParticle:update()
  Particle.update(self)
  -- Increment rotation based on horizontal velocity
  local theta_vel = (self.velocity.x * self.velocity:mag()) / 10.0
  self.theta = self.theta + theta_vel
end

-- This display() method overrides the parent class display() method
function CrazyParticle:display()
  -- Render the ellipse just like in a regular particle
  Particle.display(self)
  -- Then add a rotating line
  pushMatrix()
  translate(self.position.x, self.position.y)
  rotate(self.theta)
  stroke(255, self.lifespan)
  line(0, 0, 25, 0)
  popMatrix()
end

-- A simple Particle class

Particle = {}
Particle.__index = Particle

function Particle.new(l)
  local self = setmetatable({}, Particle)
  self.acceleration = createVector(0, 0.05)
  self.velocity = createVector(random(-1, 1), random(-2, 0))
  self.position = l:copy()
  self.lifespan = 255.0
  return self
end

function Particle:run()
  self:update()
  self:display()
end

-- Method to update position
function Particle:update()
  self.velocity:add(self.acceleration)
  self.position:add(self.velocity)
  self.lifespan = self.lifespan - 2.0
end

-- Method to display
function Particle:display()
  stroke(255, self.lifespan)
  fill(255, self.lifespan)
  ellipse(self.position.x, self.position.y, 8, 8)
end

-- Is the particle still useful?
function Particle:isDead()
  return (self.lifespan < 0.0)
end

-- An ArrayList is used to manage the list of Particles

ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

-- An arraylist for all the particles
-- An origin point for where particles are birthed
function ParticleSystem.new(num, v)
  local self = setmetatable({}, ParticleSystem)
  self.particles = {}  -- Initialize the arraylist
  self.origin = v:copy()  -- Store the origin point
  for i = 1, num do
    table.insert(self.particles, Particle.new(self.origin))  -- Add "num" amount of particles to the arraylist
  end
  return self
end

function ParticleSystem:run()
  -- Cycle through the ArrayList backwards, because we are deleting while iterating
  for i = #self.particles - 1, 0, -1 do
    local p = self.particles[i + 1]
    p:run()
    if p:isDead() then
      table.remove(self.particles, i + 1)
    end
  end
end

function ParticleSystem:addParticle()
  local p
  -- Add either a Particle or CrazyParticle to the system
  if int(random(0, 2)) == 0 then
    p = Particle.new(self.origin)
  else
    p = CrazyParticle.new(self.origin)
  end
  table.insert(self.particles, p)
end

function ParticleSystem:addParticle(p)
  table.insert(self.particles, p)
end

-- A method to test if the particle system still has particles
function ParticleSystem:dead()
  return #self.particles == 0
end
