-- We'll change a bunch of recipes and technologies from Vanilla
local Common = require "utils.common"
local Recipe = require "utils.recipe"
local Tech = require "utils.tech"


-- Key changes:
-- Cheaper steel (3 iron plates, instead of 5)
-- Ratio of copper cable to Green circuits is 1:1 (instead of 3:2)
-- Cheaper Red circuits (1 plastic bar, instead of 2)
-- Cheaper Blue circuits (10 GCs, instead of 20)
-- Science ratio (for R:G:M:B:P:Y) is 5:5:5:6:6:6 (instead of 5:6:5:12:7:7)
-- Reduce the number of bonus technologies. They are fewer but give bigger bonuses
-- Remove technologies that most people don't use (like combat robots)

-----------------------
-- LOGISTICS RECIPES --
-----------------------

-- BELTS --
-- Yellow underground. Reduce iron plate cost from 10 -> 8
Recipe:get("underground-belt"):setIngredients({
  {"iron-plate", 8},
  {"transport-belt", 5}
})
-- Yellow splitter. Reduce cost from 5iron+5GC+4yellowBelt -> 4iron+4GC+4yellowBelt
Recipe:get("splitter"):setIngredients({
  {"iron-plate", 4},
  {"electronic-circuit", 4},
  {"transport-belt", 4}
})

-- Red Belt. Reduce gear cost from 5 -> 3
Recipe:get("fast-transport-belt"):setIngredients({
  {"iron-gear-wheel", 3},
  {"transport-belt", 1}
})
-- Red underground. Reduce gear cost from 40 -> 24
Recipe:get("fast-underground-belt"):setIngredients({
  {"iron-gear-wheel", 24},
  {"underground-belt", 2}
})
-- Red splitter. Reduce cost from 10gear+10GC+1yellowSplitter -> 6gear+8GC+1yellowSplitter
Recipe:get("fast-splitter"):setIngredients({
  {"iron-gear-wheel", 6},
  {"electronic-circuit", 8},
  {"splitter", 1}
})

-- Blue belt. Reduce cost from 10gear+1redBelt+20lubricant -> 6gear+1redBelt+20lubricant
Recipe:get("express-transport-belt"):setIngredients({
  {"iron-gear-wheel", 6},
  {"fast-transport-belt", 1},
  {type="fluid", name="lubricant", amount=20}
})
-- Blue underground. Reduce cost from 80gear+2redUnderground+40lubricant -> 48gear+2redUnderground+40lubricant
Recipe:get("express-underground-belt"):setIngredients({
  {"iron-gear-wheel", 48},
  {"fast-underground-belt", 2},
  {type="fluid", name="lubricant", amount=40}
})
-- Blue splitter. Reduce cost from 10gear+10RC+1redSplitter+80lubricant -> 6gear+8RC+1redSplitter+80lubricant
Recipe:get("express-splitter"):setIngredients({
  {"iron-gear-wheel", 6},
  {"advanced-circuit", 8},
  {"fast-splitter", 1},
  {type="fluid", name="lubricant", amount=80}
})

-- Stack inserter. Reduce cost from 15gear+15GC+1RC+1fastInserter -> 10gear+10GC+1RC+fastInserter
Recipe:get("stack-inserter"):setIngredients({
  {"iron-gear-wheel", 10},
  {"electronic-circuit", 10},
  {"advanced-circuit", 1},
  {"fast-inserter", 1}
})
-- Stack filter inserter. Reduce GC cost from 5 -> 4
Recipe:get("stack-filter-inserter"):setIngredients({
  {"electronic-circuit", 4},
  {"stack-inserter", 1}
})

-- Pipe to ground. Reduce iron plate cost from 5 -> 2
Recipe:get("pipe-to-ground"):setIngredients({
  {"iron-plate", 2},
  {"pipe", 10}
})
-- Rail. Change cost from 1stone+1steel+1ironStick -> 1stone+2steel
Recipe:get("rail"):setIngredients({
  {"stone", 1},
  {"steel-plate", 2}
})
-- Locomotive. Reduce engine cost from 20 -> 10
Recipe:get("locomotive"):setIngredients({
  {"steel-plate", 30},
  {"electronic-circuit", 10},
  {"engine-unit", 10}
})

-- Spidertron. Reduce cost from 1fish+16RCU+150LDS+2efficiencyMod3+4rocketLauncher+2portableFusionReactor+4exoskeletons+2radar
-- -> 1fish+8RCU+80LDS+1efficiencyMod3+4rocketLauncher+1portableFusionReactor+4exoskeletons+2radar
Recipe:get("spidertron"):setIngredients({
  {"raw-fish",1},
  {"rocket-control-unit", 8},
  {"low-density-structure", 80},
  {"effectivity-module-3", 1},
  {"rocket-launcher", 4},
  {"fusion-reactor-equipment", 1},
  {"exoskeleton-equipment", 4},
  {"radar", 2}
})

-- Roboport. Reduce cost from 45steel+45gear+45RC -> 30steel+30gear+30RC
Recipe:get("roboport"):setIngredients({
  {"steel-plate", 30},
  {"iron-gear-wheel", 30},
  {"advanced-circuit", 30}
})

-- Landfill. Reduce stone cost from 20 -> 10
Recipe:get("landfill"):setIngredients({
  {"stone", 10}
})

-- Cliff explosives. Reduce cost from 10explosives+1emptyBarrel+1grenade -> 6explosives+1emptyBarrel
Recipe:get("cliff-explosives"):setIngredients({
  {"explosives", 6},
  {"empty-barrel", 1}
})
-- Reduce crafting time from 8 -> 5 seconds
:setEnergy(5)


------------------------
-- PRODUCTION RECIPES --
------------------------

-- ENERGY SOURCES --
-- Solar panel cost changed from 5copper+15GC+5steel -> 4copper+16GC+8steel
Recipe:get("solar-panel"):setIngredients({
  {"copper-plate", 4},
  {"steel-plate", 8},
  {"electronic-circuit", 16}
})
-- Solar panel electricity output increased from 60kw -> 80kW (full daylight).
-- Avg 42kW -> 56kW
data.raw["solar-panel"]["solar-panel"].production = "80kW"
-- Make collision box smaller so that we can fix between 2 solar panels!
if Common.config "squeak-solar-panels" then
  data.raw["solar-panel"]["solar-panel"].collision_box = {{-1.25, -1.25}, {1.25, 1.25}}
end

-- Solar panel to accumulator ratio changed from 25:21 -> 4:1
-- Accumulator. Increase capacity from 5MJ -> 22.4MJ
data.raw["accumulator"]["accumulator"].energy_source.buffer_capacity = "22.4MJ"
-- Increase max input and out from 300kW -> 1MW
data.raw["accumulator"]["accumulator"].energy_source.input_flow_limit = "1MW"
data.raw["accumulator"]["accumulator"].energy_source.output_flow_limit = "1MW"

-- Nuclear reactor. Reduce cost from 500copper+500steel+500RC+500concrete -> 300copper+300steel+200RC+200concrete
Recipe:get("nuclear-reactor"):setIngredients({
  {"copper-plate", 300},
  {"steel-plate", 300},
  {"advanced-circuit", 200},
  {"concrete", 200}
})

-- Electric furnace. Reduce RC cost from 5 -> 2
Recipe:get("electric-furnace"):setIngredients({
  {"steel-plate", 10},
  {"advanced-circuit", 2},
  {"stone-brick", 10}
})

-- Assembling machine 3. Reduce cost from 2AM2+3speedMod1 -> 1AM2+2speedMod1
Recipe:get("assembling-machine-3"):setIngredients({
  {"assembling-machine-2", 1},
  {"speed-module", 2}
})

-- Centrifuge. Reduce cost from 50steel+100gear+100RC+100concrete -> 50steel+50gear+50RC+50concrete
Recipe:get("centrifuge"):setIngredients({
  {"steel-plate", 50},
  {"iron-gear-wheel", 50},
  {"advanced-circuit", 50},
  {"concrete", 50}
})

-- MODULES --
local modules =  {"speed-module", "productivity-module", "effectivity-module"}
for i,m in ipairs(modules) do
  -- Module 1. Reduce crafting time from 15 -> 10s
  Recipe:get(m):setEnergy(10)

  -- Module 2. Reduce cost from 5RC+5BC+4mod1 -> 3RC+3BC+3mod1
  Recipe:get(m.."-2"):setIngredients({
    {"advanced-circuit", 3},
    {"processing-unit", 3},
    {m, 3}
  })
  -- Reduce crafting time from 30 -> 15s
  :setEnergy(15)

  -- Module 3. Reduce cost from 5RC+5BC+5mod2 -> 4RC+4BC+4mod2
  Recipe:get(m.."-3"):setIngredients({
    {"advanced-circuit", 4},
    {"processing-unit", 4},
    {m.."-2", 4}
  })
  -- Reduce crafting time from 60 -> 20s
  :setEnergy(20)
end

-- Rocket silo. Reduce from 1000steel+200BC+200electricEngine+100pipe+1000concrete ->
-- -> 500steel+100BC+100electricEngine+500concrete
Recipe:get("rocket-silo"):setIngredients({
  {"steel-plate", 500},
  {"processing-unit", 100},
  {"electric-engine-unit", 100},
  {"concrete", 500}
})

-- Satellite. Reduce from from 100BC+100LDS+100solarPanel+100accumulator+50rocketFuel+5radar -> 50BC+50LDS+50solarPanel+50accumulator
Recipe:get("satellite"):setIngredients({
  {"processing-unit", 50},
  {"low-density-structure", 50},
  {"solar-panel", 50},
  {"accumulator", 50}
})

-----------------------------------
-- INTERMEDIATE PRODUCTS RECIPES --
-----------------------------------

-- Steel plate. Reduce the iron cost from 5 -> 3
Recipe:get("steel-plate"):setIngredients({
  {"iron-plate", 3}
})
-- Reduce crafting time from 16 -> 9.6 seconds
:setEnergy(9.6)

-- Battery. Reduce crafting time from 4 -> 3 seconds
Recipe:get("battery"):setEnergy(3)

-- Explosives. Reduce crafting time from 4 -> 3 seconds
Recipe:get("explosives"):setEnergy(3)

-- Uranium processing. Reduce uranium ore cost from 10 -> 8
Recipe:get("uranium-processing"):setIngredients({
  {"uranium-ore", 8}
})
--Reduce crafting time from 12 -> 8s. Overall effect: 1 ore per second
Recipe:get("uranium-processing"):setEnergy(8)


-- GREEN CIRCUIT --
--> Copper cable + Green cicuit assembler ratio changes from 3:2 -> 1:1
-- Copper cable. Reduce crafting time from 0.5 -> 0.4 seconds
Recipe:get("copper-cable"):setEnergy(0.4)
-- Green circuit. Increase crafting time from 0.5 -> 0.6 seconds
Recipe:get("electronic-circuit"):setEnergy(0.6)

-- RED CIRCUIT --
-- Reduce crafting time from 6 -> 3 seconds
Recipe:get("advanced-circuit"):setEnergy(3)
-- Reduce plastic cost from 2 -> 1
-- Reduce copper cable cost from 4 -> 3
:setIngredients({
  {"plastic-bar", 1},
  {"copper-cable", 3},
  {"electronic-circuit", 2}
})

-- BLUE CIRCUIT --
-- Reduce Green circuit cost from 20 -> 10
Recipe:get("processing-unit"):setIngredients({
  {"electronic-circuit", 10},
  {"advanced-circuit", 2},
  {type="fluid", name="sulfuric-acid", amount=5}
})
-- Reduce crafting time from 10 -> 6 seconds
Recipe:get("processing-unit"):setEnergy(6)

-- Engine unit. Reduce crafting time from 10 -> 6 seconds
Recipe:get("engine-unit"):setEnergy(6)
-- Reduce pipe cost from 2 -> 1
:setIngredients({
  {"steel-plate", 1},
  {"iron-gear-wheel", 1},
  {"pipe", 1}
})
-- Flying robot frame. Reduce crafting time from 20 -> 12 seconds
Recipe:get("flying-robot-frame"):setEnergy(12)

-- Rocket control unit. Reduce crafting time from 30 -> 15 seconds
Recipe:get("rocket-control-unit"):setEnergy(15)

-- Low Density Structure. Reduce cost from 20copper+10steel+5plastic -> 12copper+6steel+3plastic
Recipe:get("low-density-structure"):setIngredients({
  {"copper-plate", 12},
  {"steel-plate", 6},
  {"plastic-bar", 3}
})
-- Reduce crafting time from 20 -> 15 seconds
Recipe:get("low-density-structure"):setEnergy(15)

-- Rocket fuel. Reduce cost from 10solidFuel+10lightOil -> 5solidFuel+10lightOil?
Recipe:get("rocket-fuel"):setIngredients({
  {"solid-fuel", 5},
  {type="fluid", name="light-oil", amount=10}
})
-- Reduce crafting time from 30 -> 15 seconds
:setEnergy(15)

-- Kovarex. Make the kickstart cheaper from 40u235+5u238 = 41u235+2u238
-- -> 20u235+5u238 = 21u235+2u238
Recipe:get("kovarex-enrichment-process"):setIngredients({
  {"uranium-235", 20},
  {"uranium-238", 5}
})
:setProducts({
  {"uranium-235", 21},
  {"uranium-238", 2}
})

-- SCIENCE PACKS
-- Red science. Already at desired ratio!
-- Green science. Reduce crafting time from 6 -> 5s
Recipe:get("logistic-science-pack"):setEnergy(5)
-- Gray (Military) science. Already at desired ratio!
-- Blue science. Reduce crafting time from 24 -> 12s
Recipe:get("chemical-science-pack"):setEnergy(12)
-- Purple science. Reduce crafting time from 21 -> 18s
Recipe:get("production-science-pack"):setEnergy(18)
-- Reduce rail cost from 30 -> 15 
:setIngredients({
  {"rail", 15},
  {"electric-furnace", 1},
  {"productivity-module", 1}
})
-- Yellow science. Reduce crafting time from 21 -> 18s
Recipe:get("utility-science-pack"):setEnergy(18)


------------
-- COMBAT --
------------

-- Grenade. Reduce crafting time from 8 -> 5s
Recipe:get("grenade"):setEnergy(5)
-- Reduce cost from 10coal+5iron -> 4coal+4iron
:setIngredients({
  {"coal", 4},
  {"iron-plate", 4}
})

-- Heavy armor. Reduce copper cost from 100 -> 50
Recipe:get("heavy-armor"):setIngredients({
  {"copper-plate", 50},
  {"steel-plate", 50}
})

-- Modular armor. Reduce RC cost from 30 -> 25
Recipe:get("modular-armor"):setIngredients({
  {"steel-plate", 50},
  {"advanced-circuit", 25}
})

-- Power armor. Change recipe from 40steel+40BC+20electricEngine -> 40steel+20BC+10electricEngine
Recipe:get("power-armor"):setIngredients({
  {"steel-plate", 40},
  {"processing-unit", 20},
  {"electric-engine-unit", 10}
})

-- Power armor MK2. Change recipe from 60BC+40electricEngine+30LDS+25speedMod2+25efficiencyMod2
-- -> 20electricEngine+20LDS+10speedMod2+10efficiencyMod2
Recipe:get("power-armor-mk2"):setIngredients({
  {"electric-engine-unit", 20},
  {"low-density-structure", 20},
  {"speed-module-2", 10},
  {"effectivity-module-2", 10}
})

-- Portable fusion reactor. Reduce BC cost from 200 -> 100
Recipe:get("fusion-reactor-equipment"):setIngredients({
  {"processing-unit", 100},
  {"low-density-structure", 50}
})

-- Personal battery MK2. Change recipe from 15BC+5LDS+10personalBattery
-- -> 8BC+8LDS+8personalBattery
Recipe:get("battery-mk2-equipment"):setIngredients({
  {"processing-unit", 8},
  {"low-density-structure", 8},
  {"battery-equipment", 8}
})

-- Personal roboport. Change recipe from 20steel+45battery+40gear+10RC
-- -> 20steel+10battery+10gear+10RC
Recipe:get("personal-roboport-equipment"):setIngredients({
  {"steel-plate", 20},
  {"battery", 10},
  {"iron-gear-wheel", 10},
  {"advanced-circuit", 10}
})

-- Personal roboport MK2. Change recipe from 100BC+20LDS+5roboport
-- -> 25BC+25LDS+5roboport
Recipe:get("personal-roboport-mk2-equipment"):setIngredients({
  {"processing-unit", 25},
  {"low-density-structure", 25},
  {"personal-roboport-equipment", 5}
})

-- Energy shield MK2. Reduce energy shield cost from 10 -> 6
Recipe:get("energy-shield-mk2-equipment"):setIngredients({
  {"processing-unit", 5},
  {"low-density-structure", 5},
  {"energy-shield-equipment", 6}
})

-- Personal laser defense. Reduce laser turret cost from 5 -> 2
Recipe:get("personal-laser-defense-equipment"):setIngredients({
  {"processing-unit", 20},
  {"low-density-structure", 5},
  {"laser-turret", 2}
})

-- Radar. Reduce power usage from 300kW -> 150kW
-- Sectors are slighly cheaper/faster to scan
local radarEntity = data.raw["radar"]["radar"]
radarEntity.energy_usage = "150kW"
radarEntity.energy_per_sector = "4MJ"
radarEntity.energy_per_nearby_scan = "125kJ"


------------------
-- TECHNOLOGIES --
------------------
-- Glossary:
-- R:Red, G:Green, M:Gray(Military)
-- B:Blue, P:Purple, Y:Yellow, W:White

-- Steel axe. Reduce from 50R@30s -> 30R@30s
Tech:get("steel-axe"):setCost(30)
-- Landfill. Reduce from 50R+G @30s -> 30R+G@30s
Tech:get("landfill"):setCost(30)
-- Railway. Reduce from 75R+G @30s -> 50R+G@30s
Tech:get("railway"):setCost(50)
-- Automated rail transportation. Reduce from 75R+G@30s -> 50R+G@30s
Tech:get("automated-rail-transportation"):setCost(50)
-- Rail signals. Reduce from 100R+G@30s -> 75R+G@30s
Tech:get("rail-signals"):setCost(75)
-- Fluid wagon. Reduce from 200R+G@30s -> 75R+G@30s
Tech:get("fluid-wagon"):setCost(75)
-- Circuit network. Reduce from 100R+G@15s -> 50R+G@15s
Tech:get("circuit-network"):setCost(50)
-- Toolbelt. Reduce from 100R+G@30s -> 50R+G@30s
Tech:get("toolbelt"):setCost(50)
-- Solar energy. Reduce from 250R+G@30s -> 200R+G@30s
Tech:get("solar-energy"):setCost(200)
-- Portable solar panel. Reduce from 100R+G@15s -> 50R+G@15s
Tech:get("solar-panel-equipment"):setCost(50)

-- Module Technologies
for i,m in ipairs(modules) do
  -- Change cost of module 1 technologies from 50R+G@30s -> 10R+G@15s
  Tech:get(m):setCost(10):setTime(15)
  -- Change cost of module 2 technologies from 75R+G+B@30s -> 50R+G+B@30s
  Tech:get(m.."-2"):setCost(50)
  -- Change cost of module 3 technologies from 300R+G+B+P@60s -> 100R+G+B+P@60s
  Tech:get(m.."-3"):setCost(100)
end

-- Uranium processing. Reduce from 200R+G+B@30s -> 150R+G+B@30s
Tech:get("uranium-processing"):setCost(150)

-- Nuclear power. Reduce from 800R+G+B@30s -> 500R+G+B@30s
Tech:get("nuclear-power"):setCost(500)

-- Kovarex. Reduce from 1500R+G+B+P@30s -> 600R+G+B+P@30s
Tech:get("kovarex-enrichment-process"):setCost(600)

-- Rocket Control Unit. Reduce from 300R+G+B+Y@45s -> 200R+G+B+Y@45s
Tech:get("rocket-control-unit"):setCost(200)

-- Logistic system. Reduce from 500R+G+B+Y@30s -> 400R+G+B+Y@30s
Tech:get("logistic-system"):setCost(400)

-- Rocket silo. Reduce from 1000R+G+B+P+Y@60s -> 600R+G+B+P+Y@60s
Tech:get("rocket-silo"):setCost(600)

-- Space science pack (white science). Reduce from 2000R+G+B+P+Y@60s -> 1200R+G+B+P+Y@60s
Tech:get("space-science-pack"):setCost(1200)

-- Spidertron. Reduce from 2500R+G+B+M+P+Y@30s -> 2000R+G+B+M+P+Y@30s
Tech:get("spidertron"):setCost(2000)

-- Atomic bomb. Reduce from 5000R+G+B+M+P+Y@45s -> 4000R+G+B+M+P+Y@45s
Tech:get("atomic-bomb"):setCost(4000)

-- Technologies that give a bonus of some kind are reworked in their own file
require "bonus_technologies"

-- Explosives. Change from granting explosives -> granting explosives and cliff explosives
Tech:get("explosives"):setEffects({
  {type="unlock-recipe", recipe="explosives"},
  {type="unlock-recipe", recipe="cliff-explosives"}
})

-- Remove cliff explosives technology
Tech:get("cliff-explosives"):disable()

-- Remove combat robots
if Common.config "remove-combat-robots" then
  Tech:get("defender"):disable()
  Tech:get("distractor"):disable()
  Tech:get("destroyer"):disable()
end

-- Remove Discharge defense
if Common.config "remove-discharge-defense" then
  Tech:get("discharge-defense-equipment"):disable()
end

-- Remove beacons
if Common.config "remove-beacons" then
  -- remove technology
  Tech:get("effect-transmission"):disable()
  -- remove recipe
  Recipe:get("beacon"):disable()
end


--------------------
-- MODULE BALANCE --
--------------------
local function changeModuleEffect(name, effect)
  data.raw["module"][name].effect = effect
end
-- Reminder: beacons are disabled so, overall, all modules are buffed
-- They cost less, give more bonus and use less energy

-- Speed module. Original values:
-- * Mod1: energy +50%, speed +20%
-- * Mod2: energy +60%, speed +30%
-- * Mod3: energy +70%, speed +50%
-- New values:
-- * Mod1: energy +40%, speed +25%
-- * Mod2: energy +60%, speed +50%
-- * Mod3: energy +90%, speed +100%
changeModuleEffect("speed-module", {
  consumption = {bonus = 0.40},
  speed = {bonus = 0.25}
})
changeModuleEffect("speed-module-2", {
  consumption = {bonus = 0.60},
  speed = {bonus = 0.50}
})
changeModuleEffect("speed-module-3", {
  consumption = {bonus = 0.90},
  speed = {bonus = 1.00}
})

-- Efficiency module. Original values:
-- * Mod1: energy -30%
-- * Mod2: energy -40%
-- * Mod3: energy -50%
-- New values:
-- Let's make efficiency module 2 and 3 more useful
-- * Mod1: energy -30%
-- * Mod2: energy -60%
-- * Mod3: energy -120%
changeModuleEffect("effectivity-module", {
  consumption = {bonus = -0.30}
})
changeModuleEffect("effectivity-module-2", {
  consumption = {bonus = -0.60}
})
changeModuleEffect("effectivity-module-3", {
  consumption = {bonus = -1.20}
})

-- Productivity module. Original values:
-- * Mod1: energy +40%, pollution  +5%, speed  -5%, productivity  +4%
-- * Mod2: energy +60%, pollution  +7%, speed -10%, productivity  +6%
-- * Mod3: energy +80%, pollution +10%, speed -15%, productivity +10%
-- New values:
-- 1 point of productivity = 1 point of pollution, -1 point of speed, 6.25 points of energy
-- Note: productivity modules still bring a slight slow down
-- * Mod1: energy +25%, pollution  +4%, speed -4%, productivity  +4%
-- * Mod2: energy +50%, pollution  +8%, speed -8%, productivity  +8%
-- * Mod3: energy +75%, pollution +12%, speed -12%, productivity +12%
changeModuleEffect("productivity-module", {
  productivity = {bonus = 0.04},
  consumption = {bonus = 0.25},
  pollution = {bonus = 0.04},
  speed = {bonus = -0.04}
})
changeModuleEffect("productivity-module-2", {
  productivity = {bonus = 0.08},
  consumption = {bonus = 0.50},
  pollution = {bonus = 0.08},
  speed = {bonus = -0.08}
})
changeModuleEffect("productivity-module-3", {
  productivity = {bonus = 0.12},
  consumption = {bonus = 0.75},
  pollution = {bonus = 0.12},
  speed = {bonus = -0.12}
})
