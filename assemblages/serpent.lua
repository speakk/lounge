return Concord.assemblage(function(entity, position, spritePath, collisionGroup, collisionIgnoreGroups, health)
  local spritePath = 'characters.playerFront'
  entity:assemble(Concord.assemblages.character, position, spritePath, 'ai')
  entity:give(cmps.characterSpriteSheet, 'characters.serpentLeft','characters.serpentRight','characters.serpentFront','characters.serpentBack') 
  entity:give(cmps.ai, 'melee')
  entity:give(cmps.dropOnDeath, {
    {
      type = "frequencyDrop",
      chance = 0.3,
    },
    {
      type = "healthDrop",
      chance = 0.3,
    }
  })
end)
