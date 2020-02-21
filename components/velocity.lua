local Vector = require 'libs.brinevector'

return Concord.component(function(component, vector)
    component.vector = vector or Vector(0, 0)
end)

