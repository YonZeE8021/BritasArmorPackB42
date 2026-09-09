NV = NV or {}
NV.Sandbox = NV.Sandbox or {}

-- Brita pack default: night vision requires an installed, charged battery.
local DEFAULT_BATTERY_SYSTEM_ENABLED = true
local DEFAULT_BATTERY_DRAIN_MULTIPLIER = 1.0
local DEFAULT_ITEM_SPAWN_MULTIPLIER = 1.0
local DEFAULT_USE_LIGHT_CONE_IN_SINGLEPLAYER = true

local function getSandboxModule()
	local sandboxVars = rawget(_G, "SandboxVars")
	local moduleVars = sandboxVars and sandboxVars.NVFramework or nil
	if type(moduleVars) ~= "table" then
		return nil
	end
	return moduleVars
end

local function clampNumber(value, minimum, maximum, fallback)
	local number = tonumber(value)
	if not number then
		return fallback
	end
	if minimum ~= nil and number < minimum then
		number = minimum
	end
	if maximum ~= nil and number > maximum then
		number = maximum
	end
	return number
end

function NV.Sandbox.IsBatterySystemEnabled()
	local moduleVars = getSandboxModule()
	-- This integrated repair deliberately requires a battery.  Releases up to
	-- 1.3.2 wrote false into existing world settings, so trusting that stale
	-- value would silently restore unlimited night vision on old saves.
	if moduleVars and moduleVars.BatterySystemEnabled ~= true then
		moduleVars.BatterySystemEnabled = true
	end
	return DEFAULT_BATTERY_SYSTEM_ENABLED
end

function NV.Sandbox.GetBatteryDrainMultiplier()
	local moduleVars = getSandboxModule()
	return clampNumber(moduleVars and moduleVars.BatteryDrainMultiplier, 0.1, 100.0, DEFAULT_BATTERY_DRAIN_MULTIPLIER)
end

function NV.Sandbox.GetBatteryUseDelta(baseUseDelta)
	local useDelta = clampNumber(baseUseDelta, 0.0, nil, 0.0)
	if useDelta <= 0 then
		return 0
	end

	-- This option is a drain-speed multiplier: 2.0 consumes twice as much
	-- charge per game minute, while 0.5 consumes half as much.  Releases up
	-- to 1.4.1 divided here, which inverted the documented behaviour.
	return useDelta * NV.Sandbox.GetBatteryDrainMultiplier()
end

function NV.Sandbox.GetItemSpawnMultiplier()
	local moduleVars = getSandboxModule()
	return clampNumber(moduleVars and moduleVars.ItemSpawnMultiplier, 0.0, 100.0, DEFAULT_ITEM_SPAWN_MULTIPLIER)
end

function NV.Sandbox.UseLightConeInSingleplayer()
	local moduleVars = getSandboxModule()
	local value = moduleVars and moduleVars.UseLightConeInSingleplayer
	if value == nil then
		return DEFAULT_USE_LIGHT_CONE_IN_SINGLEPLAYER
	end
	return value == true
end
