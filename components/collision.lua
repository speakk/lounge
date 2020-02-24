return Concord.component(function(component, w, h, group, ignoreGroups, event)
  component.w = w
  component.h = h
  component.group = group or error("Collision component needs group")
  component.ignoreGroups = ignoreGroups or {}
  component.event = event
end)

