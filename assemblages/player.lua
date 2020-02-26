local mediaManager = require 'media.manager'
local Vector = require 'libs.brinevector'

return Concord.assemblage(function(entity, position, spritePath, collisionGroup, collisionIgnoreGroups, health)
  local spritePath = 'characters.playerFront'
  local quad = mediaManager.getSpriteQuad(spritePath)
  local _, _, w, h = quad:getViewport()
  entity:assemble(Concord.assemblages.character, Vector(math.random(1000), math.random(1000)), health, {
    0, 0, w, h,
    'player'
  }, {
    'characters.playerLeft','characters.playerRight','characters.playerFront','characters.playerBack'
  })
  entity:give(cmps.player)
  entity:give(cmps.sprites, { { path = 'decals.shadow', x = 20, y = 80 } })
end)
