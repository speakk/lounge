local Gamestate = require("libs.hump.gamestate")

local windowWidth = 1000
local windowHeight = 800
love.window.setMode(windowWidth, windowHeight, { resizable=true })
love.graphics.setDefaultFilter('nearest', 'nearest')


-- GLOBALS BEGIN
Concord = require('libs.concord')
cmps = Concord.components
-- GLOBALS END

Concord.loadSystems("systems")
Concord.loadComponents("components")

local gameStates = {
  game = require("states.game"),
  mainMenu = require("states.mainMenu")
}

Gamestate.registerEvents()
Gamestate.switch(gameStates.game)
