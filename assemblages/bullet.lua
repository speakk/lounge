return Concord.assemblage(function(entity, from, startVelocity)
  entity:give(cmps.circle, 4)
  entity:give(cmps.position, from)
  entity:give(cmps.velocity, startVelocity, true)
end)