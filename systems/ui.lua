local helium = require 'libs.helium'

local UISystem = Concord.system({cmps.player, "player"})

local healthBar
local healthBarW = 400
local healthBarH = 30


local function recalcUIPositions(w, h)
  print("recalcUIPositions")
  healthBar.view.x = w/2 - healthBarW/2
  healthBar.view.y = h - healthBarH*2
end

local backgroundColor = { 0.3, 0.4, 0.5 }
local filledColor = { 0.8, 0.4, 0.5 }

function drawHealthBar(self, w, h)
  local view = {}
  view.x = w/2 - healthBarW/2
  view.y = h - healthBarH*2

  if not self.localState.health or self.localState.health < 0 then return end
  love.graphics.setColor(backgroundColor)
  love.graphics.rectangle('fill', view.x, view.y, healthBarW, healthBarH, 5, 5)

  love.graphics.setColor(filledColor)
  local width = (self.localState.health/self.localState.maxHealth) * healthBarW
  love.graphics.rectangle('fill', view.x, view.y, width, healthBarH, 5, 5)
end

function UISystem:draw()
  drawHealthBar(self, love.graphics.getDimensions())
end

function UISystem:init()
  self.localState = { health = 100, maxHealth = 100}
  -- healthBar = function(param,state,view)

  --   return function()
  --     drawHealthBar()
  --   end
  -- end

  -- healthBar = helium(healthBar)({maxHealth=100}, healthBarW, healthBarH)
  -- healthBar.state.health = 100
  -- healthBar:draw(400, 200)

  -- recalcUIPositions(love.graphics.getDimensions())
end

function UISystem:damageTaken(entity, damage)
  if entity:has(cmps.player) then
    local newHealth = entity:get(cmps.health).health
    self.localState.health = newHealth
  end
end

function UISystem:resize(w, h)
  --recalcUIPositions(w, h)
end

return UISystem
