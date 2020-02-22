local Timer = require 'libs.hump.timer'
local SoundSystem = Concord.system()

function SoundSystem:bulletShot()
  local sound = love.audio.newSource("media/sounds/shot1.wav", "static")
  sound:play()
end

function SoundSystem:bulletCollision()
  local sound = love.audio.newSource("media/sounds/shotHit1.wav", "static")
  sound:play()
end

function SoundSystem:death()
  local sound = love.audio.newSource("media/sounds/death1.wav", "static")
  sound:play()
end

return SoundSystem


