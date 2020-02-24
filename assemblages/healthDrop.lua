return Concord.assemblage(function(entity, position)
  entity:assemble(Concord.assemblages.drop, position, "drops.health", "health", { amount = 20 })
end)

