local Vector = require 'libs.brinevector'

return Concord.assemblage(function(entity, position, health, collisionInfo, characterSpriteSheetInfo)
  entity:give(cmps.position, position)
  entity:give(cmps.layer)
  entity:give(cmps.sprites)
  entity:give(cmps.health, health)
  entity:give(cmps.velocity, Vector(0,0))
  entity:give(cmps.collision, unpack(collisionInfo))
  entity:give(cmps.characterSpriteSheet, unpack(characterSpriteSheetInfo))
end)
