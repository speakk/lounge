local flux = require 'libs.flux'

local DamageSystem = Concord.system()

local damageColor = {1,0,0,1}

function DamageSystem:damageTaken(entity, damage)
  if entity:has(cmps.health) then
    local healthC = entity:get(cmps.health)
    healthC.health = healthC.health - damage
  end

  if entity:has(cmps.color) and entity:get(cmps.color).tween then
    entity:get(cmps.color).tween:stop()
  end

  entity:ensure(cmps.color, damageColor)
  -- Copy to make sure we don't change original damageColor
  entity:get(cmps.color).color = {unpack(damageColor)}

  local tween = flux.to(entity:get(cmps.color).color, 4, {[1] = 1, [2] = 1, [3] = 1, [4] = 1})
  entity:get(cmps.color).tween = tween
end

return DamageSystem
