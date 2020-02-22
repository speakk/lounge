local flux = require 'libs.flux'
local Vector = require 'libs.brinevector'
local mediaManager = require 'media.manager'
local game = {}

local function initializePlayer(self)
  local entity = Concord.entity()

  local spritePath = 'characters.fella1_front'
  entity:give(cmps.sprite, spritePath)
  entity:give(cmps.position, Vector(100, 100))
  entity:give(cmps.velocity)
  entity:give(cmps.health, 100)
  local quad = mediaManager.getSpriteQuad(spritePath)
  local _, _, w, h = quad:getViewport()
  entity:give(cmps.collision, w, h, "player")
  entity:give(cmps.player)

  self.world:addEntity(entity)
end

function game:enter()
  print("game enter")
  self.world = Concord.world()

  self.world:addSystems(
    Concord.systems.input,
    Concord.systems.ai,
    Concord.systems.player,
    Concord.systems.move,
    Concord.systems.collision,
    Concord.systems.bullet,
    Concord.systems.damage,
    Concord.systems.draw
  )

  initializePlayer(self)

  for i=1,10 do
    local entity = Concord.entity()
    local spritePath = 'characters.fella1_front'
    entity:give(cmps.sprite, spritePath)
    entity:give(cmps.ai)
    entity:give(cmps.health, 100)
    entity:give(cmps.position, Vector(math.random(1000), math.random(1000)))
    entity:give(cmps.velocity, Vector(0,0))
    local quad = mediaManager.getSpriteQuad(spritePath)
    local _, _, w, h = quad:getViewport()
    entity:give(cmps.collision, w, h, 'ai')

    self.world:addEntity(entity)
  end
end

function game:update(dt)
  flux.update(dt)
  self.world:emit('resetVelocities')
  self.world:emit('update', dt)
end

function game:draw()
  self.world:emit('draw')
end

return game
