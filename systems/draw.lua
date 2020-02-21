local mediaManager = require 'media.manager'

local DrawSystem = Concord.system({cmps.sprite, cmps.position, 'sprites'})

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
end

return DrawSystem
