local Vector = require 'libs.brinevector'

local BulletSystem = Concord.system()

function BulletSystem:bulletCollision(first, second)
  local bullet
  local other

  if first:has(cmps.bullet) then
    bullet = first
    other = second
  else
    bullet = second
    other = first
  end

  self:getWorld():emit("damageTaken", other, bullet:get(cmps.bullet).damage)
  bullet:destroy()
end

return BulletSystem
