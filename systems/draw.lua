local mediaManager = require 'media.manager'
local camera = require 'models.camera'

local DrawSystem = Concord.system({cmps.sprite, cmps.position, 'sprites'}, {cmps.position, cmps.circle, 'circles'})

function DrawSystem:init(world)
  self.spriteBatch = love.graphics.newSpriteBatch(mediaManager.atlas, 500)
  print("draw init")
end

function DrawSystem:draw()
  camera:attach()
  love.graphics.clear(0,0,0,1)
  self.spriteBatch:clear()
  for i=1,#self.sprites do
    local entity = self.sprites[i]
    local spritePath = entity:get(cmps.sprite).path
    local position = entity:get(cmps.position).vector

    local quad = mediaManager.getSpriteQuad(spritePath)
    local _, _, w, h = quad:getViewport()

    if entity:has(cmps.color) then
      self.spriteBatch:setColor(entity:get(cmps.color).color)
    else
      self.spriteBatch:setColor(1,1,1,1)
    end

    self.spriteBatch:add(quad, position.x, position.y)
  end

  love.graphics.draw(self.spriteBatch)

  for i=1,#self.circles do
    local entity = self.circles[i]
    local position = entity:get(cmps.position).vector
    local circleRadius = entity:get(cmps.circle).radius

    if entity:has(cmps.color) then
      love.graphics.setColor(entity:get(cmps.color).color)
    else
      love.graphics.setColor(1,1,1,1)
    end

    love.graphics.circle('fill', position.x, position.y, circleRadius)
  end

  camera:detach()
end

return DrawSystem
