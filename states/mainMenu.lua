local helium = require 'libs.helium'
local input = require "libs.helium.core.input" 

local mainMenu = {}

function mainMenu:initUI()
  local button = function(param,state,view)
    --Press state
    state.pressed = false
    --The callback for the input subscription
    local callback = function() state.pressed = true end
    --The actual input subscription 
    input('clicked', callback)

    return function()
      if state.pressed then
        love.graphics.setColor(0.3,0.3,0.9)
      else
        love.graphics.setColor(0.3,0.3,0.5)
      end
      love.graphics.rectangle('fill', 0, 0, view.w, view.h)
    end
  end

  local buttonFactory = helium(button)
  local button = buttonFactory({}, 200, 100)

  return {
    {
      x = 100,
      y = 100,
      element = button
    }
  }
end

function mainMenu:init()
  self.ui = self.initUI()
end

function mainMenu:draw()
  for i = 1,#self.ui do
    local uiElement = self.ui[i]
    uiElement.element:draw(uiElement.x, uiElement.y)
  end
end

return mainMenu

--local buttonFactory = helium(button)
--local button = buttonFactory({}, 200, 100)
--button:draw(10,10)
