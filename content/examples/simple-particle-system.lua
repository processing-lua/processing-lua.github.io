--[[
  Simple Particle System
  by Daniel Shiffman.

  Particles are generated each cycle through draw(),
  fall with gravity, and fade out over time.
  A ParticleSystem object manages a variable size (ArrayList)
  list of particles.
]]

local ps

function setup()
  size(640, 360)
  ps = ParticleSystem.new(createVector(width / 2, 50))
end

function draw()
  background(0)
  ps:addParticle()
  ps:run()
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
  self.lifespan = self.lifespan - 1.0
end

-- Method to display
function Particle:display()
  stroke(255, self.lifespan)
  fill(255, self.lifespan)
  ellipse(self.position.x, self.position.y, 8, 8)
end

-- Is the particle still useful?
function Particle:isDead()
  if self.lifespan < 0.0 then
    return true
  else
    return false
  end
end

-- A class to describe a group of Particles
-- An ArrayList is used to manage the list of Particles

ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem.new(position)
  local self = setmetatable({}, ParticleSystem)
  self.origin = position:copy()
  self.particles = {}
  return self
end

function ParticleSystem:addParticle()
  table.insert(self.particles, Particle.new(self.origin))
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
