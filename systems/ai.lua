local Vector = require 'libs.brinevector'

local AISystem = Concord.system({cmps.position, cmps.velocity, cmps.ai}, {cmps.position, cmps.player, "player"})

local speed = 300

local shootChanceThreshold = 0.05
local bulletVelocity = 300

function AISystem:update(dt)
  local player = self.player[1]
  local target = player:get(cmps.position).vector.copy

  for i=1,#self.pool do
    local entity = self.pool[i]
    local from = entity:get(cmps.position).vector.copy
    local angle = (target - from).normalized
    local velocityC = entity:get(cmps.velocity)
    velocityC.vector = (angle) * speed

    if math.random() < shootChanceThreshold then
      if not player then return end
      local startVelocity = angle * bulletVelocity
      self:getWorld():emit("bulletShot", from, startVelocity, {"ai"})
    end
  end
end

return AISystem

