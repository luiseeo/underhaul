-- Common utilities

local Common = {}
function Common.config(name)
  return settings.startup['uncl:uh-'..name].value
end

return Common
