local Vector = require 'libs.brinevector'

local camera = require 'models.camera'

local bloodDropImage = love.graphics.newImage('media/decals/blood_drop.png')

local ParticleSystem = Concord.system()

local bloodParticleSystems = {}
for i=1,200 do
  local bloodParticleSystem = love.graphics.newParticleSystem(love.graphics.newImage('media/decals/blood_drop.png'), 32)
  bloodParticleSystem:setParticleLifetime(0.2, 0.4) -- Particles live at least 2s and at most 5s.
	--bloodParticleSystem:setEmitterLifeTime(3)
	bloodParticleSystem:setSizeVariation(1)
	bloodParticleSystem:setSpin(0, 2, 1)
	bloodParticleSystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	bloodParticleSystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.
  table.insert(bloodParticleSystems, {
    x = 0,
    y = 0,
    system = bloodParticleSystem
  })
end

local bloodSystemIndex = 0

function ParticleSystem:update(dt)
  for i=1,#bloodParticleSystems do
    if bloodParticleSystems[i].system:isActive() then
      bloodParticleSystems[i].system:update(dt)
    end
  end
end

function ParticleSystem:bulletCollision(bullet, target)
  if target:has(cmps.health) then
    local position = bullet:get(cmps.position).vector
    bloodSystemIndex = bloodSystemIndex + 1
    if bloodSystemIndex > #bloodParticleSystems then
      bloodSystemIndex = 1
    end
    bloodParticleSystems[bloodSystemIndex].system:emit(32)
    bloodParticleSystems[bloodSystemIndex].x = position.x
    bloodParticleSystems[bloodSystemIndex].y = position.y
  end
end

function ParticleSystem:draw()
  camera:attach()
  for i=1,#bloodParticleSystems do
    local bloodParticleSystem = bloodParticleSystems[i]
    if bloodParticleSystem.system:isActive() then
      love.graphics.draw(bloodParticleSystem.system, bloodParticleSystem.x, bloodParticleSystem.y, 0, 10, 10)
    end
  end
  camera:detach()
end

return ParticleSystem
