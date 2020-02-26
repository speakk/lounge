local Vector = require 'libs.brinevector'

local AnimationSystem = Concord.system()

function AnimationSystem:entityMoving(entity, position, velocity, dt)
  if entity:has(cmps.characterSpriteSheet) then
    local characterSpriteSheet = entity:get(cmps.characterSpriteSheet)
    if math.abs(velocity.x) > math.abs(velocity.y) then
      if velocity.x >= 0 then
        characterSpriteSheet.current = { path = characterSpriteSheet.right }
      else
        characterSpriteSheet.current = { path = characterSpriteSheet.left }
      end
    else
      if velocity.y >= 0 then
        characterSpriteSheet.current = { path = characterSpriteSheet.front }
      else
        characterSpriteSheet.current = { path = characterSpriteSheet.back }
      end
    end
  end
end

return AnimationSystem
