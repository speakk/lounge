local generateTileName = function(category, name) return 'media/' .. category .. '/' .. name .. '.png' end

local mediaDB = {
  {
    name = "characters",
    items = {
      {
        name = "playerFront",
        fileName = 'lounge_game_player_front_face',
        hotPoints = { gunMuzzle = { 88, 95 } }
      },
      {
        name = "playerLeft",
        fileName = 'lounge_game_player_left_face',
        hotPoints = { gunMuzzle = { 1, 70 } }
      },
      {
        name = "playerRight",
        fileName = 'lounge_game_player_right_face',
        hotPoints = { gunMuzzle = { 130, 70 } }
      },
      {
        name = "playerBack",
        fileName = 'lounge_game_player_back_face',
        hotPoints = { gunMuzzle = { 43, 30 } }
      },
    },
  },
  {
    name = "decals",
    items = {
      {
        name = 'bloodSplat',
        fileName = 'lounge_game_blood_splat'
      },
      {
        name = 'bullet',
        fileName = 'bullet'
      }
    }
  }
}

local flatMediaDB = {}
local fileList = {}

local atlasWidth = 1280
local atlasHeight = 1280
local atlasCanvas = love.graphics.newCanvas(atlasWidth, atlasHeight)
do
  love.graphics.setCanvas(atlasCanvas)
  love.graphics.clear()

  local currentX = 0
  local currentY = 0
  local lastRowHeight = 0

  for _, category in ipairs(mediaDB) do
    for _, item in ipairs(category.items) do
      local fileName = generateTileName(category.name, item.fileName)
      local sprite = love.graphics.newImage(fileName)
      local spriteWidth, spriteHeight = sprite:getDimensions()

      love.graphics.draw(sprite, currentX, currentY)

      local quad = love.graphics.newQuad(currentX, currentY, spriteWidth, spriteHeight, atlasCanvas:getDimensions())
      print("drawing to canvas", currentX, currentY, spriteWidth, spriteHeight, atlasCanvas:getDimensions())

      flatMediaDB[category.name .. "." .. item.name] = {
        quad = quad,
        hotPoints = item.hotPoints
      }

      currentX = currentX + spriteWidth
      if spriteHeight > lastRowHeight then
        lastRowHeight = spriteHeight
      end

      if currentX + spriteWidth > atlasWidth then
        currentX = 0
        currentY = currentY + lastRowHeight
        lastRowHeight = 0
      end

      -- index = index + 1
      -- table.insert(fileList, fileName)
    end
  end

  love.graphics.setCanvas()
end

local function getSpriteQuad(selector)
  if not selector then error("getSprite is missing selector") end
  if not flatMediaDB[selector] then error("No sprite found with selector: " .. selector) end
  return flatMediaDB[selector].quad
end

local function getSprite(selector)
  if not selector then error("getSprite is missing selector") end
  if not flatMediaDB[selector] then error("No sprite found with selector: " .. selector) end
  return flatMediaDB[selector]
end

return {
  atlas = atlasCanvas,
  getSpriteQuad = getSpriteQuad,
  getSprite = getSprite
}
