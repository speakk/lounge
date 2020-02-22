return Concord.component(function(component, w, h, group, ignoreGroups)
  component.w = w
  component.h = h
  component.group = group or error("Collision component needs group")
  component.ignoreGroups = ignoreGroups or {}
end)

