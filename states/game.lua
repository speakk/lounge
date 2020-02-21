local Vector = require 'libs.brinevector'
local game = {}

local function initializePlayer(self)
  local entity = Concord.entity()

  entity:give(cmps.sprite, 'characters.fella1_front')
  entity:give(cmps.position, Vector(100, 100))
  entity:give(cmps.velocity)
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
    Concord.systems.draw
  )

  initializePlayer(self)

  for i=1,10 do
    local entity = Concord.entity()
    entity:give(cmps.sprite, 'characters.fella1_front')
    entity:give(cmps.ai)
    entity:give(cmps.position, Vector(math.random(1000), math.random(1000)))
    entity:give(cmps.velocity, Vector(0,0))

    self.world:addEntity(entity)
  end
end

function game:update(dt)
  self.world:emit('resetVelocities')
  self.world:emit('update', dt)
end

function game:draw()
  self.world:emit('draw')
end

return game
