local Vector = require 'libs.brinevector'
local game = {}

function game:enter()
  print("game enter")
  self.world = Concord.world()

  self.world:addSystems(
    Concord.systems.ai,
    Concord.systems.move,
    Concord.systems.draw
  )

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
