local helium = require 'libs.helium'
local input = require "libs.helium.core.input" 

local mainMenu = {}

function mainMenu:initUI()
  local button = function(param,state,view)
    --Press state
    state.pressed = false
    --The callback for the input subscription
    local callback = function()
      print("cacacal")
      state.pressed = true
    end
    --The actual input subscription 
    input('clicked', callback)

    local defaultColor = { 0.3, 0.3, 0.3 }
    local color = defaultColor

    input('hover', function ()
      print("In hover1")
      return function ()
        print("In hover")
        color = { 0.7, 0.2, 0.5 }
      end
    end)

    return function()
      if state.pressed then
        love.graphics.setColor(0.3,0.3,0.9)
      else
        love.graphics.setColor(unpack(color))
      end
      love.graphics.rectangle('fill', 0, 0, view.w, view.h)
    end
  end

  local buttonFactory = helium(button)
  local button = buttonFactory({}, 200, 100)

  return {
    {
      x = 400,
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
