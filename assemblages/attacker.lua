return Concord.assemblage(function(entity, position, spritePath, collisionGroup, collisionIgnoreGroups, health)
  local spritePath = 'characters.playerFront'
  entity:assemble(Concord.assemblages.character, position, spritePath, 'ai')
  entity:give(cmps.characterSpriteSheet, 'characters.attackerLeft','characters.attackerRight','characters.attackerFront','characters.attackerBack') 
  entity:give(cmps.ai, 'shooter')
end)
