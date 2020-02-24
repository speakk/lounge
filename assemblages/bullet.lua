local Timer = require 'libs.hump.timer'

return Concord.assemblage(function(entity, from, startVelocity, damage, ignoreGroups, eventInclusionGroups)
  --entity:give(cmps.color, { math.random(), math.random(), math.random() })
  entity:give(cmps.sprites, { { path = 'decals.bullet'} })
  entity:give(cmps.layer, 'glow')
  entity:give(cmps.position, from)
  entity:give(cmps.velocity, startVelocity, true)
  entity:give(cmps.bullet, damage)
  entity:give(cmps.collision, 0, 0, 5, 5, "bullet", {unpack(ignoreGroups), "bullet"}, "touch" , "bulletCollision", nil, eventInclusionGroups)

  Timer.after(6, function() entity:destroy() end)
end)
