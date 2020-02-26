local Vector = require 'libs.brinevector'
local Gamestate = require 'libs.hump.gamestate'

local WorldBoundsSystem = Concord.system()

-- TODO: Get these from gameState

function WorldBoundsSystem:init()
  local state = Gamestate.current()
  self.worldSizeX = state.worldSizeX
  self.worldSizeY = state.worldSizeY
end

function WorldBoundsSystem:entityMoving(entity, position, velocity, dt)
  local wentOutOfBounds = false
  if position.x < 0 then
    position.x = 0
    wentOutOfBounds = true
  end
  if position.x > self.worldSizeX then
    position.x = self.worldSizeX
    wentOutOfBounds = true
  end
  if position.y < 0 then
    position.y = 0
    wentOutOfBounds = true
  end
  if position.y > self.worldSizeY then
    position.y = self.worldSizeY
    wentOutOfBounds = true
  end

  if wentOutOfBounds then
    -- TODO: Could do this with something like cmps.outOfBoundsEventType
    if entity:has(cmps.bullet) then
      entity:destroy()
    end
  end
end

return WorldBoundsSystem

