local Gamestate = require 'libs.hump.gamestate'
local flux = require 'libs.flux'
local Timer = require 'libs.hump.timer'
local Vector = require 'libs.brinevector'
local mediaManager = require 'media.manager'
local game = {}


local music

local function initializePlayer(self)
  local entity = Concord.entity():assemble(Concord.assemblages.player, Vector(math.random(1000), math.random(1000)), spritePath, 'player', nil, self.playerMaxHealth)
  self.world:addEntity(entity)
end

local function generateMap(self)
  for i = 1,10 do
    local entity = Concord.entity():assemble(Concord.assemblages.rock, Vector(math.random(2000) - 1000, math.random(2000) - 1000))
    self.world:addEntity(entity)
  end
end

function game:enter()
  print("game enter", self)
  print("World", self.world)

  self.currentLevel = 1
  self.levelProgress = 0
  self.waveLength = 8
  self.isDead = false
  self.playerMaxHealth = 100
  self.playerHealth = self.playerMaxHealth
  
  self.world = Concord.world()
  self.world:addSystems(
    Concord.systems.input,
    Concord.systems.wave,
    Concord.systems.ai,
    Concord.systems.player,
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
  print("leaving game", self.world, #self.world.__entities)
  self.world:clear()
  self.world:__flush()
  --self.world = nil
  Timer.clear()
  music:stop()
end

function game:huh()
  print("HUH")
end

function game:update(dt)
  if self.isDead then
    --Gamestate.switch(require 'states.death')
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
