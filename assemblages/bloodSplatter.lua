return Concord.assemblage(function(entity, position)
  entity:give(cmps.position, position)
  entity:give(cmps.sprite, "decals.bloodSplat")
end)

