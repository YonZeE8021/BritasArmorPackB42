-- Built-in NVFramework compatibility for Brita's Armor Pack.
-- Registers Brita NV item identities and migrates legacy item IDs to *_ON.

BritaArmorNV = BritaArmorNV or {}

BritaArmorNV.LEGACY_TO_ON = {
    ["Base.Hat_Sam_NV"] = "Base.Hat_Sam_NV_ON",
    ["Base.NV_PVS5"] = "Base.NV_PVS5_ON",
    ["Base.NV_PNV_57"] = "Base.NV_PNV_57_ON",
    ["Base.NV_PVS7"] = "Base.NV_PVS7_ON",
    ["Base.NV_PVS21"] = "Base.NV_PVS21_ON",
    ["Base.NV_GPNVG_18"] = "Base.NV_GPNVG_18_ON",
}

BritaArmorNV.ALL_TYPES = {
    "Base.Hat_Sam_NV_ON",
    "Base.Hat_Sam_NV_OFF",
    "Base.Hat_PVS15_ON",
    "Base.Hat_PVS15_OFF",
    "Base.Hat_PVS15_Harness_ON",
    "Base.Hat_PVS15_Harness_OFF",
    "Base.Hat_NV18_ON",
    "Base.Hat_NV18_OFF",
    "Base.Hat_NV18_Harness_ON",
    "Base.Hat_NV18_Harness_OFF",
    "Base.NV_PVS5_ON",
    "Base.NV_PVS5_OFF",
    "Base.NV_PNV_57_ON",
    "Base.NV_PNV_57_OFF",
    "Base.NV_PVS7_ON",
    "Base.NV_PVS7_OFF",
    "Base.NV_PVS21_ON",
    "Base.NV_PVS21_OFF",
    "Base.NV_GPNVG_18_ON",
    "Base.NV_GPNVG_18_OFF",
}

local ALL_TYPE_SET = {}
for i = 1, #BritaArmorNV.ALL_TYPES do
    ALL_TYPE_SET[BritaArmorNV.ALL_TYPES[i]] = true
end
for oldType, _ in pairs(BritaArmorNV.LEGACY_TO_ON) do
    ALL_TYPE_SET[oldType] = true
end

-- Framework is embedded in this pack and always available.
function BritaArmorNV.IsFrameworkActive()
    return true
end

function BritaArmorNV.IsBritaNVItem(item)
    if not item or not item.getFullType then
        return false
    end
    return ALL_TYPE_SET[item:getFullType()] == true
end

local function copyModData(sourceItem, targetItem)
    local sourceModData = sourceItem.getModData and sourceItem:getModData() or nil
    local targetModData = targetItem.getModData and targetItem:getModData() or nil
    if not sourceModData or not targetModData then
        return
    end
    for key, value in pairs(sourceModData) do
        targetModData[key] = value
    end
end

local function replaceInventoryItem(player, inventory, oldItem, newFullType)
    if not player or not inventory or not oldItem or not newFullType then
        return nil
    end
    if isClient() and isMultiplayer() then
        return nil
    end

    local newItem = instanceItem(newFullType)
    if not newItem then
        return nil
    end

    local copied = false
    if NV and NV.Shared and NV.Shared.CopyItemState then
        copied = pcall(NV.Shared.CopyItemState, oldItem, newItem)
    end
    if not copied then
        if oldItem.getCondition and newItem.setCondition then
            newItem:setCondition(oldItem:getCondition())
        end
        if oldItem.isFavorite and newItem.setFavorite then
            newItem:setFavorite(oldItem:isFavorite())
        end
        if oldItem.getName and newItem.setName and oldItem.getScriptItem then
            local scriptItem = oldItem:getScriptItem()
            if scriptItem and oldItem:getName() ~= scriptItem:getDisplayName() then
                newItem:setName(oldItem:getName())
            end
        end
        copyModData(oldItem, newItem)
    end

    local bodyLocation = nil
    if oldItem.getBodyLocation then
        bodyLocation = oldItem:getBodyLocation()
    end
    local wasWorn = oldItem.isEquipped and oldItem:isEquipped()

    if wasWorn and player.removeWornItem then
        player:removeWornItem(oldItem, false)
    end
    inventory:Remove(oldItem)
    inventory:AddItem(newItem)

    if wasWorn and bodyLocation and player.setWornItem then
        player:setWornItem(bodyLocation, newItem)
        if triggerEvent then
            triggerEvent("OnClothingUpdated", player)
        end
    end

    return newItem
end

function BritaArmorNV.MigrateInventory(player)
    if not player or not player.getInventory then
        return 0
    end
    if isClient() and isMultiplayer() then
        return 0
    end

    local inventory = player:getInventory()
    if not inventory or not inventory.getItems then
        return 0
    end

    local toReplace = {}

    local function collect(container)
        local items = container and container.getItems and container:getItems() or nil
        if not items then return end

        for i = 0, items:size() - 1 do
            local item = items:get(i)
            if item and item.getFullType then
                local newType = BritaArmorNV.LEGACY_TO_ON[item:getFullType()]
                if newType then
                    table.insert(toReplace, { item = item, inventory = container })
                elseif item.IsInventoryContainer and item:IsInventoryContainer() and item.getInventory then
                    collect(item:getInventory())
                end
            end
        end
    end
    collect(inventory)

    local changed = 0
    for i = 1, #toReplace do
        local oldItem = toReplace[i].item
        local newType = BritaArmorNV.LEGACY_TO_ON[oldItem:getFullType()]
        if replaceInventoryItem(player, toReplace[i].inventory, oldItem, newType) then
            changed = changed + 1
        end
    end
    return changed
end

local function registerWithFramework()
    if not NV or not NV.Shared then
        return false
    end

    local scriptManager = ScriptManager and ScriptManager.instance or nil
    for i = 1, #BritaArmorNV.ALL_TYPES do
        local fullType = BritaArmorNV.ALL_TYPES[i]
        if NV.Shared.RegisterNightVisionItem then
            NV.Shared.RegisterNightVisionItem(fullType)
        end
        if scriptManager and scriptManager.getItem then
            local scriptItem = scriptManager:getItem(fullType)
            if scriptItem and scriptItem.DoParam then
                scriptItem:DoParam("NightVision = true")
            end
        end
    end

    if NV.Shared.ClearScriptNightVisionCache then
        NV.Shared.ClearScriptNightVisionCache()
    end
    return true
end

local registered = false

local function tryRegister()
    if registered then
        return
    end
    if registerWithFramework() then
        registered = true
        print("[BritasArmorPackB42] Registered Brita NV items with embedded NVFramework.")
    end
end

local function onCreatePlayer(_, player)
    BritaArmorNV.MigrateInventory(player)
end

local function warnStandaloneFrameworkConflict()
    local mods = getActivatedMods()
    if not mods or not mods.contains then
        return
    end
    if mods:contains("NVFramework") ~= true then
        return
    end

    local message = "[BritasArmorPackB42] FATAL CONFLICT: standalone NVFramework is still enabled. It overwrites fileGuidTable and breaks Brita clothing/night vision. Disable workshop mod NVFramework (3684087856) and restart."
    print(message)
    local player = getPlayer and getPlayer() or nil
    if player and HaloTextHelper and HaloTextHelper.addText then
        local warningKey = "UI_BritaArmor_NV_Conflict"
        local warning = "Disable standalone NVFramework — it conflicts with Brita Armor."
        if getText then
            local translated = getText(warningKey)
            if translated and translated ~= warningKey then
                warning = translated
            end
        end
        local shown = pcall(function()
            if HaloTextHelper.getColorRed then
                HaloTextHelper.addText(player, warning, "[br/]", HaloTextHelper.getColorRed())
            else
                HaloTextHelper.addText(player, warning)
            end
        end)
        if not shown and player.Say then
            player:Say(warning)
        end
    end
end

local function enforceBatteryRequirementForPack()
    if not SandboxVars then
        return
    end
    SandboxVars.NVFramework = SandboxVars.NVFramework or {}
    -- Versions through 1.3.2 forced this value off on every load. Migrate both
    -- existing and new worlds to the repaired mandatory-battery behavior.
    if SandboxVars.NVFramework.BatterySystemEnabled ~= true then
        SandboxVars.NVFramework.BatterySystemEnabled = true
        print("[BritasArmorPackB42] Night-vision battery requirement enabled.")
    end
end

local function onGameStart()
    warnStandaloneFrameworkConflict()
    enforceBatteryRequirementForPack()
    tryRegister()

    local migratedAny = false
    if getNumActivePlayers and getSpecificPlayer then
        for i = 0, getNumActivePlayers() - 1 do
            if BritaArmorNV.MigrateInventory(getSpecificPlayer(i)) > 0 then
                migratedAny = true
            end
        end
    else
        migratedAny = BritaArmorNV.MigrateInventory(getPlayer and getPlayer() or nil) > 0
    end

    if migratedAny then
        print("[BritasArmorPackB42] Migrated legacy night-vision item IDs to *_ON variants.")
    end
end

Events.OnGameBoot.Add(enforceBatteryRequirementForPack)
Events.OnGameBoot.Add(tryRegister)
Events.OnGameStart.Add(onGameStart)
Events.OnCreatePlayer.Add(onCreatePlayer)
