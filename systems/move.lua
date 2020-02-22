local Vector = require 'libs.brinevector'
local bump = require 'libs.bump'

local MoveSystem = Concord.system({cmps.position, cmps.velocity})

function MoveSystem:resetVelocities()
  for _, entity in ipairs(self.pool) do
    local velC = entity:get(cmps.velocity)
    if not velC.keepVelocity then
      entity:get(cmps.velocity).vector = Vector(0, 0)
    end
  end
end

function MoveSystem:update(dt)
  for i=1,#self.pool do
    local entity = self.pool[i]
    local position = entity:get(cmps.position)
    local velocity = entity:get(cmps.velocity).vector.copy

    if not entity:has(cmps.collision) then
      position.vector = position.vector + velocity * dt
    end

    self:getWorld():emit("entityMoving", entity, position.vector, velocity, dt)
  end
end

return MoveSystem
