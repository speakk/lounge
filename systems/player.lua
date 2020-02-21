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

return PlayerSystem

