local helium = require 'libs.helium'
local input = require "libs.helium.core.input" 

local headerFont = love.graphics.newFont("fonts/MavenPro-Medium.ttf", 128)
local buttonFont = love.graphics.newFont("fonts/MavenPro-Medium.ttf", 48)

local buttonW = 200
local buttonH = 100

local mainMenu = {}

function mainMenu:initUI()
  local button = function(param,state,view)
    local defaultColor = { 0.3, 0.4, 0.5 }
    local hoverColor = { 0.4, 0.6, 0.3 }
    local textColor = { 1,1,1,1 }
    local textShadowColor = { 0,0,0,0.5 }

    state.pressed = false

    input('clicked', function()
      state.pressed = true
    end)

    state.color = defaultColor

    input('hover', function ()
      state.color = hoverColor
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

  local playButton = helium(button)({content="play"}, buttonW, buttonH)
  playButton:draw(400, 200)

  -- local buttonFactory = helium(button)
  -- local button = buttonFactory({}, 200, 100)
  -- button:draw(400, 200)

  return {
    playButton
  }
end

local function recalcMenuPositions(ui, w, h)
  local offsetY = 0
  for i = 1,#ui do
    local uiElement = ui[i]
    uiElement.view.x = w/2 - buttonW/2
    uiElement.view.y = h/2 - (#ui*buttonH)/2 + offsetY

    offsetY = offsetY + buttonH
  end
end


function mainMenu:init()
  self.ui = self.initUI()
  recalcMenuPositions(self.ui, love.graphics.getDimensions())
end

function mainMenu:resize(w, h)
  recalcMenuPositions(self.ui, w, h)
end

function mainMenu:draw()
  love.graphics.clear(0.08,0.02,0.1,1)
  love.graphics.setFont(headerFont)
  local w, h = love.graphics.getDimensions()
  love.graphics.setColor(0.5,0.1,0.3,1)
  love.graphics.printf("Lounge", 10, 100, w, 'center')
  love.graphics.setColor(0.2,0.5,0.1,1)
  love.graphics.printf("Lounge", 5, 100, w, 'center')
  love.graphics.setColor(1,1,1,1)
  love.graphics.printf("Lounge", 0, 100, w, 'center')
end
  
-- 
--
-- function mainMenu:draw()
--   for i = 1,#self.ui do
--     local uiElement = self.ui[i]
--     uiElement.element:draw(uiElement.x, uiElement.y)
--   end
-- end

return mainMenu
