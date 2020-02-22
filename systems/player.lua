local Timer = require 'libs.hump.timer'
local Camera = require 'libs.hump.camera'
local Vector = require 'libs.brinevector'

local camera = require 'models.camera'

local PlayerSystem = Concord.system({cmps.position, cmps.velocity, cmps.player})

local speed = 400

local bulletDelay = 0.1
local allowedToShoot = true

function PlayerSystem:update(dt)
  for i=1,#self.pool do
    local entity = self.pool[i]
    entity:get(cmps.velocity).vector = entity:get(cmps.velocity).vector.normalized * speed
  end

  if #self.pool > 0 then
    local position = self.pool[1]:get(cmps.position).vector
    camera:lockPosition(position.x, position.y, Camera.smooth.damped(10))
  end
end

function PlayerSystem:moveLeft()
  for i=1,#self.pool do
    local entity = self.pool[i]
    entity:get(cmps.velocity).vector.x = -1
  end
end

function PlayerSystem:moveRight()
  for i=1,#self.pool do
    local entity = self.pool[i]
    entity:get(cmps.velocity).vector.x = 1
  end
end

function PlayerSystem:moveUp()
  for i=1,#self.pool do
    local entity = self.pool[i]
    entity:get(cmps.velocity).vector.y = -1
  end
end

function PlayerSystem:moveDown()
  for i=1,#self.pool do
    local entity = self.pool[i]
    entity:get(cmps.velocity).vector.y = 1
  end
end


function PlayerSystem:shoot()
  if allowedToShoot then
    local bulletVelocity = 300
    for i=1,#self.pool do
      local player = self.pool[i]
      local from = player:get(cmps.position).vector.copy + Vector(20,40)
      local target = Vector(camera:mousePosition())
      local startVelocity = (target - from).normalized * bulletVelocity
      self:getWorld():emit("bulletShot", from, startVelocity)
    end

    allowedToShoot = false
    Timer.after(bulletDelay, function() allowedToShoot = true end)
  end
end

return PlayerSystem

