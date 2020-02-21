local Vector = require('libs.brinevector')

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

    position.vector = position.vector + velocity * dt
    self:getWorld():emit("entityMoved", entity, position.vector, velocity)
  end
end

return MoveSystem
