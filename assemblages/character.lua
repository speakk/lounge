local Vector = require 'libs.brinevector'
local mediaManager = require 'media.manager'

return Concord.assemblage(function(entity, position, spritePath, collisionGroup, collisionIgnoreGroups, health)
  entity:give(cmps.position, position)
  entity:give(cmps.sprite, spritePath)
  entity:give(cmps.health, health)
  entity:give(cmps.velocity, Vector(0,0))
  local quad = mediaManager.getSpriteQuad(spritePath)
  local _, _, w, h = quad:getViewport()

  entity:give(cmps.characterSpriteSheet, 'characters.playerLeft','characters.playerRight','characters.playerFront','characters.playerBack') 

  entity:give(cmps.collision, w, h, collisionGroup, collisionIgnoreGroups)
end)
