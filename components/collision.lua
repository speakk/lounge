return Concord.component(function(component, x, y, w, h, group, ignoreGroups, collisionResponse, event, eventIgnoreGroups, eventInclusionGroups)
  component.x = x
  component.y = y
  component.w = w
  component.h = h
  component.group = group or error("Collision component needs group")
  component.ignoreGroups = ignoreGroups or {}
  component.collisionResponse = collisionResponse
  component.event = event
  component.eventIgnoreGroups = eventIgnoreGroups
  component.eventInclusionGroups = eventInclusionGroups
end)

