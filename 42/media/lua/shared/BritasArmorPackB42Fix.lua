require("NPCs/BritasArmorPackB42Fix_BodyLocations")

if BritasArmorPackB42FixApplied then
    return
end
BritasArmorPackB42FixApplied = true

local fixed = 0
local missing = 0
local paramErrors = 0
local verified = 0
local verificationFailed = 0

local function safeScriptString(item, methodName)
    local fn = item and item[methodName]
    if type(fn) ~= "function" then
        return ""
    end

    local ok, value = pcall(fn, item)
    if not ok or value == nil then
        return ""
    end
    return tostring(value)
end

local function verifyValue(item, methodName, expected)
    local actual = safeScriptString(item, methodName)
    if string.lower(actual) == string.lower(expected) then
        verified = verified + 1
        return
    end

    verificationFailed = verificationFailed + 1
    print(string.format(
        "[BritasArmorPackB42Fix] Verification failed for %s: %s expected %s, got %s",
        item:getFullName(),
        methodName,
        expected,
        actual
    ))
end

local function verifyContainerInstance(scriptItem, location)
    local ok, instance = pcall(scriptItem.InstanceItem, scriptItem, nil)
    if not ok or not instance then
        verificationFailed = verificationFailed + 1
        print("[BritasArmorPackB42Fix] Could not instantiate " .. scriptItem:getFullName())
        return
    end

    verifyValue(instance, "canBeEquipped", location)

    local capacity = tonumber(safeScriptString(instance, "getCapacity")) or 0
    if capacity > 0 then
        verified = verified + 1
    else
        verificationFailed = verificationFailed + 1
        print("[BritasArmorPackB42Fix] Container has no capacity: " .. scriptItem:getFullName())
    end
end

local function verifyShellBandolierInstance(scriptItem, location)
    local ok, instance = pcall(scriptItem.InstanceItem, scriptItem, nil)
    if not ok or not instance then
        verificationFailed = verificationFailed + 1
        print("[BritasArmorPackB42Fix] Could not instantiate shell bandolier " .. scriptItem:getFullName())
        return
    end

    verifyValue(instance, "canBeEquipped", location)

    local capacity = tonumber(safeScriptString(instance, "getCapacity")) or 0
    if capacity == 1 then
        verified = verified + 1
    else
        verificationFailed = verificationFailed + 1
        print(string.format(
            "[BritasArmorPackB42Fix] Shell bandolier capacity mismatch for %s: expected 1, got %s",
            scriptItem:getFullName(),
            tostring(capacity)
        ))
    end

    local tagOk, hasReloadTag = pcall(instance.hasTag, instance, ItemTag.RELOAD_FAST_SHELLS)
    if tagOk and hasReloadTag then
        verified = verified + 1
    else
        verificationFailed = verificationFailed + 1
        print("[BritasArmorPackB42Fix] Missing B42 reload-speed tag on " .. scriptItem:getFullName())
    end
end

local function verifyReloadTagInstance(scriptItem, expectedTag)
    local ok, instance = pcall(scriptItem.InstanceItem, scriptItem, nil)
    if not ok or not instance then
        verificationFailed = verificationFailed + 1
        print("[BritasArmorPackB42Fix] Could not instantiate reload carrier " .. scriptItem:getFullName())
        return
    end

    local tagOk, hasReloadTag = pcall(instance.hasTag, instance, expectedTag)
    if tagOk and hasReloadTag then
        verified = verified + 1
    else
        verificationFailed = verificationFailed + 1
        print("[BritasArmorPackB42Fix] Missing B42 reload-speed tag on " .. scriptItem:getFullName())
    end
end

local function setParams(itemName, params)
    local item = ScriptManager.instance:getItem("Base." .. itemName)
    if not item then
        missing = missing + 1
        print("[BritasArmorPackB42Fix] Missing item: Base." .. itemName)
        return nil
    end

    for i = 1, #params do
        local ok, err = pcall(item.DoParam, item, params[i])
        if not ok then
            paramErrors = paramErrors + 1
            print(string.format(
                "[BritasArmorPackB42Fix] DoParam failed for Base.%s: %s (%s)",
                itemName,
                params[i],
                tostring(err)
            ))
        end
    end
    fixed = fixed + 1
    return item
end

local function setBodyLocation(items, location)
    for i = 1, #items do
        local item = setParams(items[i], { "BodyLocation = " .. location })
        if item then
            verifyValue(item, "getBodyLocation", location)
        end
    end
end

local function setContainerSlot(items, location)
    for i = 1, #items do
        local item = setParams(items[i], {
            "BodyLocation = " .. location,
            "CanBeEquipped = " .. location,
        })
        if item then
            verifyValue(item, "getBodyLocation", location)
            verifyContainerInstance(item, location)
        end
    end
end

local function setReloadTag(items, tagParam, expectedTag)
    for i = 1, #items do
        local item = setParams(items[i], { "Tags = " .. tagParam })
        if item then
            verifyReloadTagInstance(item, expectedTag)
        end
    end
end

local function setShellBandoliers(items, location)
    for i = 1, #items do
        local item = setParams(items[i], {
            "ItemType = base:container",
            "DisplayCategory = Bag",
            "BodyLocation = " .. location,
            "CanBeEquipped = " .. location,
            "Tooltip = Tooltip_AmmoStrap_Shotgun",
            "Tags = base:reloadfastshells;base:bagsfillexception;base:firearmloot",
            "CanHaveHoles = false",
            "Capacity = 1",
            "WeightReduction = 85",
            "RunSpeedModifier = 0.98",
            "CloseSound = CloseShellsBandolier",
            "OpenSound = OpenShellsBandolier",
            "PutInSound = StoreItemShellsBandolier",
            "AcceptItemFunction = AcceptItemFunction.AmmoStrap_Shells",
        })
        if item then
            verifyValue(item, "getBodyLocation", location)
            verifyShellBandolierInstance(item, location)
        end
    end
end

-- B42 vanilla uses this slot for ballistic vests. Unlike base:torsoextra,
-- it does not force normal jackets off the character.
local ballisticArmor = {
    "Armor_Defender",
    "Armor_Defender_Set",
    "Bag_Plate_Carrier",
    "Armor_6B13",
    "Sheriff_Vest",
    "Sheriff_Vest_Full",
    "SET_Armor",
    "SET_Armor_FULL",
    "Wolf_Plate_Carrier",
    "Wolf_Plate_Carrier_B",
    "EOD_Armor",
    "JUGG_Armor",
    "Hunter_Armor",
    "Armor_Dozer",
    "EXO_Suit",
    "EXO_Suit_ON",
    "USCM_Armor",
}
setBodyLocation(ballisticArmor, "base:torsoextravestbullet")

-- Old B41 accessory hacks used finger slots. Move them to the matching B42
-- arm, knee, thigh and ankle locations so they no longer consume unrelated slots.
local leftArmAccessories = {
    "Armband",
    "Armband_ON",
    "Armband_Long",
    "Armband_Long_ON",
    "Armband_Short",
    "Armband_Short_ON",
    "SET_ARM_PAD",
    "SET_ARM_PAD_Loose",
    "Hunter_Arm",
    "Hunter_Arm_ON",
    "Shell_Arm_Bandolier",
    "Shell_Arm_Bandolier_B",
}
setBodyLocation(leftArmAccessories, "base:leftarm")

local kneeAccessories = {
    "Wolf_Knee_Pad",
    "Wolf_Knee_Pad_Loose",
    "SET_PAD",
    "SET_PAD_Loose",
    "Mechanic_Boots_Armor",
    "Hunter_Knee",
    "Hunter_Knee_ON",
    "Metro_Knee",
    "Metro_Knee_ON",
}
setBodyLocation(kneeAccessories, "base:knee_right")

setBodyLocation({ "Hunter_Leg", "Hunter_Leg_ON" }, "base:thigh_left")
setBodyLocation({
    "Ashe_Leg_Armor",
    "Shell_Thigh_Bandolier",
    "Shell_Thigh_Bandolier_B",
}, "base:thigh_right")
setBodyLocation({ "Hunter_Knife", "Hunter_Knife_ON" }, "base:ankleholster")

-- Several large B41 garments borrowed Necklace_Long merely to gain an extra
-- wearable slot. B42 deliberately hides necklace models under jackets,
-- sweaters and ballistic vests, which made these raincoats, cloaks and ghillie
-- layers disappear. Preserve their original one-at-a-time behaviour on a
-- dedicated outer location that is registered after the vanilla clothing
-- layers, allowing them to remain visible over jackets and armor.
local outerCloaks = {
    "Ashe_Cloak",
    "Ashe_Cloak_ON",
    "Bag_Sniper_Hood",
    "Bag_Sniper_Hood_ON",
    "Bag_Sniper_Suit",
    "Bag_Sniper_Suit_Off",
    "Military_Cloak",
    "Military_Cloak_OFF",
    "Military_Ghillie",
    "Military_Ghillie_B",
    "Military_Ghillie_C",
    "Military_Ghillie_D",
    "Metro_Coat",
    "Chain_Coat",
    "Apron_Side",
    "Apron_Side_ON",
    "Star_Cape",
    "Star_Cape_ON",
    "Kenobi_Cape",
    "Kenobi_Cape_ON",
    "Vader_Cape",
}
setBodyLocation(outerCloaks, "BritasArmorFix:OuterCloak")

-- Boot gaiters also used the necklace slot and vanished whenever an outer
-- garment hid necklaces. Keep both visual states on one dedicated gaiter slot.
setBodyLocation({
    "Military_Gaiter",
    "Military_Gaiter_Loose",
    "OZK_Gaiter",
    "OZK_Gaiter_Loose",
}, "BritasArmorFix:Gaiters")

-- This item is a pair of hand wraps, not jewelry. The vanilla hands location
-- gives it the expected glove conflict without jacket/necklace hide rules.
setBodyLocation({ "Hand_Band_Heather" }, "base:hands")

-- Brita's shell holders still use the B41 clothing-only definition and the
-- obsolete ReloadFastShells tag. B42 ammo straps are wearable containers:
-- they hold shells, reject other item types and grant the vanilla 15% reload
-- bonus. Keep arm and thigh variants on their semantic slots while applying
-- the same B42 container/tag behavior as the vanilla shotgun shell strap.
setShellBandoliers({
    "Shell_Chest_Bandolier",
    "Metro_Bandolier",
    "Metro_Bandolier_ON",
}, "base:ammostrap")
setShellBandoliers({
    "Shell_Arm_Bandolier",
    "Shell_Arm_Bandolier_B",
}, "base:leftarm")
setShellBandoliers({
    "Shell_Thigh_Bandolier",
    "Shell_Thigh_Bandolier_B",
}, "base:thigh_right")

-- Saved copies created before 1.4.1 can remain Clothing instances even after
-- their ScriptItem is converted to base:container.  Migrate those live items
-- when they enter a player's inventory so old saves receive storage and the
-- B42 reload-speed behaviour without requiring the player to respawn them.
local shellBandolierTypes = {
    ["Base.Shell_Chest_Bandolier"] = true,
    ["Base.Metro_Bandolier"] = true,
    ["Base.Metro_Bandolier_ON"] = true,
    ["Base.Shell_Arm_Bandolier"] = true,
    ["Base.Shell_Arm_Bandolier_B"] = true,
    ["Base.Shell_Thigh_Bandolier"] = true,
    ["Base.Shell_Thigh_Bandolier_B"] = true,
}

local function isInventoryContainer(item)
    if not item then return false end
    if item.IsInventoryContainer then
        local ok, value = pcall(item.IsInventoryContainer, item)
        if ok then return value == true end
    end
    return instanceof and instanceof(item, "InventoryContainer") or false
end

local function copyMigratedItemState(sourceItem, targetItem)
    if NV and NV.Shared and NV.Shared.CopyItemState then
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

local function collectLegacyBandoliers(inventory, results)
    if not inventory or not inventory.getItems then return end
    local items = inventory:getItems()
    if not items then return end

    for index = 0, items:size() - 1 do
        local item = items:get(index)
        local fullType = item and item.getFullType and item:getFullType() or nil
        if fullType and shellBandolierTypes[fullType] and not isInventoryContainer(item) then
            results[#results + 1] = { inventory = inventory, item = item, fullType = fullType }
        elseif isInventoryContainer(item) and item.getInventory then
            collectLegacyBandoliers(item:getInventory(), results)
        end
    end
end

local function migrateLegacyBandoliers(player)
    if not player or not player.getInventory then return 0 end
    if isClient() and isMultiplayer() and not isServer() then return 0 end

    local candidates = {}
    collectLegacyBandoliers(player:getInventory(), candidates)
    local changed = 0

    for index = 1, #candidates do
        local entry = candidates[index]
        local oldItem = entry.item
        local owner = entry.inventory
        local newItem = instanceItem(entry.fullType)
        if newItem and isInventoryContainer(newItem) then
            copyMigratedItemState(oldItem, newItem)

            local wasWorn = oldItem.isEquipped and oldItem:isEquipped()
            if wasWorn and player.removeWornItem then
                player:removeWornItem(oldItem, false)
            end

            owner:Remove(oldItem)
            if sendRemoveItemFromContainer then
                sendRemoveItemFromContainer(owner, oldItem)
            end
            owner:AddItem(newItem)
            if sendAddItemToContainer then
                sendAddItemToContainer(owner, newItem)
            end

            if wasWorn and player.setWornItem then
                local location = newItem:canBeEquipped()
                if location and location ~= "" then
                    player:setWornItem(location, newItem)
                    if sendClothing then sendClothing(player, location, newItem) end
                end
            end
            if syncVisuals then syncVisuals(player) end
            if triggerEvent then triggerEvent("OnClothingUpdated", player) end
            changed = changed + 1
        end
    end

    if changed > 0 then
        print(string.format("[BritasArmorPackB42Fix] Migrated %d legacy shell bandolier instance(s).", changed))
    end
    return changed
end

local function migrateAllPlayers()
    if isServer() then
        local players = getOnlinePlayers and getOnlinePlayers() or nil
        if not players then return end
        for index = 0, players:size() - 1 do
            migrateLegacyBandoliers(players:get(index))
        end
        return
    end

    local playerCount = getNumActivePlayers and getNumActivePlayers() or 0
    if playerCount > 0 and getSpecificPlayer then
        for index = 0, playerCount - 1 do
            migrateLegacyBandoliers(getSpecificPlayer(index))
        end
    elseif getPlayer then
        migrateLegacyBandoliers(getPlayer())
    end
end

local function onCreatePlayer(_, player)
    migrateLegacyBandoliers(player)
end

if not (isClient() and isMultiplayer() and not isServer()) then
    Events.OnCreatePlayer.Add(onCreatePlayer)
    Events.OnGameStart.Add(migrateAllPlayers)
    Events.EveryOneMinute.Add(migrateAllPlayers)
end

-- Every backpack container in the source mod used the legacy B41 value "Back".
-- B42 expects the namespaced base:back location.
local backpacks = {
    "Bag_Sniper_Pack",
    "Bag_ARVN_Rucksack",
    "Bag_ST53_Set",
    "Bag_SCBA",
    "Bag_ZIP",
    "Bag_SSO",
    "Bag_Savotta",
    "Bag_Bush",
    "Bag_Hunting",
    "Bag_Radio_Pack",
    "Bag_Tactical_Alice",
    "Bag_Cat_Pack",
    "Bag_Robbie_Pack",
    "Bag_Hazard_Cross",
    "Bag_Dozer_Pack",
    "ELA_Bag",
    "OMNI_Bag",
    "KIP5",
    "AP3",
    "IP46",
    "Sheriff_Bag",
    "Trauma_Bag",
    "Casual_Bag",
    "Bushcraft_Bag",
    "Bread_Bag",
    "Bread_Sack",
    "Army_Duffle_Bag",
    "Trench_Tornister",
    "Baker_Tent",
    "Baker_Tent_2",
    "Baker_Tent_3",
    "Baker_Tent_4",
    "Baker_Tent_5",
    "Baker_Tent_6",
    "Hunter_Backpack",
    "Metro_Bag",
    "Multi_Carrier_Wood",
    "Multi_Carrier_Ammo",
    "Multi_Carrier_Carl",
    "Multi_Carrier_Food",
    "Ham_Radio",
}
setContainerSlot(backpacks, "base:back")

-- Chest rigs get a dedicated container slot. They remain usable as storage,
-- can be worn with jackets and ballistic armor, and only conflict with another chest rig.
local chestRigs = {
    "Bag_D3M",
    "Bag_D3M_Loose",
    "Bag_Blackhawk",
    "Bag_Blackhawk_Loose",
    "Bag_X_Vest",
    "Bag_X_Vest_Loose",
    "Bag_SKS_Vest",
    "Bag_SKS_Vest_Loose",
    "Bag_AK_Vest",
    "Bag_AK_Vest_Loose",
    "Rig_Smersh",
    "Rig_Smersh_Loose",
    "Rig_Smersh_A",
    "Rig_Smersh_A_Loose",
    "Rig_Smersh_B",
    "Rig_Smersh_B_Loose",
    "Rig_Smersh_C",
    "Rig_Smersh_C_Loose",
    "Rig_ELA",
    "Rig_ELA_Loose",
    "Radio_Rig",
    "Radio_Rig_Loose",
    "Shotgun_Rig",
    "Shotgun_Rig_Loose",
    "D3CR",
    "D3CR_Loose",
}
setContainerSlot(chestRigs, "BritasArmorFix:ChestRig")

-- Dedicated belt equipment should not consume a torso or vanilla fanny-pack slot.
local beltRigs = {
    "Bag_Tactical_Belt_Front",
    "Bag_Tactical_Belt_Back",
    "Bag_Duty_Belt_Front",
    "Bag_Duty_Belt_Back",
    "Belt_Pack_Duty",
    "Belt_Pack_Duty_Loose",
    "Belt_Pack_War",
    "Belt_Pack_War_Loose",
}
setContainerSlot(beltRigs, "BritasArmorFix:BeltRig")

-- Explicit drop-leg containers use their own thigh slot and no longer occupy
-- an upper-body/fanny-pack layer.
local thighPouches = {
    "Belt_Pack_AR",
    "Belt_Pack_AR_Loose",
    "Belt_Pack_Gas",
    "Belt_Pack_Gas_Loose",
    "Belt_Pack_Pouch",
    "Belt_Pack_Pouch_Loose",
}
setContainerSlot(thighPouches, "BritasArmorFix:ThighPouch")

-- Remaining small wearable containers follow the vanilla front/back fanny slots.
local utilityFront = {
    "Bottle_Bag",
    "K1_Bag",
    "OMNI_Pouch",
    "Ashe_Gear",
    "C420_PAPR",
    "GM15_Canister",
    "Trench_Ammo_Pack",
    "Trench_Grenade_Pack",
    "Messkit",
    "Messkit_B",
}
setContainerSlot(utilityFront, "base:fannypackfront")

local utilityBack = {
    "Bottle_Bag_Loose",
    "K1_Bag_Loose",
    "OMNI_Pouch_Loose",
    "Ashe_Gear_Loose",
    "C420_PAPR_Loose",
    "GM15_Canister_Loose",
    "Trench_Ammo_Pack_Loose",
    "Trench_Grenade_Pack_Loose",
    "Messkit_Loose",
    "Messkit_B_Loose",
}
setContainerSlot(utilityBack, "base:fannypackback")

-- B42 grants the vanilla 15% reload bonus through typed item tags.  Keep the
-- list deliberately narrow: only carriers whose model/name identifies one
-- unambiguous ammunition feed receive a tag.  Generic chest rigs and ammo
-- bags remain ordinary storage to avoid guessing how third-party guns model
-- SKS clips, loose rounds or mixed ammunition.
setReloadTag({
    "Shotgun_Rig",
    "Shotgun_Rig_Loose",
}, "base:reloadfastshells", ItemTag.RELOAD_FAST_SHELLS)

setReloadTag({
    "Belt_Pack_AR",
    "Belt_Pack_AR_Loose",
    "Bag_AK_Vest",
    "Bag_AK_Vest_Loose",
    "Rig_Smersh_A",
    "Rig_Smersh_A_Loose",
    "Rig_Smersh_B",
    "Rig_Smersh_B_Loose",
    "Rig_Smersh_C",
    "Rig_Smersh_C_Loose",
}, "base:reloadfastmagazines", ItemTag.RELOAD_FAST_MAGAZINES)

local function verifyNotExclusive(group, first, second, label)
    local ok, exclusive = pcall(group.isExclusive, group, first, second)
    if ok and not exclusive then
        verified = verified + 1
        return
    end

    verificationFailed = verificationFailed + 1
    print("[BritasArmorPackB42Fix] Unexpected clothing conflict: " .. label)
end

-- Final layer checks for the combinations this patch is intended to unlock.
local human = BodyLocations.getGroup("Human")
verifyNotExclusive(
    human,
    ItemBodyLocation.JACKET,
    ItemBodyLocation.TORSO_EXTRA_VEST_BULLET,
    "jacket + ballistic vest"
)
verifyNotExclusive(
    human,
    ItemBodyLocation.JACKET,
    BritasArmorFixRegistries.BodyLocations.ChestRig,
    "jacket + chest rig"
)
verifyNotExclusive(
    human,
    ItemBodyLocation.JACKET,
    BritasArmorFixRegistries.BodyLocations.ThighPouch,
    "jacket + thigh pouch"
)
verifyNotExclusive(
    human,
    ItemBodyLocation.JACKET,
    BritasArmorFixRegistries.BodyLocations.OuterCloak,
    "jacket + outer cloak"
)
verifyNotExclusive(
    human,
    ItemBodyLocation.TORSO_EXTRA_VEST_BULLET,
    BritasArmorFixRegistries.BodyLocations.OuterCloak,
    "ballistic vest + outer cloak"
)
verifyNotExclusive(
    human,
    ItemBodyLocation.JACKET,
    BritasArmorFixRegistries.BodyLocations.Gaiters,
    "jacket + gaiters"
)

print(string.format(
    "[BritasArmorPackB42Fix] Applied=%d, missing=%d, parameterErrors=%d, verified=%d, verificationFailed=%d.",
    fixed,
    missing,
    paramErrors,
    verified,
    verificationFailed
))
