return Concord.assemblage(function(entity, position, spritePath, pickUpType, params)
  entity:give(cmps.position, position)
  entity:give(cmps.sprites, {
    { path = "decals.glow", x = -30, y = -30 },
    { path = spritePath }
  })
  entity:give(cmps.collision, 0, 0, 10, 10, "pickup", { "ai", "bullet" }, "touch", "pickUpReceived")
  entity:give(cmps.layer, 'onGround')
  entity:give(cmps.pickUp, pickUpType, params)
end)
