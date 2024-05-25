-- Common utilities

local Common = {}
function Common.config(name)
  return settings.startup['uncl:uh-'..name].value
end

-- Clones a prototype. Input is a prototype type ("recipe", "armor", etc), an
-- existing object of that prototype ("heavy-armor"), and the name for the clone
-- Retuns the clone
function Common.cloneInto(prototype, from, into)
  data.raw[prototype][into] = table.deepcopy(data.raw[prototype][from])
  data.raw[prototype][into].name = into;
  return data.raw[prototype][into]
end

return Common
