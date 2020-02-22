local Gamestate = require 'libs.hump.gamestate'
local helium = require 'libs.helium'
local input = require "libs.helium.core.input" 

local buttonFont = love.graphics.newFont("fonts/MavenPro-Medium.ttf", 48)
local headerFont = love.graphics.newFont("fonts/MavenPro-Medium.ttf", 128)

local game = require 'states.game'

local buttonW = 200
local buttonH = 100

local death = {}

function death:enter(from)
  self.from = from

  local button = function(param,state,view)
    local defaultColor = { 0.3, 0.4, 0.5 }
    local hoverColor = { 0.4, 0.6, 0.3 }
    local textColor = { 1,1,1,1 }
    local textShadowColor = { 0,0,0,0.5 }

    state.pressed = false

    input('clicked', function()
      state.pressed = true
      Gamestate.pop()

      -- Re-enter to start over
      --Gamestate.switch({})
      Gamestate.switch(game)
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


  print(buttonW, buttonH)
  local playButton = helium(button)({content="start over"}, buttonW, buttonH)
  playButton:draw(400, 200)
  print("SETTING DRAW FOR DEATH")

  -- local buttonFactory = helium(button)
  -- local button = buttonFactory({}, 200, 100)
  -- button:draw(400, 200)

  self.playButton = playButton
end

function death:draw()
  self.from:draw()

  love.graphics.setColor(1,1,1,1)
  love.graphics.setFont(headerFont)
  local w, h = love.graphics.getDimensions()
  love.graphics.printf("You are deceased.", 0, h/2-128/2, w, 'center')
end

function death:update(dt)

end

function death:leave()
  print("LEAVING DEATH")
  self.playButton:undraw()
  self.playButton = nil
end

return death
