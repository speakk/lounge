local Gamestate = require 'libs.hump.gamestate'
local helium = require 'libs.helium'
local input = require "libs.helium.core.input" 

local buttonFontSize = 48
local headerFontSize = 128
local buttonFont = love.graphics.newFont("fonts/MavenPro-Medium.ttf", buttonFontSize)
local headerFont = love.graphics.newFont("fonts/MavenPro-Medium.ttf", headerFontSize)
local subHeaderFont = love.graphics.newFont("fonts/MavenPro-Medium.ttf", 64)

local game = require 'states.game'

local playButton
local buttonW = 320
local buttonH = 150

local death = {}

local function recalcUIPositions(w, h)
  print("recalcUIPositions")
  playButton.view.x = w/2 - buttonW/2
  playButton.view.y = 500
end

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
      print("Leave??")
      self.from:clear()
      Gamestate.pop()
      print("After pop!")

      -- Re-enter to start over
      Gamestate.switch({})
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
      local hPos = view.h/2 - buttonFontSize/1.3
      love.graphics.printf(param.content,0,hPos,view.w, 'center')
      love.graphics.setColor(textColor)
      love.graphics.printf(param.content,3,hPos+3,view.w, 'center')
    end
  end


  print(buttonW, buttonH)
  playButton = helium(button)({content="Do it again"}, buttonW, buttonH)
  playButton:draw(400, 200)
  print("SETTING DRAW FOR DEATH")

  recalcUIPositions(love.graphics.getDimensions())
  -- local buttonFactory = helium(button)
  -- local button = buttonFactory({}, 200, 100)
  -- button:draw(400, 200)

end

function death:draw()
  self.from:draw()

  love.graphics.setColor(1,1,1,1)
  love.graphics.setFont(headerFont)
  local w, h = love.graphics.getDimensions()
  love.graphics.printf("You are deceased", 0, 80, w, 'center')
  love.graphics.setFont(subHeaderFont)
  love.graphics.setColor(0.8,1,0.6,1)
  love.graphics.printf("You made it to level " .. self.from.currentLevel, 0, 400, w, 'center')
end

function death:update(dt)

end

function death:resize(w, h)
  recalcUIPositions(w, h)
end

function death:leave()
  print("LEAVING DEATH")
  playButton:undraw()
  playButton = nil
end

return death
