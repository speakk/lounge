local Gamestate = require 'libs.hump.gamestate'

local windowWidth = 1000
local windowHeight = 800
love.window.setMode(windowWidth, windowHeight, { resizable=true })
love.graphics.setDefaultFilter('nearest', 'nearest')

math.randomseed(os.time())


-- GLOBALS BEGIN
Concord = require('libs.concord')
cmps = Concord.components
-- GLOBALS END

Concord.loadComponents("components")
Concord.loadSystems("systems")
Concord.loadAssemblages("assemblages")

local gameStates = {
  game = require("states.game"),
  death = require("states.death"),
  mainMenu = require("states.mainMenu")
}

function love.load()
  Gamestate.registerEvents()
  --Gamestate.switch({
  --  draw = function() end,
  --  currentLevel = 3
  --})
  Gamestate.switch(gameStates.mainMenu)
end
