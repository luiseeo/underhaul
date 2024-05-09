-- Util library for technologies. Supports method chaining
-- Sample usage:
-- Tech:get("tech-name"):setCost(200):setColors("RG")

local Tech = {}
local techName = ""

function Tech:get(name)
  techName = name
  assert(data.raw["technology"][name], "Technology '"..name.."' not found")
  local technology = data.raw["technology"][name].normal or data.raw["technology"][name]
  setmetatable(technology, self)
  self.__index = self
  return technology
end

-- Changes the cost of a Technology. It keeps the Science colors required
function Tech:setCost(count)
  self.unit.count = count
  return self
end

function Tech:setCostFormula(formula)
  self.unit.count = nil
  self.unit.count_formula = formula
  return self
end

-- Changes the science packs (colors) required for the technology
function Tech:setColors(colors)
  local ingredients = {}
  if colors:find("R", 1, false) then
    table.insert(ingredients, {"automation-science-pack", 1})
  end
  if colors:find("G", 1, false) then
    table.insert(ingredients, {"logistic-science-pack", 1})
  end
  if colors:find("B", 1, false) then
    table.insert(ingredients, {"chemical-science-pack", 1})
  end
  if colors:find("M", 1, false) then
    table.insert(ingredients, {"military-science-pack", 1})
  end
  if colors:find("P", 1, false) then
    table.insert(ingredients, {"production-science-pack", 1})
  end
  if colors:find("Y", 1, false) then
    table.insert(ingredients, {"utility-science-pack", 1})
  end
  if colors:find("W", 1, false) then
    table.insert(ingredients, {"space-science-pack", 1})
  end

  self.unit.ingredients = ingredients
  return self
end

-- How much time one unit takes to research.
-- In a lab with a crafting speed of 1, it corresponds to the number of seconds.
function Tech:setTime(time)
  self.unit.time = time
  return self
end

-- Set the effects of researching the technology
-- see: https://lua-api.factorio.com/latest/types/Modifier.html
function Tech:setEffects(effects)
  self.effects = effects
  return self
end

-- Shorter version of setEffects for just 1 effect (which is common)
function Tech:setEffect(effect)
  self.effects = { effect }
  return self
end

function Tech:disable()
  self.enabled = false
  -- TODO: should we hide it too (for saves which already have researched the tech)?
  -- Could it be better to just remove the technology instead?
  return self
end

-- Declare the technology as an infinite technology (it can get researched multiple times)
function Tech:setInfinite()
  self.max_level = "infinite"
  return self
end

-- Removes the technology altogether
-- Note: it might be the only way to deal with making infinite technologies shorter
function Tech:remove()
  data.raw["technology"][techName] = nil
  -- Note we don't return self here, as the technology is gone!
end

return Tech
