local moonshine = require 'libs.moonshine'
local lume = require 'libs.lume'

local mediaManager = require 'media.manager'
local camera = require 'models.camera'

local fpsFont = love.graphics.newFont("fonts/MavenPro-Medium.ttf", 16)

local background = love.graphics.newImage('media/background/lounge_game_background.jpg')

local DrawSystem = Concord.system({cmps.sprites, cmps.position, 'sprites'}, {cmps.position, cmps.circle, 'circles'}, {cmps.layer, cmps.sprites, 'layers'})

function initLayer(index, shader)
  return {
    index = index,
    entities = {},
    shader = shader,
    spriteBatch = love.graphics.newSpriteBatch(mediaManager.atlas, 500)
  }
end

local layers = {
  default = initLayer(4),
  glow = initLayer(3, 'glow'),
  onGround = initLayer(2),
  ground = initLayer(1)
}

local layersSorted = lume.sort(lume.filter(layers, function() return true end), "index")

function DrawSystem:init(world)
  self.effects = {
    glow = moonshine(moonshine.effects.glow),
    vignette = moonshine(moonshine.effects.vignette)
  }

  self.spriteBatch = love.graphics.newSpriteBatch(mediaManager.atlas, 500)

  self.layers.onEntityAdded = function(pool, entity)
    local layerName = entity:get(cmps.layer).name
    local layer = layers[layerName]
    table.insert(layer.entities, entity)
  end

  self.layers.onEntityRemoved = function(pool, entity)
    local layerName = entity:get(cmps.layer).name
    local layer = layers[layerName]
    lume.remove(layer.entities, entity)
  end
end

local nilEffect = function(func) func() end


function drawSprite(entity, sprite, spriteBatch)
  local spritePath = sprite.path
  local position = entity:get(cmps.position).vector

  local quad = mediaManager.getSpriteQuad(spritePath)
  local _, _, w, h = quad:getViewport()

  spriteBatch:setColor(1,1,1,1)

  if entity:has(cmps.color) then
    spriteBatch:setColor(entity:get(cmps.color).color)
  end

  spriteBatch:add(quad, position.x + (sprite.x or 0), position.y + (sprite.y or 0))
end

function DrawSystem:draw()
  camera:attach()
  love.graphics.draw(background,0,0,0,1,1)
  love.graphics.setColor(1,1,1,1)
  for i=1,#layersSorted do
    local layer = layersSorted[i]
    local spriteBatch = layer.spriteBatch
    spriteBatch:clear()

    local effect = nilEffect

    -- TODO: For now ignore layer shaders as moonshine + camera is strange
    -- if layer.shader then
    --   effect = self.effects[layer.shader]
    -- end

    effect(function()
      for b=1,#layer.entities do
        local entity = layer.entities[b]

        if entity:has(cmps.characterSpriteSheet) then
          local current = entity:get(cmps.characterSpriteSheet).current
          if current then
            drawSprite(entity, current, spriteBatch)
          end
        end

        local sprites = entity:get(cmps.sprites).sprites
        for p=1,#sprites do
          local sprite = sprites[p]
          drawSprite(entity, sprite, spriteBatch)
        end
      end

      love.graphics.draw(spriteBatch)
    end)
  end

  -- self.glowEffect(function()
  --   for i=1,#self.circles do
  --     local entity = self.circles[i]
  --     local position = entity:get(cmps.position).vector
  --     local circleRadius = entity:get(cmps.circle).radius

  --     if entity:has(cmps.color) then
  --       love.graphics.setColor(entity:get(cmps.color).color)
  --     else
  --       love.graphics.setColor(1,1,1,1)
  --     end

  --     love.graphics.circle('fill', position.x, position.y, circleRadius)
  --   end
  -- end)

  camera:detach()
  -- love.graphics.setColor(1,1,1,1)
  -- love.graphics.setFont(fpsFont)
  --love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end

return DrawSystem
