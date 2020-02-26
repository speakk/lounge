local Gamestate = require 'libs.hump.gamestate'
local flux = require 'libs.flux'
local Timer = require 'libs.hump.timer'
local Vector = require 'libs.brinevector'
local mediaManager = require 'media.manager'
local game = {}


local music

local function initializePlayer(self)
  local entity = Concord.entity():assemble(Concord.assemblages.player, Vector(self.worldSizeX/2, self.worldSizeY/2), spritePath, 'player', nil, self.playerMaxHealth)
  self.world:addEntity(entity)
end

local function generateMap(self)
  for i = 1,10 do
    local entity = Concord.entity():assemble(Concord.assemblages.rock, Vector(math.random(self.worldSizeX), math.random(self.worldSizeY)))
    self.world:addEntity(entity)
  end
end

function initializeGameState(state)
  state.currentLevel = 1
  state.levelProgress = 0
  state.waveLength = 8
  state.isDead = false
  state.playerMaxHealth = 100
  state.playerHealth = state.playerMaxHealth

  state.worldSizeX = 3000
  state.worldSizeY = 3000
end

function game:enter()
  initializeGameState(self)
  
  self.world = Concord.world()
  self.world:addSystems(
    Concord.systems.input,
    Concord.systems.wave,
    Concord.systems.ai,
    Concord.systems.player,
    Concord.systems.worldBounds,
    Concord.systems.move,
    Concord.systems.collision,
    Concord.systems.bullet,
    Concord.systems.melee,
    Concord.systems.damage,
    Concord.systems.pickup,
    Concord.systems.death,
    Concord.systems.sound,
    Concord.systems.animation,
    Concord.systems.draw,
    Concord.systems.particle,
    Concord.systems.ui
  )

  initializePlayer(self)
  generateMap(self)


  music = love.audio.newSource('media/music/ingame.mp3', 'stream')
  music:setVolume(0.7)
  music:setLooping(true)
  music:play()
end

function game:leave()
  self.world:clear()
  self.world:__flush()
  --self.world = nil
  Timer.clear()
  music:stop()
end

function game:update(dt)
  if self.isDead then
    music:pause()
    Gamestate.push(require 'states.death')
  else
    flux.update(dt)
    Timer.update(dt)
    self.world:emit('resetVelocities')
    self.world:emit('update', dt)
  end
end

function game:draw()
  --love.graphics.clear(0,0,0,1)
  self.world:emit('draw')
end

function game:resize(w, h)
  self.world:emit('resize', w, h)
end

return game
