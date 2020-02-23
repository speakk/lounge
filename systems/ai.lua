local Vector = require 'libs.brinevector'

local mediaManager = require 'media.manager'

local AISystem = Concord.system({cmps.position, cmps.velocity, cmps.ai}, {cmps.position, cmps.player, "player"})

local speed = 300

local shootChanceThreshold = 0.05
local bulletVelocity = 300

local aiHandlers = {
  melee = function(entity, target, self)
    local from = entity:get(cmps.position).vector.copy
    local angle = (target - from).normalized
    local velocityC = entity:get(cmps.velocity)
    velocityC.vector = (angle) * speed
  end,
  shooter = function(entity, target, self)
    local gunMuzzle = mediaManager.getSprite(entity:get(cmps.sprite).path).hotPoints.gunMuzzle
    local from = entity:get(cmps.position).vector.copy + Vector(gunMuzzle[1], gunMuzzle[2])
    local angle = (target - from).normalized
    local velocityC = entity:get(cmps.velocity)
    velocityC.vector = (angle) * speed

    if math.random() < shootChanceThreshold then
      if not target then return end
      local startVelocity = angle * bulletVelocity
      self:getWorld():emit("bulletShot", from, startVelocity, {"ai"})
    end
  end
}


function AISystem:update(dt)
  local player = self.player[1]
  if not player then return end
  local target = player:get(cmps.position).vector.copy

  for i=1,#self.pool do
    local entity = self.pool[i]
    local aiType = entity:get(cmps.ai).type
    print("aiType", aiType)
    aiHandlers[aiType](entity, target, self)
  end
end

return AISystem

