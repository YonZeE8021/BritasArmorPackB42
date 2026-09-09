require "TimedActions/ISBaseTimedAction"
require "NVFramework_Shared"
require "NVFramework_BatteryState"

local function resolveInventoryItem(character, itemId, fallback)
    if not character then return fallback end

    local inventory = character:getInventory()
    if not inventory then return fallback end

    if fallback and inventory:contains(fallback) then
        return fallback
    end

    if itemId and inventory.getItemById then
        local resolved = inventory:getItemById(itemId)
        if resolved then
            return resolved
        end
    end

    if itemId and inventory.getItemWithID then
        local resolved = inventory:getItemWithID(itemId)
        if resolved then
            return resolved
        end
    end

    return fallback
end

local function resolveHandModel(item)
    if not item then return nil end

    local fullType = item.getFullType and item:getFullType() or nil
    if fullType == "Base.Hat_NightVision_NV_ON" then
        return "NVFramework.Hat_NightVision_NV_Ground"
    end
    if fullType == "Base.Hat_NightVision_NV_OFF" then
        return "NVFramework.Hat_NightVision_NV_OFF_Ground"
    end

    if item.getStaticModel then
        local staticModel = item:getStaticModel()
        if staticModel and staticModel ~= "" then
            return staticModel
        end
    end

    if fullType and fullType ~= "" and getItemStaticModel then
        local staticModel = getItemStaticModel(fullType)
        if staticModel and staticModel ~= "" then
            return staticModel
        end
    end

    return nil
end

local function inventoryContainsItem(character, item, itemId)
    if not character then return false end

    local inventory = character:getInventory()
    if not inventory then return false end

    if isClient() and itemId and inventory.containsID then
        return inventory:containsID(itemId)
    end

    local resolved = resolveInventoryItem(character, itemId, item)
    return resolved ~= nil and inventory:contains(resolved)
end

local function syncItemStats(item)
    if isServer() and item and sendItemStats then
        sendItemStats(item)
    end
end

local function copyItemState(sourceItem, targetItem)
    if not sourceItem or not targetItem then return end

    if NV.Shared and NV.Shared.CopyItemState then
        local ok = pcall(NV.Shared.CopyItemState, sourceItem, targetItem)
        if ok then return end
    end

    if sourceItem.getCondition and targetItem.setCondition then
        targetItem:setCondition(sourceItem:getCondition())
    end

    if sourceItem.isFavorite and targetItem.setFavorite then
        targetItem:setFavorite(sourceItem:isFavorite())
    end

    if sourceItem.getName and targetItem.setName and sourceItem.getScriptItem then
        local scriptItem = sourceItem:getScriptItem()
        if scriptItem and sourceItem:getName() ~= scriptItem:getDisplayName() then
            targetItem:setName(sourceItem:getName())
        end
    end

    local sourceModData = sourceItem.getModData and sourceItem:getModData() or nil
    local targetModData = targetItem.getModData and targetItem:getModData() or nil
    if sourceModData and targetModData then
        for key, value in pairs(sourceModData) do
            targetModData[key] = value
        end
    end
end

local function replaceInventoryItem(character, item, updateClone)
    if not character or not item then return nil end

    local inventory = character:getInventory()
    if not inventory then return nil end

    local fullType = item.getFullType and item:getFullType() or nil
    if not fullType or fullType == "" then return nil end

    local clonedItem = instanceItem(fullType)
    if not clonedItem then return nil end

    copyItemState(item, clonedItem)

    if updateClone then
        updateClone(clonedItem)
    end

    inventory:Remove(item)
    if sendRemoveItemFromContainer then
        sendRemoveItemFromContainer(inventory, item)
    end

    inventory:AddItem(clonedItem)
    if sendAddItemToContainer then
        sendAddItemToContainer(inventory, clonedItem)
    end
    syncItemStats(clonedItem)

    if inventory.setDrawDirty then
        inventory:setDrawDirty(true)
    end

    return clonedItem
end

-- ISNVInsertBattery
-- Timed action: install a Base.Battery into an NVITEM.
-- Animation: Disassemble (~100 ticks), screwdriver in primary hand, NV item in secondary hand.

ISNVInsertBattery = ISBaseTimedAction:derive("ISNVInsertBattery")

function ISNVInsertBattery:isValid()
    self.nvItem = resolveInventoryItem(self.character, self.nvItemId, self.nvItem)
    self.battery = resolveInventoryItem(self.character, self.batteryId, self.battery)

    if NV.Battery and NV.Battery.IsSystemEnabled and not NV.Battery.IsSystemEnabled() then return false end
    if not NV.IsNVBatteryHostItem or not NV.IsNVBatteryHostItem(self.nvItem) then return false end
    if not inventoryContainsItem(self.character, self.nvItem, self.nvItemId) then return false end
    if self.nvItem:getModData()[NV.Battery.MODDATA_KEY] ~= nil then return false end
    if not inventoryContainsItem(self.character, self.battery, self.batteryId) then return false end
    return true
end

function ISNVInsertBattery:update()
    self.character:setMetabolicTarget(Metabolics.LightDomestic)
end

function ISNVInsertBattery:start()
    if isClient() then
        self.nvItem = resolveInventoryItem(self.character, self.nvItemId, self.nvItem)
        self.battery = resolveInventoryItem(self.character, self.batteryId, self.battery)
    end
    self:setActionAnim(CharacterActionAnims.Disassemble)
    self:setOverrideHandModelsString("Screwdriver", resolveHandModel(self.nvItem))
end

function ISNVInsertBattery:stop()
    ISBaseTimedAction.stop(self)
end

function ISNVInsertBattery:perform()
    ISBaseTimedAction.perform(self)
end

function ISNVInsertBattery:complete()
    self.nvItem = resolveInventoryItem(self.character, self.nvItemId, self.nvItem)
    self.battery = resolveInventoryItem(self.character, self.batteryId, self.battery)

    if NV.Battery and NV.Battery.IsSystemEnabled and not NV.Battery.IsSystemEnabled() then return false end
    if not NV.IsNVBatteryHostItem or not NV.IsNVBatteryHostItem(self.nvItem) then return false end
    if not self.battery then return false end

    local inventory = self.character:getInventory()
    local charge = self.battery:getCurrentUsesFloat()
    inventory:Remove(self.battery)
    sendRemoveItemFromContainer(inventory, self.battery)

    self.nvItem = replaceInventoryItem(self.character, self.nvItem, function(clonedItem)
        clonedItem:getModData()[NV.Battery.MODDATA_KEY] = charge
    end) or self.nvItem

    if self.nvItem:getModData()[NV.Battery.MODDATA_KEY] ~= charge then
        self.nvItem:getModData()[NV.Battery.MODDATA_KEY] = charge
        syncItemStats(self.nvItem)
    end

    if inventory.setDrawDirty then
        inventory:setDrawDirty(true)
    end
    if NV.Shared and NV.Shared.RequestInventoryRefresh then
        NV.Shared.RequestInventoryRefresh(self.character)
    end
    return true
end

function ISNVInsertBattery:getDuration()
    if self.character:isTimedActionInstant() then return 1 end
    return 100
end

function ISNVInsertBattery:new(character, nvItem, battery)
    local o = ISBaseTimedAction.new(self, character)
    o.nvItem    = nvItem
    o.nvItemId  = nvItem and nvItem.getID and nvItem:getID() or nil
    o.battery   = battery
    o.batteryId = battery and battery.getID and battery:getID() or nil
    o.maxTime   = o:getDuration()
    return o
end


-- ISNVRemoveBattery
-- Timed action: remove the installed battery from an NVITEM.
-- Animation: Disassemble (~100 ticks), screwdriver in primary hand, NV item in secondary hand.
-- Returns a partially-charged battery to the player's inventory.
-- A dead battery (charge <= 1 %) is discarded.

ISNVRemoveBattery = ISBaseTimedAction:derive("ISNVRemoveBattery")

local DEAD_THRESHOLD = 0.01

function ISNVRemoveBattery:isValid()
    self.nvItem = resolveInventoryItem(self.character, self.nvItemId, self.nvItem)

    if NV.Battery and NV.Battery.IsSystemEnabled and not NV.Battery.IsSystemEnabled() then return false end
    if not NV.IsNVBatteryHostItem or not NV.IsNVBatteryHostItem(self.nvItem) then return false end
    if not inventoryContainsItem(self.character, self.nvItem, self.nvItemId) then return false end
    if self.nvItem:getModData()[NV.Battery.MODDATA_KEY] == nil then return false end
    return true
end

function ISNVRemoveBattery:update()
    self.character:setMetabolicTarget(Metabolics.LightDomestic)
end

function ISNVRemoveBattery:start()
    if isClient() then
        self.nvItem = resolveInventoryItem(self.character, self.nvItemId, self.nvItem)
    end
    self:setActionAnim(CharacterActionAnims.Disassemble)
    self:setOverrideHandModelsString("Screwdriver", resolveHandModel(self.nvItem))
end

function ISNVRemoveBattery:stop()
    ISBaseTimedAction.stop(self)
end

function ISNVRemoveBattery:perform()
    ISBaseTimedAction.perform(self)
end

function ISNVRemoveBattery:complete()
    self.nvItem = resolveInventoryItem(self.character, self.nvItemId, self.nvItem)

    if NV.Battery and NV.Battery.IsSystemEnabled and not NV.Battery.IsSystemEnabled() then return false end
    if not NV.IsNVBatteryHostItem or not NV.IsNVBatteryHostItem(self.nvItem) then return false end

    local inventory = self.character:getInventory()
    local charge = self.nvItem:getModData()[NV.Battery.MODDATA_KEY]
    local wasActive = NV.IsNVItemActive and NV.IsNVItemActive(self.nvItem)

    self.nvItem = replaceInventoryItem(self.character, self.nvItem, function(clonedItem)
        clonedItem:getModData()[NV.Battery.MODDATA_KEY] = nil
    end) or self.nvItem

    if self.nvItem:getModData()[NV.Battery.MODDATA_KEY] ~= nil then
        self.nvItem:getModData()[NV.Battery.MODDATA_KEY] = nil
        syncItemStats(self.nvItem)
    end

    if wasActive and NV.SetPlayerNightVisionState then
        NV.SetPlayerNightVisionState(self.character, false, {
            playSound = true,
            syncLocal = true,
        })
    end

    if charge and charge > DEAD_THRESHOLD then
        local newBat = instanceItem("Base.Battery")
        if newBat then
            newBat:setUsedDelta(charge)
            inventory:AddItem(newBat)
            sendAddItemToContainer(inventory, newBat)
            syncItemStats(newBat)
        end
    end

    if inventory.setDrawDirty then
        inventory:setDrawDirty(true)
    end
    if NV.Shared and NV.Shared.RequestInventoryRefresh then
        NV.Shared.RequestInventoryRefresh(self.character)
    end

    return true
end

function ISNVRemoveBattery:getDuration()
    if self.character:isTimedActionInstant() then return 1 end
    return 100
end

function ISNVRemoveBattery:new(character, nvItem)
    local o = ISBaseTimedAction.new(self, character)
    o.nvItem    = nvItem
    o.nvItemId  = nvItem and nvItem.getID and nvItem:getID() or nil
    o.maxTime   = o:getDuration()
    return o
end
