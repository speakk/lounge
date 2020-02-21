local Vector = require 'libs.brinevector'

local AISystem = Concord.system({cmps.position, cmps.velocity, cmps.ai})

local speed = 200

function AISystem:update(dt)
  for i=1,#self.pool do
    local entity = self.pool[i]
    entity:get(cmps.velocity).vector.x = math.random(speed)-speed/2
    entity:get(cmps.velocity).vector.y = math.random(speed)-speed/2
  end
end

return AISystem

