local Gamestate = require 'libs.hump.gamestate'
local Timer = require 'libs.hump.timer'
local Vector = require 'libs.brinevector'

local death = require 'states.death'

local DeathSystem = Concord.system()

function DeathSystem:death(entity)
  local blood = Concord.entity():assemble(Concord.assemblages.bloodSplatter, entity:get(cmps.position).vector.copy + Vector(0, 60))
  entity:destroy()

  -- TODO: fadeout first, then destroy
  Timer.after(10, function() blood:destroy() end)

  self:getWorld():addEntity(blood)

  if entity:has(cmps.player) then
    if Gamestate.current() ~= death then
      print("ENTERING DEATH")
      Gamestate.push(death)
    end
  end
end

return DeathSystem

