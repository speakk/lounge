local Gamestate = require 'libs.hump.gamestate'
local flux = require 'libs.flux'
local Timer = require 'libs.hump.timer'
local Vector = require 'libs.brinevector'
local mediaManager = require 'media.manager'
local game = {}


local music

local function initializePlayer(self)
  local spritePath = 'characters.playerFront'
  local entity = Concord.entity():assemble(Concord.assemblages.character, Vector(math.random(1000), math.random(1000)), spritePath, 'player', nil, self.playerMaxHealth)
  entity:give(cmps.player)
  self.world:addEntity(entity)
end

function game:enter()
  print("game enter", self)
  self.world = Concord.world()
  print("World", self.world)
  
  self.currentLevel = 1
  self.isDead = false
  self.playerMaxHealth = 100
  self.playerHealth = self.playerMaxHealth

  initializePlayer(self)

  self.world:addSystems(
    Concord.systems.input,
    Concord.systems.wave,
    Concord.systems.ai,
    Concord.systems.player,
    Concord.systems.move,
    Concord.systems.collision,
    Concord.systems.bullet,
    Concord.systems.damage,
    Concord.systems.death,
    Concord.systems.sound,
    Concord.systems.animation,
    Concord.systems.draw,
    Concord.systems.ui
  )


  music = love.audio.newSource('media/music/ingame.mp3', 'stream')
  music:setVolume(0.7)
  music:setLooping(true)
  music:play()
end

function game:leave()
  print("leaving game", self.world)
  self.world:clear()
  --self.world = nil
  Timer.clear()
  music:stop()
end

function game:huh()
  print("HUH")
end

function game:update(dt)
  if self.isDead then
    Gamestate.switch(require 'states.death')
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
