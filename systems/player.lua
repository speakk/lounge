local Timer = require 'libs.hump.timer'
local Camera = require 'libs.hump.camera'
local Vector = require 'libs.brinevector'

local lume = require 'libs.lume'

local mediaManager = require 'media.manager'
local camera = require 'models.camera'

local PlayerSystem = Concord.system({cmps.position, cmps.velocity, cmps.player})

local speed = 600

local zoom = 1
local zoomSpeed = 0.05
local zoomMultiplier = 0.4/speed

local bulletDelay = 0.1

function PlayerSystem:init()
  self.allowedToShoot = true
end

function PlayerSystem:update(dt)
  for i=1,#self.pool do
    local entity = self.pool[i]
    entity:get(cmps.velocity).vector = entity:get(cmps.velocity).vector.normalized * speed
  end

  if #self.pool > 0 then
    local position = self.pool[1]:get(cmps.position).vector
    local velocity = self.pool[1]:get(cmps.velocity).vector
    camera:lockPosition(position.x, position.y, Camera.smooth.damped(10))
    --print(velocity.length*zoomMultiplier)
    --camera:zoomTo(1-velocity.length*zoomMultiplier)
    zoom = lume.smooth(zoom, 1-velocity.length*zoomMultiplier, zoomSpeed)
    camera:zoomTo(zoom)
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
  if self.allowedToShoot then
    local bulletVelocity = 600
    for i=1,#self.pool do
      local player = self.pool[i]
      if not player:get(cmps.sprites).sprites then return end
      local gunMuzzle = mediaManager.getSprite(player:get(cmps.sprites).sprites[1].path).hotPoints.gunMuzzle
      local from = player:get(cmps.position).vector.copy + Vector(gunMuzzle[1], gunMuzzle[2])
      local target = Vector(camera:mousePosition())
      local startVelocity = (target - from).normalized * bulletVelocity
      self:getWorld():emit("bulletShot", from, startVelocity, {"player"}, 20)
    end

    self.allowedToShoot = false
    Timer.after(bulletDelay, function() self.allowedToShoot = true end)
  end
end

return PlayerSystem

