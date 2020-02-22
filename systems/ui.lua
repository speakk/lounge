local helium = require 'libs.helium'

local UISystem = Concord.system({cmps.player, "player"})

local healthBar
local healthBarW = 400
local healthBarH = 30

function recalcUIPositions(w, h)
  print("recalcUIPositions")
  healthBar.view.x = w/2 - healthBarW/2
  healthBar.view.y = h - healthBarH*2
end

function UISystem:init()
  healthBar = function(param,state,view)
    local backgroundColor = { 0.3, 0.4, 0.5 }
    local filledColor = { 0.8, 0.4, 0.5 }

    return function()
      if not state.health or state.health <= 0 then return end
      love.graphics.setColor(backgroundColor)
      love.graphics.rectangle('fill', 0, 0, view.w, view.h, 5, 5)

      love.graphics.setColor(filledColor)
      local width = view.w - param.maxHealth/state.health * view.h
      love.graphics.rectangle('fill', 0, 0, width, view.h, 5, 5)
    end
  end

  healthBar = helium(healthBar)({maxHealth=100}, healthBarW, healthBarH)
  healthBar.state.health = 100
  healthBar:draw(400, 200)

  recalcUIPositions(love.graphics.getDimensions())
end

function UISystem:damageTaken(entity, damage)
  if entity:has(cmps.player) then
    local newHealth = entity:get(cmps.health).health
    healthBar.state.health = newHealth
  end
end

function UISystem:resize(w, h)
  recalcUIPositions(w, h)
end

return UISystem
