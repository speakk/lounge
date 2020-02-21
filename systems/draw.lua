local mediaManager = require 'media.manager'

local DrawSystem = Concord.system({cmps.sprite, cmps.position, 'sprites'}, {cmps.position, cmps.circle, 'circles'})

function DrawSystem:init(world)
  self.spriteBatch = love.graphics.newSpriteBatch(mediaManager.atlas, 500)
  print("draw init")
end

function DrawSystem:draw()
  love.graphics.clear(0,0,0,1)
  self.spriteBatch:clear()
  for i=1,#self.sprites do
    local spriteEntity = self.sprites[i]
    local spritePath = spriteEntity:get(cmps.sprite).path
    local position = spriteEntity:get(cmps.position).vector

    local quad = mediaManager.getSpriteQuad(spritePath)
    local _, _, w, h = quad:getViewport()

    self.spriteBatch:add(quad, position.x, position.y)
  end

  love.graphics.draw(self.spriteBatch)

  for i=1,#self.circles do
    local circleEntity = self.circles[i]
    local position = circleEntity:get(cmps.position).vector
    local circleRadius = circleEntity:get(cmps.circle).radius

    love.graphics.circle('fill', position.x, position.y, circleRadius)
  end
end

return DrawSystem
