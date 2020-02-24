local Vector = require 'libs.brinevector'

local BulletSystem = Concord.system()

function BulletSystem:bulletCollision(bullet, target)
  self:getWorld():emit("damageTaken", target, bullet:get(cmps.bullet).damage)
  bullet:destroy()
end

function BulletSystem:bulletShot(from, startVelocity, ignoreGroups, damage, eventInclusionGroups)
  table.insert(ignoreGroups, "bullet")
  local bullet = Concord.entity():assemble(Concord.assemblages.bullet, from, startVelocity, damage, ignoreGroups, eventInclusionGroups)
  self:getWorld():addEntity(bullet)
end

return BulletSystem
