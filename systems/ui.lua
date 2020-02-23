local Gamestate = require 'libs.hump.gamestate'

local UISystem = Concord.system({cmps.player, "player"})

local healthBar
local healthBarW = 400
local healthBarH = 30

local backgroundColor = { 0.3, 0.4, 0.5 }
local filledColor = { 0.8, 0.4, 0.5 }

function drawHealthBar(self, w, h)
  local playerHealth = Gamestate.current().playerHealth
  local playerMaxHealth = Gamestate.current().playerMaxHealth

  local view = {}
  view.x = w/2 - healthBarW/2
  view.y = h - healthBarH*2

  if not playerHealth or playerHealth < 0 then return end
  love.graphics.setColor(backgroundColor)
  love.graphics.rectangle('fill', view.x, view.y, healthBarW, healthBarH, 5, 5)

  love.graphics.setColor(filledColor)
  local width = (playerHealth/playerMaxHealth) * healthBarW
  love.graphics.rectangle('fill', view.x, view.y, width, healthBarH, 5, 5)
end

function UISystem:draw()
  drawHealthBar(self, love.graphics.getDimensions())
end

-- function UISystem:damageTaken(entity, damage)
--   if entity:has(cmps.player) then
--     local newHealth = entity:get(cmps.health).health
--     Gamestate.current().playerHealth = newHealth
--   end
-- end

function UISystem:resize(w, h)
  --recalcUIPositions(w, h)
end

return UISystem
