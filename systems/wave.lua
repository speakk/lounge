local Timer = require 'libs.hump.timer'
local Vector = require 'libs.brinevector'

local Gamestate = require 'libs.hump.gamestate'

local WaveSystem = Concord.system({cmps.player, 'player'})

local waveLength = 10

function WaveSystem:generateWave()
  print("generateWave")

  local playerPosition
  if self.player[1] then
    playerPosition = self.player[1]:get(cmps.position).vector
  else
    playerPosition = Vector(0,0)
  end

  for i=1,Gamestate.current().currentLevel do
    local spritePath = 'characters.playerFront'
    local plusOrMinus = 1
    local minDistance = 100
    if math.random() > 0.5 then plusOrMinus = -1 end
    local position = playerPosition + (Vector(math.random(300),math.random(300)) + Vector(minDistance, minDistance)) * plusOrMinus
    local entity = Concord.entity():assemble(Concord.assemblages.character, position, spritePath, 'ai')
    entity:give(cmps.ai)
    self:getWorld():addEntity(entity)
  end

end

function WaveSystem:init()
  self:generateWave()

  local currentState = Gamestate.current()

  Timer.tween(currentState.waveLength, currentState, { levelProgress = 100 })
  Timer.after(currentState.waveLength, function(func)
    self:generateWave()
    currentState.levelProgress = 0
    currentState.waveLength = currentState.waveLength - 1
    if currentState.waveLength < 1 then currentState.waveLength = 1 end
    currentState.currentLevel = currentState.currentLevel + 1
    Timer.after(currentState.waveLength, func)
    Timer.tween(currentState.waveLength, currentState, { levelProgress = 100 })
  end)
end


return WaveSystem


