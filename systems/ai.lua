local Vector = require 'libs.brinevector'

local AISystem = Concord.system({cmps.position, cmps.velocity, cmps.ai}, {cmps.position, cmps.player, "player"})

local speed = 200

local shootChanceThreshold = 0.05
local bulletVelocity = 300

function AISystem:update(dt)
  for i=1,#self.pool do
    local entity = self.pool[i]
    entity:get(cmps.velocity).vector.x = math.random(speed)-speed/2
    entity:get(cmps.velocity).vector.y = math.random(speed)-speed/2

    if math.random() < shootChanceThreshold then
      local player = self.player[1]
      if not player then return end
      local from = entity:get(cmps.position).vector.copy + Vector(20,40)
      local target = player:get(cmps.position).vector.copy
      local startVelocity = (target - from).normalized * bulletVelocity
      self:getWorld():emit("bulletShot", from, startVelocity, {"ai"})
    end
  end
end

return AISystem

