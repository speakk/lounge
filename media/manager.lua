local generateTileName = function(category, name) return 'media/' .. category .. '/' .. name .. '.png' end

local mediaDB = {
  {
    name = "characters",
    items = { 'lounge_game_player_front_face' },
  },
  {
    name = "decals",
    items = { 'lounge_game_blood_splat' },
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
    for _, name in ipairs(category.items) do
      local fileName = generateTileName(category.name, name)
      local sprite = love.graphics.newImage(fileName)
      local spriteWidth, spriteHeight = sprite:getDimensions()

      love.graphics.draw(sprite, currentX, currentY)

      local quad = love.graphics.newQuad(currentX, currentY, spriteWidth, spriteHeight, atlasCanvas:getDimensions())
      print("drawing to canvas", currentX, currentY, spriteWidth, spriteHeight, atlasCanvas:getDimensions())

      flatMediaDB[category.name .. "." .. name] = {
        quad = quad
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
  --print(inspect(flatMediaDB[selector]))
  if not selector then error("getSprite is missing selector") end

  if not flatMediaDB[selector] then error("No sprite found with selector: " .. selector) end
  return flatMediaDB[selector].quad
end

return {
  atlas = atlasCanvas,
  getSpriteQuad = getSpriteQuad
}
