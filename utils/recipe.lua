-- Util library for recipes. Supports method chaining
-- Sample usage:
-- Recipe:get("recipe-name"):setCost(200):setColors("RG")

local Common = require "common"
local Recipe = {}
local recipeName = ""

function Recipe:get(name)
  recipeName = name
  assert(data.raw["recipe"][name], "Recipe '"..name.."' not found")
  local recipe = data.raw["recipe"][name].normal or data.raw["recipe"][name]
  setmetatable(recipe, self)
  self.__index = self
  return recipe
end

-- Creates a new recipe by cloning an existing one
function Recipe:cloneInto(from, into)
  Common.cloneInto("recipe", from, into)
  return Recipe:get(into)
end

-- Changes the Recipe ingredients (the input)
function Recipe:setIngredients(ingredients)
  self.ingredients = ingredients
  return self
end

-- Changes the Recipe products (the output)
function Recipe:setProducts(products)
  self.results = products
  return self
end

-- Changes the amount of energy (or seconds for crafting at speed 1)
function Recipe:setEnergy(energy_required)
  self.energy_required = energy_required
  return self
end

-- Disable the recipe
function Recipe:disable()
  self.enabled = false
  return self
end

return Recipe
