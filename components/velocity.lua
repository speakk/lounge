local Vector = require 'libs.brinevector'

return Concord.component(function(component, vector, keepVelocity)
    component.vector = vector or Vector(0, 0)
    component.keepVelocity = keepVelocity or false
end)

