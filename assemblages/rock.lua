local mediaManager = require 'media.manager'

return Concord.assemblage(function(entity, position)
  local spritePath = 'obstacles.rock'
  entity:give(cmps.position, position)
  entity:give(cmps.sprite, spritePath)
  entity:give(cmps.layer)
  local quad = mediaManager.getSpriteQuad(spritePath)
  local _, _, w, h = quad:getViewport()

  entity:give(cmps.collision, w/2, h/2, w/2, h/2, 'obstacles')
end)

