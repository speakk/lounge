local Timer = require 'libs.hump.timer'
local Vector = require 'libs.brinevector'

local WaveSystem = Concord.system()

function WaveSystem:init()
  Timer.after(1, function(func) print("foo") Timer.after(1, func) end)
end

function WaveSystem:update(dt)
end

return WaveSystem


