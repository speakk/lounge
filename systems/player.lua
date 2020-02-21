local Vector = require 'libs.brinevector'

local PlayerSystem = Concord.system({cmps.position, cmps.velocity, cmps.player})

local speed = 200

function PlayerSystem:update(dt)
  for i=1,#self.pool do
    local entity = self.pool[i]
    entity:get(cmps.velocity).vector = entity:get(cmps.velocity).vector.normalized * speed
  end
end

function PlayerSystem:moveLeft()
  for i=1,#self.pool do
    local entity = self.pool[i]
    entity:get(cmps.velocity).vector.x = -1
  end
end

function PlayerSystem:moveRight()
  for i=1,#self.pool do
    local entity = self.pool[i]
    entity:get(cmps.velocity).vector.x = 1
  end
end

function PlayerSystem:moveUp()
  for i=1,#self.pool do
    local entity = self.pool[i]
    entity:get(cmps.velocity).vector.y = -1
  end
end

function PlayerSystem:moveDown()
  for i=1,#self.pool do
    local entity = self.pool[i]
    entity:get(cmps.velocity).vector.y = 1
  end
end

function PlayerSystem:shoot()
  local bulletVelocity = 300
  for i=1,#self.pool do
    local player = self.pool[i]
    local from = player:get(cmps.position).vector.copy + Vector(20,40)
    local target = Vector(love.mouse.getX(), love.mouse.getY())
    local startVelocity = (target - from).normalized * bulletVelocity
    local bullet = Concord.entity():assemble(Concord.assemblages.bullet, from, startVelocity)
    self:getWorld():addEntity(bullet)
  end
end

return PlayerSystem

