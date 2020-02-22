local flux = require 'libs.flux'
local Timer = require 'libs.hump.timer'
local Vector = require 'libs.brinevector'
local mediaManager = require 'media.manager'
local game = {}

local music

local function initializePlayer(self)
  local spritePath = 'characters.playerFront'
  local entity = Concord.entity():assemble(Concord.assemblages.character, Vector(math.random(1000), math.random(1000)), spritePath, 'player')
  entity:give(cmps.player)
  self.world:addEntity(entity)
end

function game:enter()
  print("game enter")
  self.world = Concord.world()

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
    Concord.systems.ui,
    Concord.systems.animation,
    Concord.systems.draw
  )


  music = love.audio.newSource('media/music/ingame.mp3', 'stream')
  music:setVolume(0.2)
  music:play()
end

function game:update(dt)
  flux.update(dt)
  Timer.update(dt)
  self.world:emit('resetVelocities')
  self.world:emit('update', dt)
end

function game:draw()
  self.world:emit('draw')
end

function game:resize(w, h)
  self.world:emit('resize', w, h)
end


function game:leave()
  music:stop()
end

return game
