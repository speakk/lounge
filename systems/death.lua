local Gamestate = require 'libs.hump.gamestate'
local Timer = require 'libs.hump.timer'
local Vector = require 'libs.brinevector'

local death = require 'states.death'

local DeathSystem = Concord.system()

function DeathSystem:death(entity)
  local position = entity:get(cmps.position).vector.copy

  if entity:has(cmps.dropOnDeath) then
    local drops = entity:get(cmps.dropOnDeath).drops

    for i=1,#drops do
      local drop = drops[i]
      if math.random() < drop.chance then
        local type = drop.type
        local dropEntity = Concord.entity():assemble(Concord.assemblages[type], position + Vector(math.random(20), math.random(20)) - Vector(10, 10), unpack(drop.params or {}))
        self:getWorld():addEntity(dropEntity)
      end
    end
  end

  local blood = Concord.entity():assemble(Concord.assemblages.bloodSplatter, position + Vector(0, 60))
  entity:destroy()

  -- TODO: fadeout first, then destroy
  Timer.after(10, function() blood:destroy() end)

  self:getWorld():addEntity(blood)

  if entity:has(cmps.player) then
    if Gamestate.current() ~= death then
      Gamestate.current().isDead = true
    end
  end
end

return DeathSystem

