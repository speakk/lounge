local helium = require 'libs.helium'

local UISystem = Concord.system({cmps.player, "player"})

local healthBar

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

  local barW = 200
  local barH = 30
  healthBar = helium(healthBar)({maxHealth=100}, barW, barH)
  healthBar.state.health = 100
  healthBar:draw(400, 200)
end

function UISystem:damageTaken(entity, damage)
  if entity:has(cmps.player) then
    local newHealth = entity:get(cmps.health).health
    healthBar.state.health = newHealth
  end
end

return UISystem
