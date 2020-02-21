local Vector = require 'libs.brinevector'
local game = {}

function game:init()
  self.world = Concord.world()

  for i=1,10 do
    local entity = Concord.entity()
    entity:give(cmps.sprite, 'characters.fella1_front')
    entity:give(cmps.position, Vector(math.random(200), math.random(200)))

    self.world:addEntity(entity)
  end
end

function game:update(dt)

end

function game:draw()

end

return game
