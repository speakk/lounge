local Vector = require 'libs.brinevector'

local MeleeSystem = Concord.system()

function MeleeSystem:meleeAttack(attacker, target)
  self:getWorld():emit("damageTaken", target, 2)
end

return MeleeSystem

