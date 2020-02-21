--local mediaManager = require 'media.manager'
local DrawSystem = Concord.system({cmps.sprite, 'sprites'})

function DrawSystem:init()
  self.spriteBatch = love.graphics.newSpriteBatch(mediaManager.atlas, 500)
end

function DrawSystem:draw()
  for i=1,#self.sprites do
    local spriteEntity = self.sprites[i]
    local spritePath = spriteEntity:get(cmps.sprite).path
    local position = spriteEntity:get(cmps.position).position

    local quad = mediaManager.getSpriteQuad(spritePath)
    local _, _, w, h = quad:getViewport()

    self.spriteBatch:add(quad, position.x, position.y)
  end

  love.graphics.draw(self.spriteBatch)
end

return DrawSystem
