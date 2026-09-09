require "NVFramework_Shared"
require "NVFramework_Sandbox"

NV = NV or {}
NV.Battery = NV.Battery or {}

if NV.Battery._sharedInitialized then
	return
end
NV.Battery._sharedInitialized = true

NV.Battery.MODDATA_KEY = NV.Battery.MODDATA_KEY or "nvBatteryCharge"
-- One full battery lasts 720 game minutes (12 in-game hours) at 1.0x.
NV.Battery.USE_DELTA = NV.Battery.USE_DELTA or (1.0 / 720)
NV.Battery.LOW_BATTERY_THRESHOLD = NV.Battery.LOW_BATTERY_THRESHOLD or 0.20
NV.Battery.DEAD_THRESHOLD = NV.Battery.DEAD_THRESHOLD or 0.01

function NV.Battery.IsSystemEnabled()
	return not (NV.Sandbox and NV.Sandbox.IsBatterySystemEnabled) or NV.Sandbox.IsBatterySystemEnabled()
end

local function syncBatteryItem(item)
	if isServer() and item and sendItemStats then
		sendItemStats(item)
	end
end

function NV.Battery.GetCharge(player)
	if not NV.GetWornNVItem then return nil end
	return NV.Battery.GetChargeFromItem(NV.GetWornNVItem(player))
end

function NV.Battery.HasBattery(player)
	if not NV.Battery.IsSystemEnabled() then
		return true
	end
	local charge = NV.Battery.GetCharge(player)
	return charge ~= nil and charge > 0
end

function NV.Battery.GetChargeFromItem(nvItem)
	if not nvItem then return nil end
	if NV.IsNVBatteryHostItem and not NV.IsNVBatteryHostItem(nvItem) then return nil end
	return nvItem:getModData()[NV.Battery.MODDATA_KEY]
end

local function drainPlayerBattery(player)
	if not player then return end
	if not NV.Battery.IsSystemEnabled() then return end

	local nvItem = NV.GetWornNVItem and NV.GetWornNVItem(player) or nil
	if not nvItem or (NV.IsNVBatteryHostItem and not NV.IsNVBatteryHostItem(nvItem)) then
		return
	end
	if not NV.IsNVItemActive or not NV.IsNVItemActive(nvItem) then
		return
	end

	local modData = nvItem:getModData()
	local charge = modData[NV.Battery.MODDATA_KEY]
	if charge == nil then
		NV.SetPlayerNightVisionState(player, false, { playSound = true })
		return
	end

	local useDelta = (NV.Sandbox and NV.Sandbox.GetBatteryUseDelta and NV.Sandbox.GetBatteryUseDelta(NV.Battery.USE_DELTA)) or NV.Battery.USE_DELTA
	charge = charge - useDelta
	if charge < 0 then charge = 0 end
	modData[NV.Battery.MODDATA_KEY] = charge
	syncBatteryItem(nvItem)
	if NV.Shared and NV.Shared.SyncLocalBatteryCharge then
		NV.Shared.SyncLocalBatteryCharge(player, nvItem, charge)
	end

	if charge <= 0 then
		NV.SetPlayerNightVisionState(player, false, { playSound = true })
	end
end

local function forEachDrainPlayer(callback)
	if isServer() then
		local players = getOnlinePlayers and getOnlinePlayers() or nil
		if not players then return end

		for index = 0, players:size() - 1 do
			local player = players:get(index)
			if player then
				callback(player)
			end
		end
		return
	end

	-- Single-player local co-op can have up to four active IsoPlayers.  The
	-- old player-0-only path let every additional split-screen player run NV
	-- forever.  Drain each active local player's worn NV item independently.
	local playerCount = getNumActivePlayers and getNumActivePlayers() or 0
	if playerCount > 0 and getSpecificPlayer then
		for index = 0, playerCount - 1 do
			local player = getSpecificPlayer(index)
			if player then
				callback(player)
			end
		end
		return
	end

	local player = getPlayer and getPlayer() or nil
	if player then callback(player) end
end

local function shouldRunBatteryAuthority()
	return not isClient() or isServer()
end

local function onMinutePassed()
	if not shouldRunBatteryAuthority() then return end
	forEachDrainPlayer(drainPlayerBattery)
end

if shouldRunBatteryAuthority() and Events and Events.EveryOneMinute and not NV.Battery._drainHookAdded then
	Events.EveryOneMinute.Add(onMinutePassed)
	NV.Battery._drainHookAdded = true
end

print("[NV] Battery state loaded")
