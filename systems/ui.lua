local Gamestate = require 'libs.hump.gamestate'

local UISystem = Concord.system({cmps.player, "player"})

local levelFont = love.graphics.newFont("fonts/MavenPro-Medium.ttf", 64)

local healthBarW = 400
local healthBarH = 30

local levelBarW = 400
local levelBarH = 30

local backgroundColor = { 0.3, 0.2, 0.5 }
local filledColor = { 0.8, 0.4, 0.5 }

function drawProgressBar(x, y, w, h, color, backgroundColor, progress, maxProgress)
  love.graphics.setColor(backgroundColor)
  love.graphics.rectangle('fill', x, y, w, h, 5, 5)

  love.graphics.setColor(color)
  local width = (progress/maxProgress) * w
  love.graphics.rectangle('fill', x, y, width, h, 5, 5)
end

function drawHealthBar(self, w, h)
  local playerHealth = Gamestate.current().playerHealth
  local playerMaxHealth = Gamestate.current().playerMaxHealth

  local x = w/2 - healthBarW/2
  local y = h - healthBarH*2

  if not playerHealth or playerHealth < 0 then return end
  drawProgressBar(x, y, healthBarW, healthBarH, filledColor, backgroundColor, playerHealth, playerMaxHealth)
end

function drawLevelBar(self, w, h)
  local levelProgress = Gamestate.current().levelProgress

  local x = w/2 - healthBarW/2
  local y = 100

  if not levelProgress then return end
  drawProgressBar(x, y, healthBarW, healthBarH, { 0.2, 0.8, 0.2 }, { 0.1, 0.4, 0.2 }, levelProgress, 100)
  --print(levelProgress)
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
  drawLevelBar(self, w, h)
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
