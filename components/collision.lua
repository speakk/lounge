return Concord.component(function(component, w, h, group, ignoreGroups, collisionResponse, event)
  component.w = w
  component.h = h
  component.group = group or error("Collision component needs group")
  component.ignoreGroups = ignoreGroups or {}
  component.collisionResponse = collisionResponse
  component.event = event
end)

