return Concord.assemblage(function(entity, position)
  entity:give(cmps.position, position)
  entity:give(cmps.sprites, { { path = "decals.bloodSplat" } }) 
  entity:give(cmps.layer, 'ground')
end)

