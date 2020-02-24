local Vector = require 'libs.brinevector'
local bump = require 'libs.bump'
local lume = require 'libs.lume'

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
    local collisionCOne = item:get(cmps.collision)
    local collisionCSecond = other:get(cmps.collision)

    local groupOne = collisionCOne.group
    local groupSecond = collisionCSecond.group
    local ignoreGroupsOne = collisionCOne.ignoreGroups
    local ignoreGroupsSecond = collisionCSecond.ignoreGroups

    local ignorePairs = {ignoreGroupsOne, groupSecond, ignoreGroupsSecond, groupOne}

    for i=1,#ignorePairs-1,2 do
      local groups = ignorePairs[i]
      local ignoreGroupOne = ignorePairs[i+1]
      for _, ignoreGroupSecond in ipairs(groups) do
        if ignoreGroupOne == ignoreGroupSecond then return false end
      end
    end

    return collisionCOne.collisionResponse or "slide"
  end)
  entity:get(cmps.position).vector = Vector(actualX, actualY)

  for i=1,len do
    self:getWorld():emit("collision", entity, cols[i].other)
  end
end

function CollisionSystem:collision(first, second)
  local entities = {first, second}
  for i = 1,#entities do
    local entity = entities[i]
    local collisionC = entity:get(cmps.collision)
    local event = collisionC.event
    if event then
      local secondEntity = lume.filter(entities, function(ent) return ent ~= entity end)[1]
      if collisionC.eventIgnoreGroups then
        local secondEntityGroup = secondEntity:get(cmps.collision).group
        for _, ignoreGroup in ipairs(collisionC.eventIgnoreGroups) do
          if ignoreGroup == secondEntityGroup then return end
        end
      end

      self:getWorld():emit(event, entity, secondEntity)
    end
  end

  --if first:has(cmps.bullet) or second:has(cmps.bullet) then
  --  self:getWorld():emit("bulletCollision", first, second)
  --end

  --if first:has(cmps.pickUp) then
  --  self:getWorld():emit("pickUpReceived", second, first)
  --end

  --if second:has(cmps.pickUp) then
  --  self:getWorld():emit("pickUpReceived", first, second)
  --end
end

return CollisionSystem
