local Timer = require 'libs.hump.timer'

return Concord.assemblage(function(entity, from, startVelocity, damage, ignoreGroups)
  --entity:give(cmps.color, { math.random(), math.random(), math.random() })
  entity:give(cmps.sprite, 'decals.bullet')
  entity:give(cmps.layer, 'glow')
  entity:give(cmps.position, from)
  entity:give(cmps.velocity, startVelocity, true)
  entity:give(cmps.bullet, damage)
  entity:give(cmps.collision, 5, 5, "bullet", ignoreGroups)

  Timer.after(6, function() entity:destroy() end)
end)
