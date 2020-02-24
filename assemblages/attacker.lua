local mediaManager = require 'media.manager'

return Concord.assemblage(function(entity, position, spritePath, collisionGroup, collisionIgnoreGroups, health)
  local spritePath = 'characters.attackerFront'
  local quad = mediaManager.getSpriteQuad(spritePath)
  local _, _, w, h = quad:getViewport()
  entity:assemble(Concord.assemblages.character, position, health, {
    0, 0, w, h, "ai" },
    { 'characters.attackerLeft','characters.attackerRight','characters.attackerFront','characters.attackerBack' }) 
  entity:give(cmps.ai, 'shooter')
  entity:give(cmps.dropOnDeath, {
    {
      type = "frequencyDrop",
      chance = 0.1,
    }
  })
end)
