local Vector = require 'libs.brinevector'
local bump = require 'libs.bump'

local CollisionSystem = Concord.system({cmps.collision, cmps.position})

local bumpWorld = bump.newWorld(cellSize)

function CollisionSystem:init()
  self.pool.onEntityAdded = function(pool, entity)
    local position = entity:get(cmps.position).vector
    local collisionC = entity:get(cmps.collision)
    bumpWorld:add(entity, position.x,position.y,collisionC.w,collisionC.h)
  end

  self.pool.onEntityRemoved = function(pool, entity)
    bumpWorld:remove(entity)
  end
end

function CollisionSystem:entityMoving(entity, position, velocity, dt)
  --local actualX, actualY, cols, len = world:move(item, goalX, goalY, <filter>)
  local goal = position + velocity * dt
  local actualX, actualY, cols, len = bumpWorld:move(entity, goal.x, goal.y, function(item, other)
    local groupOne = item:get(cmps.collision).group
    local groupSecond = other:get(cmps.collision).group
    local ignoreGroupsOne = item:get(cmps.collision).ignoreGroups
    local ignoreGroupsSecond = other:get(cmps.collision).ignoreGroups

    local ignorePairs = {ignoreGroupsOne, groupSecond, ignoreGroupsSecond, groupOne}

    for i=1,#ignorePairs-1,2 do
      local groups = ignorePairs[i]
      local ignoreGroupOne = ignorePairs[i+1]
      for _, ignoreGroupSecond in ipairs(groups) do
        --print("comparing1", ignoreGroup, groupSecond, groupOne)
        if ignoreGroupOne == ignoreGroupSecond then return false end
      end
    end

    if item:has(cmps.bullet) or other:has(cmps.bullet) then
      return "touch"
    end

    return "slide"
  end)
  entity:get(cmps.position).vector = Vector(actualX, actualY)

  for i=1,len do
    self:getWorld():emit("collision", entity, cols[i].other)
  end
end

function CollisionSystem:collision(first, second)
  if first:has(cmps.bullet) or second:has(cmps.bullet) then
    self:getWorld():emit("bulletCollision", first, second)
  end

  if first:has(cmps.pickUp) then
    self:getWorld():emit("pickUpReceived", second, first:get(cmps.pickUp))
  end
end

return CollisionSystem
