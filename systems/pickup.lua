local Gamestate = require 'libs.hump.gamestate'
local PickupSystem = Concord.system()

local pickUpHandlers = {
  frequency = function(self, pickUp, target)
    self:getWorld():emit("waveLengthChange", Gamestate.current().waveLength + 1)
  end,
  health = function(self, pickUp, target)
    self:getWorld():emit("healthGiven", target, pickUp:get(cmps.pickUp).params.amount)
  end
}

function PickupSystem:pickUpReceived(pickUp, target)
  local pickUpType = pickUp:get(cmps.pickUp).pickUpType
  pickUpHandlers[pickUpType](self, pickUp, target)

  pickUp:destroy()
end

return PickupSystem



