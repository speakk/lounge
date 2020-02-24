local PickupSystem = Concord.system()

local pickUpHandlers = {
  frequency = function(target, pickUp)

  end
}

function PickupSystem:pickUpReceived(target, pickUp)
  local type = pickUp.type
  pickUpHandlers[type](target, pickUp)
end

return PickupSystem



