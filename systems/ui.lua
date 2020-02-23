local Gamestate = require 'libs.hump.gamestate'

local UISystem = Concord.system({cmps.player, "player"})

local levelFont = love.graphics.newFont("fonts/MavenPro-Medium.ttf", 64)

local healthBar
local healthBarW = 400
local healthBarH = 30

local backgroundColor = { 0.3, 0.2, 0.5 }
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

function drawCurrentLevel(self, w, h)
  local currentLevel = Gamestate.current().currentLevel
  if currentLevel then
    love.graphics.setColor(0.5,1,0.5,1)
    love.graphics.setFont(levelFont)
    love.graphics.printf("Wave: " .. currentLevel, 0, 10, w, 'center')
  end
end

function UISystem:draw()
  local w, h = love.graphics.getDimensions()
  drawHealthBar(self, w, h)
  drawCurrentLevel(self, w, h)
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
