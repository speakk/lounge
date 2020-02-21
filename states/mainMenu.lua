local helium = require 'libs.helium'
local input = require "libs.helium.core.input" 

local buttonFont = love.graphics.newFont("fonts/MavenPro-Medium.ttf", 48)

local mainMenu = {}

function mainMenu:initUI()
  local button = function(param,state,view)
    local defaultColor = { 0.3, 0.5, 0.3 }
    local textColor = { 1,1,1,1 }
    local textShadowColor = { 0,0,0,0.5 }

    state.pressed = false

    input('clicked', function()
      state.pressed = true
    end)

    state.color = defaultColor

    input('hover', function ()
      state.color = { 0.7, 0.2, 0.5 }
      return function ()
        state.color = defaultColor
      end
    end)

    return function()
      if state.pressed then
        love.graphics.setColor(0.3,0.3,0.9)
      else
        love.graphics.setColor(state.color)
      end
      love.graphics.rectangle('fill', 0, 0, view.w, view.h, 5, 5)

      love.graphics.setFont(buttonFont)
      love.graphics.setColor(textShadowColor)
      love.graphics.printf(param.content,5,17,view.w, 'center')
      love.graphics.setColor(textColor)
      love.graphics.printf(param.content,0,12,view.w, 'center')
    end
  end

  helium(button)({content="play"}, 200, 100):draw(400, 200)

  -- local buttonFactory = helium(button)
  -- local button = buttonFactory({}, 200, 100)
  -- button:draw(400, 200)

  -- return {
  --   {
  --     x = 400,
  --     y = 100,
  --     element = button
  --   }
  -- }
end

function mainMenu:init()
  self.initUI()
end
-- 
-- function mainMenu:draw()
--   for i = 1,#self.ui do
--     local uiElement = self.ui[i]
--     uiElement.element:draw(uiElement.x, uiElement.y)
--   end
-- end

return mainMenu
