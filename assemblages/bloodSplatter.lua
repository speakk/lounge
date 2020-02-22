return Concord.assemblage(function(entity, position)
  entity:give(cmps.position, position)
  entity:give(cmps.sprite, "decals.lounge_game_blood_splat")
end)

