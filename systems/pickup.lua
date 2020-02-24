local Gamestate = require 'libs.hump.gamestate'
local PickupSystem = Concord.system()

local pickUpHandlers = {
  frequency = function(self, target, pickUp)
    Gamestate.current().waveLength = Gamestate.current().waveLength + 1
  end,
  health = function(self, target, pickUp)
    self:getWorld():emit("healthGiven", target, pickUp:get(cmps.pickUp).params.amount)
  end
}

function PickupSystem:pickUpReceived(target, pickUp)
  local pickUpType = pickUp:get(cmps.pickUp).pickUpType
  print(pickUpType)
  pickUpHandlers[pickUpType](self, target, pickUp)

  pickUp:destroy()
end

return PickupSystem



