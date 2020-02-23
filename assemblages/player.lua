local Vector = require 'libs.brinevector'
return Concord.assemblage(function(entity, position, spritePath, collisionGroup, collisionIgnoreGroups, health)
  local spritePath = 'characters.playerFront'
  entity:assemble(Concord.assemblages.character, Vector(math.random(1000), math.random(1000)), spritePath, 'player', nil, health)
  entity:give(cmps.player)
  entity:give(cmps.characterSpriteSheet, 'characters.playerLeft','characters.playerRight','characters.playerFront','characters.playerBack') 
end)
