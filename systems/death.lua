local Timer = require 'libs.hump.timer'
local Vector = require 'libs.brinevector'

local DeathSystem = Concord.system()

function DeathSystem:death(entity)
  local blood = Concord.entity():assemble(Concord.assemblages.bloodSplatter, entity:get(cmps.position).vector.copy + Vector(0, 60))
  entity:destroy()

  -- TODO: fadeout first, then destroy
  Timer.after(10, function() blood:destroy() end)

  self:getWorld():addEntity(blood)
end

return DeathSystem

