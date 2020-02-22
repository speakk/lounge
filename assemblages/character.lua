local Vector = require 'libs.brinevector'
local mediaManager = require 'media.manager'

return Concord.assemblage(function(entity, position, spritePath, collisionGroup, collisionIgnoreGroups)
  entity:give(cmps.position, position)
  entity:give(cmps.sprite, spritePath)
  entity:give(cmps.health, 100)
  entity:give(cmps.velocity, Vector(0,0))
  local quad = mediaManager.getSpriteQuad(spritePath)
  local _, _, w, h = quad:getViewport()
  entity:give(cmps.collision, w, h, collisionGroup, collisionIgnoreGroups)
end)
