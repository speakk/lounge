local mediaManager = require 'media.manager'

return Concord.assemblage(function(entity, position, spritePath, collisionGroup, collisionIgnoreGroups, health)
  local spritePath = 'characters.serpentLeft'
  local quad = mediaManager.getSpriteQuad(spritePath)
  local _, _, w, h = quad:getViewport()
  entity:assemble(Concord.assemblages.character, position, health, {
    0, 0, w, h, 'ai'
  }, { 'characters.serpentLeft','characters.serpentRight','characters.serpentFront','characters.serpentBack' }
  )
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

  entity:get(cmps.collision).event = "meleeAttack"
  entity:get(cmps.collision).eventIgnoreGroups = { "ai" }
end)
