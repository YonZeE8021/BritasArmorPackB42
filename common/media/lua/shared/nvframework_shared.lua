NV = NV or {}
NV.Core = NV.Core or {}
NV.Shared = NV.Shared or {}

NV.Shared.ACTIVE_MODDATA_KEY = "nvActive"
NV.Shared.REGISTERED_NIGHT_VISION_ITEMS = NV.Shared.REGISTERED_NIGHT_VISION_ITEMS or {}

if not NV.DebugPrint then
	function NV.DebugPrint(_)
	end
end

local function hasMethod(value, methodName)
	return value ~= nil and type(value[methodName]) == "function"
end

local function getWearableLocation(item)
	if hasMethod(item, "getBodyLocation") then
		local bodyLocation = item:getBodyLocation()
		if bodyLocation and bodyLocation ~= "" then
			return bodyLocation
		end
	end

	if hasMethod(item, "canBeEquipped") then
		local equipLocation = item:canBeEquipped()
		if equipLocation and equipLocation ~= "" then
			return equipLocation
		end
	end

	return nil
end

local function getItemModuleName(item)
	if not hasMethod(item, "getFullType") then return "Base" end

	local fullType = item:getFullType()
	if not fullType then return "Base" end

	local dotIndex = string.find(fullType, ".", 1, true)
	if not dotIndex then return "Base" end

	return string.sub(fullType, 1, dotIndex - 1)
end

local function getItemFullType(item)
	if not item or not hasMethod(item, "getFullType") then return nil end
	return item:getFullType()
end

local NAMED_STATE_TOKENS = {
	ON = { active = true, opposite = "OFF" },
	OFF = { active = false, opposite = "ON" },
	DOWN = { active = true, opposite = "UP" },
	UP = { active = false, opposite = "DOWN" },
}

local ACTIVE_STATE_TOKEN_FILTER = {
	ON = true,
	DOWN = true,
}

local INACTIVE_STATE_TOKEN_FILTER = {
	OFF = true,
	UP = true,
}

local LEGACY_NV_IDENTITY_TOKEN_FILTER = {
	ON = true,
	OFF = true,
}

local LEGACY_NV_DIRECTIONAL_TOKEN_FILTER = {
	DOWN = true,
	UP = true,
}

local LEGACY_NV_DIRECTIONAL_MARKERS = {
	"NVG",
	"GPNVG",
	"PNV",
	"PVS",
	"NIGHTVISION",
	"NIGHT_VISION",
	"NIGHT-VISION",
}

local STATE_TOKEN_SCAN_ORDER = { "ON", "OFF", "DOWN", "UP" }
local SCRIPT_NIGHT_VISION_FIELD = "NightVision"
local SCRIPT_NIGHT_VISION_CACHE = {}

local function clearScriptNightVisionCache()
	for key in pairs(SCRIPT_NIGHT_VISION_CACHE) do
		SCRIPT_NIGHT_VISION_CACHE[key] = nil
	end

	return true
end

local function trimScriptValue(value)
	if value == nil then
		return nil
	end

	return (tostring(value):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function isStateTokenBoundary(itemType, startIndex, endIndex)
	local prevIndex = startIndex - 1
	if prevIndex >= 1 then
		local prevChar = itemType:sub(prevIndex, prevIndex)
		if prevChar ~= "_" and prevChar ~= "-" then
			return false
		end
	end

	local nextIndex = endIndex + 1
	if nextIndex <= #itemType then
		local nextChar = itemType:sub(nextIndex, nextIndex)
		if nextChar ~= "_" and nextChar ~= "-" then
			return false
		end
	end

	return true
end

local function findNamedStateToken(itemType, tokenFilter)
	if not itemType or itemType == "" then return nil end

	local bestMatch = nil

	for _, token in ipairs(STATE_TOKEN_SCAN_ORDER) do
		if not tokenFilter or tokenFilter[token] then
			local searchIndex = 1
			while true do
				local startIndex, endIndex = itemType:find(token, searchIndex, true)
				if not startIndex then break end

				if isStateTokenBoundary(itemType, startIndex, endIndex) then
					local stateInfo = NAMED_STATE_TOKENS[token]
					if not bestMatch or startIndex > bestMatch.startIndex then
						bestMatch = {
							token = token,
							startIndex = startIndex,
							endIndex = endIndex,
							active = stateInfo.active,
							opposite = stateInfo.opposite,
						}
					end
				end

				searchIndex = startIndex + 1
			end
		end
	end

	return bestMatch
end

local function replaceNamedStateToken(itemType, tokenInfo, replacementToken)
	if not itemType or not tokenInfo or not replacementToken then return itemType end

	return itemType:sub(1, tokenInfo.startIndex - 1)
		.. replacementToken
		.. itemType:sub(tokenInfo.endIndex + 1)
end

local function isWearableItem(item)
	if getWearableLocation(item) then
		return true
	end

	if hasMethod(item, "IsClothing") and item:IsClothing() then
		return true
	end

	if hasMethod(item, "getClothingItem") and item:getClothingItem() then
		return true
	end

	if hasMethod(item, "getCategory") and item:getCategory() == "Clothing" then
		return true
	end

	return hasMethod(item, "hasTag") and item:hasTag(ItemTag.WEARABLE)
end

local function hasLegacyNVDirectionalIdentityMarker(itemType)
	if not itemType or itemType == "" then return false end

	local upperItemType = string.upper(itemType)
	for _, marker in ipairs(LEGACY_NV_DIRECTIONAL_MARKERS) do
		if upperItemType:find(marker, 1, true) then
			return true
		end
	end

	return false
end

local function getScriptNightVisionFlag(item)
	if not item or not hasMethod(item, "getScriptItem") then
		return nil
	end

	local scriptItem = item:getScriptItem()
	if not scriptItem or not scriptItem.getScriptLines then
		return nil
	end

	local cacheKey = nil
	if scriptItem.getFullName then
		cacheKey = scriptItem:getFullName()
	elseif hasMethod(item, "getFullType") then
		cacheKey = item:getFullType()
	end

	if cacheKey and SCRIPT_NIGHT_VISION_CACHE[cacheKey] ~= nil then
		return SCRIPT_NIGHT_VISION_CACHE[cacheKey]
	end

	local lines = scriptItem:getScriptLines()
	local value = nil
	if lines and lines.size and lines.get then
		local pattern = "^%s*" .. SCRIPT_NIGHT_VISION_FIELD .. "%s*=%s*(.-)%s*,?%s*$"
		for index = 0, lines:size() - 1 do
			local rawValue = string.match(tostring(lines:get(index)), pattern)
			if rawValue ~= nil then
				local normalizedValue = trimScriptValue(rawValue)
				if normalizedValue then
					normalizedValue = string.lower(normalizedValue)
					if normalizedValue == "true" then
						value = true
					elseif normalizedValue == "false" then
						value = false
					end
				end
				break
			end
		end
	end

	if cacheKey then
		SCRIPT_NIGHT_VISION_CACHE[cacheKey] = value
	end

	return value
end

local function hasRegisteredNightVisionIdentity(item)
	local fullType = getItemFullType(item)
	if not fullType then
		return false
	end

	return NV.Shared.REGISTERED_NIGHT_VISION_ITEMS[fullType] == true
end

function NV.Shared.HasNightVisionIdentity(item)
	if not item then return false end
	if not NV.Shared.IsEmbeddedNightVisionEnabled() then return false end

	if hasRegisteredNightVisionIdentity(item) then
		return true
	end

	-- Night Vision Chucked's B42 update owns separate devices and battery data.
	-- Do not infer ownership from a generic NVITEM tag for one of its devices.
	-- Query both the registry and typed tags so server/load-order differences
	-- do not briefly enable two battery systems on the same third-party item.
	if NV.Shared.IsChuckedDevice(item) then return false end

	if getScriptNightVisionFlag(item) == true then
		return true
	end

	return hasMethod(item, "hasTag") and item:hasTag(ItemTag.NVITEM)
end

function NV.Shared.ClearScriptNightVisionCache()
	return clearScriptNightVisionCache()
end

function NV.Shared.RegisterNightVisionItem(fullType)
	if not fullType or fullType == "" then
		return false
	end

	NV.Shared.REGISTERED_NIGHT_VISION_ITEMS[fullType] = true
	return true
end

local function copyModData(sourceItem, targetItem)
	local sourceModData = sourceItem and sourceItem.getModData and sourceItem:getModData() or nil
	local targetModData = targetItem and targetItem.getModData and targetItem:getModData() or nil
	if not sourceModData or not targetModData then return end

	for key, value in pairs(sourceModData) do
		targetModData[key] = value
	end
end

function NV.Shared.IsEmbeddedNightVisionEnabled()
	local settings = SandboxVars and SandboxVars.BritasArmorPackB42
	return not (settings and settings.EnableNightVision == false)
end

function NV.Shared.IsChuckedDevice(item)
	local fullType = getItemFullType(item)
	if not fullType then return false end
	local registered = rawget(_G, "appliedNVGChuckedTypes")
	if type(registered) == "table" and registered[fullType] then return true end
	local tags = rawget(_G, "NIGHTVISION_CHUCKED_TAGS")
	if type(tags) == "table" and hasMethod(item, "hasTag") then
		return (tags.NVG ~= nil and item:hasTag(tags.NVG))
			or (tags.BATTERY ~= nil and item:hasTag(tags.BATTERY)) or false
	end
	return false
end

-- Preserve the complete wearable-item state whenever NV swaps or refreshes an
-- item instance.  Recreating only condition/favorite/modData reset blood,
-- dirt, wetness, holes, patches, tint and texture choice in releases <= 1.4.1.
-- Prefer the game's own B42 clothing-copy routine so this stays aligned with
-- vanilla ClothingItemExtra transformations.
function NV.Shared.CopyItemState(sourceItem, targetItem)
	if not sourceItem or not targetItem then return targetItem end

	pcall(require, "TimedActions/ISClothingExtraAction")
	if ISClothingExtraAction and ISClothingExtraAction.createItemNew then
		local ok = pcall(
			ISClothingExtraAction.createItemNew,
			ISClothingExtraAction,
			sourceItem,
			targetItem
		)
		if ok then return targetItem end
	end

	-- Conservative fallback for environments where the vanilla helper is not
	-- available yet (for example, early dedicated-server bootstrap).
	if hasMethod(sourceItem, "getCondition") and hasMethod(targetItem, "setCondition") then
		targetItem:setCondition(sourceItem:getCondition())
	end
	if hasMethod(sourceItem, "isFavorite") and hasMethod(targetItem, "setFavorite") then
		targetItem:setFavorite(sourceItem:isFavorite())
	end
	if hasMethod(sourceItem, "getColor") and hasMethod(targetItem, "setColor") then
		targetItem:setColor(sourceItem:getColor())
	end
	if hasMethod(sourceItem, "getWetness") and hasMethod(targetItem, "setWetness") then
		targetItem:setWetness(sourceItem:getWetness())
	end
	if hasMethod(sourceItem, "getName") and hasMethod(targetItem, "setName") and hasMethod(sourceItem, "getScriptItem") then
		local scriptItem = sourceItem:getScriptItem()
		if scriptItem and sourceItem:getName() ~= scriptItem:getDisplayName() then
			targetItem:setName(sourceItem:getName())
		end
	end
	copyModData(sourceItem, targetItem)
	return targetItem
end

local function syncItemStats(item)
	if isServer() and item and sendItemStats then
		sendItemStats(item)
	end
end

local function syncInventoryRemoval(inventory, item)
	if inventory and item and sendRemoveItemFromContainer then
		sendRemoveItemFromContainer(inventory, item)
	end
end

local function syncInventoryAddition(inventory, item)
	if inventory and item and sendAddItemToContainer then
		sendAddItemToContainer(inventory, item)
	end
end

local function syncClothingState(player, bodyLocation, item)
	if isServer() then
		if bodyLocation and item and sendClothing then
			sendClothing(player, bodyLocation, item)
		end
		if syncVisuals then
			syncVisuals(player)
		end
	end

	if triggerEvent then
		triggerEvent("OnClothingUpdated", player)
	end
end

local function isMultiplayerClient()
	return isClient() and isMultiplayer()
end

local function addPlayerIdentity(player, args)
	args = args or {}
	if player and hasMethod(player, "getPlayerNum") then
		args.playerNum = player:getPlayerNum()
	end
	if player and hasMethod(player, "getOnlineID") then
		args.onlineID = player:getOnlineID()
	end
	return args
end

function NV.Shared.IsNVTaggedItem(item)
	if not item or not hasMethod(item, "getType") then return false end
	if not isWearableItem(item) then return false end
	if not NV.Shared.HasNightVisionIdentity(item) then return false end

	local itemType = item:getType()
	if findNamedStateToken(itemType, LEGACY_NV_IDENTITY_TOKEN_FILTER) ~= nil then
		return true
	end

	-- Directional _DOWN/_UP support remains available for legacy NV naming schemes,
	-- but only when the item type itself carries an NV-specific marker.
	return findNamedStateToken(itemType, LEGACY_NV_DIRECTIONAL_TOKEN_FILTER) ~= nil
		and hasLegacyNVDirectionalIdentityMarker(itemType)
end

function NV.Shared.IsWearableItem(item)
	return isWearableItem(item)
end

function NV.IsNVBatteryHostItem(item)
	if not item or not hasMethod(item, "getModData") then return false end
	if not NV.Shared.IsNVTaggedItem(item) then return false end
	return NV.Shared.IsWearableItem(item)
end

function NV.GetWornNVItem(player)
	if not player then return nil end

	local wornItems = player:getWornItems()
	if not wornItems then return nil end

	for index = 0, wornItems:size() - 1 do
		local wornItem = wornItems:get(index)
		local item = wornItem and wornItem.getItem and wornItem:getItem() or nil
		if NV.Shared.IsNVTaggedItem(item) then
			return item
		end
	end

	return nil
end

NV.Core.GetWornNVItem = NV.GetWornNVItem

function NV.IsNVItemActive(item)
	if not item or not hasMethod(item, "getType") then return false end
	if not NV.Shared.IsNVTaggedItem(item) then return false end

	local itemType = item:getType()
	local namedState = findNamedStateToken(itemType)
	if namedState then
		return namedState.active
	end

	if not hasMethod(item, "getModData") then return false end
	return item:getModData()[NV.Shared.ACTIVE_MODDATA_KEY] == true
end

function NV.Shared.SetItemActiveState(item, enable)
	if not item or not hasMethod(item, "getModData") then return false end

	local modData = item:getModData()
	local active = enable == true
	if modData[NV.Shared.ACTIVE_MODDATA_KEY] == active then return false end

	modData[NV.Shared.ACTIVE_MODDATA_KEY] = active
	syncItemStats(item)
	return true
end

function NV.Shared.GetSwapTargetFullType(item, enable)
	if not item or not hasMethod(item, "getType") then return nil end
	if not NV.Shared.IsNVTaggedItem(item) then return nil end

	local itemType = item:getType()
	if not itemType then return nil end

	local tokenInfo = nil
	if enable then
		tokenInfo = findNamedStateToken(itemType, INACTIVE_STATE_TOKEN_FILTER)
	else
		tokenInfo = findNamedStateToken(itemType, ACTIVE_STATE_TOKEN_FILTER)
	end

	if not tokenInfo then return nil end

	local targetType = replaceNamedStateToken(itemType, tokenInfo, tokenInfo.opposite)
	if targetType == itemType then return nil end
	return getItemModuleName(item) .. "." .. targetType
end

function NV.Shared.SyncLocalNightVisionState(player, enable, playSound)
	if not player then return false end

	if isMultiplayerClient() then
		return false
	end

	if isServer() then
		if sendServerCommand then
			sendServerCommand(player, "NVFramework", "SetLocalNightVision", addPlayerIdentity(player, {
				active = enable == true,
				playSound = playSound ~= false,
			}))
			return true
		end
		return false
	end

	if NV.ApplyLocalNightVisionState then
		return NV.ApplyLocalNightVisionState(player, enable == true, {
			playSound = playSound ~= false,
			force = true,
		})
	end

	return false
end

function NV.Shared.RequestInventoryRefresh(player)
	if not player then return false end

	local inventory = player.getInventory and player:getInventory() or nil
	if inventory and inventory.setDrawDirty then
		inventory:setDrawDirty(true)
	end

	if isServer() then
		if sendServerCommand then
			sendServerCommand(player, "NVFramework", "RefreshInventoryUI", addPlayerIdentity(player, {}))
			return true
		end
		return false
	end

	if NV.RefreshInventoryViews then
		return NV.RefreshInventoryViews(player)
	end

	return false
end

function NV.Shared.SyncLocalBatteryCharge(player, item, charge)
	if not player then return false end

	local itemId = item and item.getID and item:getID() or nil
	local args = addPlayerIdentity(player, {
		itemId = itemId,
		installed = charge ~= nil,
		charge = charge or 0,
	})

	if isServer() then
		if sendServerCommand then
			sendServerCommand(player, "NVFramework", "SyncBatteryCharge", args)
			return true
		end
		return false
	end

	if NV.ApplyLocalBatteryCharge then
		return NV.ApplyLocalBatteryCharge(player, args)
	end

	return false
end

function NV.Shared.SyncLocalItemActiveState(player, item, enable)
	if not player then return false end

	local itemId = item and item.getID and item:getID() or nil
	local args = addPlayerIdentity(player, {
		itemId = itemId,
		active = enable == true,
	})

	if isServer() then
		if sendServerCommand then
			sendServerCommand(player, "NVFramework", "SyncNVItemActiveState", args)
			return true
		end
		return false
	end

	if NV.ApplyLocalItemActiveState then
		return NV.ApplyLocalItemActiveState(player, args)
	end

	return false
end

function NV.SwapNVModel(player, enable)
	if not player then return nil end

	local nvItem = NV.GetWornNVItem(player)
	if not nvItem then return nil end

	local targetFullType = NV.Shared.GetSwapTargetFullType(nvItem, enable == true)
	if not targetFullType then
		NV.Shared.SetItemActiveState(nvItem, enable)
		return nvItem
	end

	local newItem = instanceItem(targetFullType)
	if not newItem then
		NV.DebugPrint("Failed to create swapped NV item: " .. tostring(targetFullType))
		return nil
	end

	NV.Shared.CopyItemState(nvItem, newItem)
	newItem:getModData()[NV.Shared.ACTIVE_MODDATA_KEY] = enable == true

	local inventory = player:getInventory()
	local bodyLocation = getWearableLocation(nvItem)

	if hasMethod(player, "removeWornItem") then
		player:removeWornItem(nvItem, false)
	end
	inventory:Remove(nvItem)
	syncInventoryRemoval(inventory, nvItem)

	inventory:AddItem(newItem)
	syncInventoryAddition(inventory, newItem)
	syncItemStats(newItem)

	if bodyLocation then
		player:setWornItem(bodyLocation, newItem)
	end
	syncClothingState(player, bodyLocation, newItem)

	return newItem
end

function NV.SetPlayerNightVisionState(player, enable, options)
	options = options or {}
	if not player then return false end
	if isMultiplayerClient() then return false end

	local nvItem = NV.GetWornNVItem(player)
	if not nvItem then
		if options.syncLocal ~= false then
			NV.Shared.SyncLocalNightVisionState(player, false, options.playSound)
		end
		return enable ~= true
	end

	if enable and NV.Battery and NV.Battery.HasBattery and not NV.Battery.HasBattery(player) then
		if options.syncLocal ~= false then
			NV.Shared.SyncLocalNightVisionState(player, false, false)
		end
		return false
	end

	local swapTargetFullType = NV.Shared.GetSwapTargetFullType and NV.Shared.GetSwapTargetFullType(nvItem, enable) or nil
	local changedItem = NV.SwapNVModel(player, enable)
	if not changedItem then return false end
	if not swapTargetFullType and NV.Shared and NV.Shared.SyncLocalItemActiveState then
		NV.Shared.SyncLocalItemActiveState(player, changedItem, enable)
	end

	if options.syncLocal ~= false then
		NV.Shared.SyncLocalNightVisionState(player, enable, options.playSound)
	end

	return true
end
