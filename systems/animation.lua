local Vector = require 'libs.brinevector'
local camera = require 'models.camera'

local AnimationSystem = Concord.system({cmps.player, 'player'})

function AnimationSystem:entityMoving(entity, position, velocity, dt)
  if entity:has(cmps.characterSpriteSheet) and entity:has(cmps.ai) then
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

function AnimationSystem:mousemoved(x, y, dx, dy)
  local entity = self.player[1]
  if not entity then return end
  local location = entity:get(cmps.position).vector
  local mouseLocation = Vector(camera:worldCoords(x, y))
  local direction = mouseLocation - location

  local characterSpriteSheet = entity:get(cmps.characterSpriteSheet)
  if math.abs(direction.x) > math.abs(direction.y) then
    if direction.x >= 0 then
      characterSpriteSheet.current = { path = characterSpriteSheet.right }
    else
      characterSpriteSheet.current = { path = characterSpriteSheet.left }
    end
  else
    if direction.y >= 0 then
      characterSpriteSheet.current = { path = characterSpriteSheet.front }
    else
      characterSpriteSheet.current = { path = characterSpriteSheet.back }
    end
  end
end

return AnimationSystem
