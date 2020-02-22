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

function BulletSystem:bulletShot(from, startVelocity)
  -- TODO: 10 is bullet damage. Get it from player gun
  local bullet = Concord.entity():assemble(Concord.assemblages.bullet, from, startVelocity, 10, {"player", "bullet"})
  self:getWorld():addEntity(bullet)
end

return BulletSystem
