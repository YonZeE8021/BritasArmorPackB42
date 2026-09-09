require "TimedActions/ISReloadWeaponAction"

-- B42.20's vanilla reload code checks the base ammo-strap slot before it
-- evaluates most worn reload tags.  Brita arm, thigh and chest-rig slots are
-- intentionally separate, so an otherwise valid B42 tag can be skipped.
-- Preserve the loaded calculation for valid calls. B42.20's magazine-unload
-- action also calls it with non-weapons in the primary hand; vanilla then
-- calls HandWeapon-only methods on that item. Only those unsafe paths use
-- the nil-safe B42 base calculation below. No hands/equipment are changed.

BritasArmorReloadCompat = BritasArmorReloadCompat or {}
if BritasArmorReloadCompat.Installed then
    return
end

local SHELL_CARRIERS = {
    ["Base.Shell_Chest_Bandolier"] = true,
    ["Base.Metro_Bandolier"] = true,
    ["Base.Metro_Bandolier_ON"] = true,
    ["Base.Shell_Arm_Bandolier"] = true,
    ["Base.Shell_Arm_Bandolier_B"] = true,
    ["Base.Shell_Thigh_Bandolier"] = true,
    ["Base.Shell_Thigh_Bandolier_B"] = true,
    ["Base.Shotgun_Rig"] = true,
    ["Base.Shotgun_Rig_Loose"] = true,
}

local MAGAZINE_CARRIERS = {
    ["Base.Belt_Pack_AR"] = true,
    ["Base.Belt_Pack_AR_Loose"] = true,
    ["Base.Bag_AK_Vest"] = true,
    ["Base.Bag_AK_Vest_Loose"] = true,
    ["Base.Rig_Smersh_A"] = true,
    ["Base.Rig_Smersh_A_Loose"] = true,
    ["Base.Rig_Smersh_B"] = true,
    ["Base.Rig_Smersh_B_Loose"] = true,
    ["Base.Rig_Smersh_C"] = true,
    ["Base.Rig_Smersh_C_Loose"] = true,
}

-- No additional Brita item is unambiguously a loose-round carrier.  Keeping
-- this table empty prevents SKS clips and generic ammo bags from being guessed.
local BULLET_CARRIERS = {}

local function hasWhitelistedWornItem(character, whitelist)
    if not character or not character.getWornItems then return false end
    local wornItems = character:getWornItems()
    if not wornItems then return false end

    for index = 0, wornItems:size() - 1 do
        local worn = wornItems:get(index)
        local item = worn and worn:getItem() or nil
        local fullType = item and item.getFullType and item:getFullType() or nil
        if fullType and whitelist[fullType] then
            return true
        end
    end
    return false
end

local function weaponFeedType(gun)
    if not gun or not instanceof(gun, "HandWeapon") or not gun:isRanged() then return nil end
    if not gun.getAmmoType or not gun.getMagazineType then return nil end
    if gun:getAmmoType() == AmmoType.SHOTGUN_SHELLS then
        return "shell"
    end
    if gun.getMagazineType and gun:getMagazineType() then
        return "magazine"
    end
    return "bullet"
end

local function carrierForFeed(character, feedType)
    if feedType == "shell" then
        return hasWhitelistedWornItem(character, SHELL_CARRIERS)
    elseif feedType == "magazine" then
        return hasWhitelistedWornItem(character, MAGAZINE_CARRIERS)
    elseif feedType == "bullet" then
        return hasWhitelistedWornItem(character, BULLET_CARRIERS)
    end
    return false
end

-- Return (vanilla bonus, unsafe vanilla call). The original line 95 is only
-- reached inside this gate. Lines 100/102 can also dereference a nil strap
-- when an equipped carrier has a tag for a different ammunition feed.
local function inspectVanillaGate(character, gun, feedType)
    if not gun then return false, false end
    local equippedShells = character:hasEquippedTag(ItemTag.RELOAD_FAST_SHELLS)
    local equippedBullets = character:hasEquippedTag(ItemTag.RELOAD_FAST_BULLETS)
    local strap = character:getWornItem(ItemBodyLocation.AMMO_STRAP)
    local strapClothing = strap and strap.getClothingItem and strap:getClothingItem() or nil

    if not equippedShells and not equippedBullets and not strapClothing then
        return false, false
    end

    if not feedType then return false, true end

    if feedType == "magazine" then
        return character:hasEquippedTag(ItemTag.RELOAD_FAST_MAGAZINES)
            or character:hasWornTag(ItemTag.RELOAD_FAST_MAGAZINES), false
    end

    local strapName = strap and strap.getClothingItemName and strap:getClothingItemName() or nil
    if feedType == "shell" then
        local tagged = equippedShells or character:hasWornTag(ItemTag.RELOAD_FAST_SHELLS)
        return tagged or strapName == "AmmoStrap_Shells", not tagged and strap == nil
    end

    local tagged = equippedBullets or character:hasWornTag(ItemTag.RELOAD_FAST_BULLETS)
    return tagged or strapName == "AmmoStrap_Bullets", not tagged and strap == nil
end

local function vanillaBaseSpeed(character, rack, vanillaBonus)
    local speed = 0.8 + character:getPerkLevel(Perks.Reloading) * (rack and 0.04 or 0.10)
    if not rack then
        speed = speed - character:getMoodles():getMoodleLevel(MoodleType.PANIC) * 0.05
    end
    if vanillaBonus then speed = speed * 1.15 end
    local vehicle = character:getVehicle()
    if vehicle and vehicle:getDriver() == character then speed = speed * 0.8 end
    return speed
end

local function carrierBonusEnabled()
    local settings = SandboxVars and SandboxVars.BritasArmorPackB42
    return not (settings and settings.ReloadCarrierBonus == false)
end

local function packResults(...)
    return { n = select("#", ...), ... }
end

local originalSetReloadSpeed = ISReloadWeaponAction and ISReloadWeaponAction.setReloadSpeed or nil
if not originalSetReloadSpeed then
    print("[BritasArmorPackB42] Reload compatibility skipped: vanilla setReloadSpeed is unavailable.")
    return
end

BritasArmorReloadCompat.OriginalSetReloadSpeed = originalSetReloadSpeed

function ISReloadWeaponAction.setReloadSpeed(character, rack, ...)
    if not character then return originalSetReloadSpeed(character, rack, ...) end
    local gun = character and character.getPrimaryHandItem and character:getPrimaryHandItem() or nil
    local feedType = weaponFeedType(gun)
    local vanillaBonus, unsafe = inspectVanillaGate(character, gun, feedType)
    local missedBritaCarrier = carrierBonusEnabled() and not vanillaBonus
        and carrierForFeed(character, feedType)

    if unsafe then
        -- Same skill/panic/driver formula on client and server. In particular,
        -- holding a magazine, a pet or a tool does not turn it into a firearm.
        local speed = vanillaBaseSpeed(character, rack, vanillaBonus)
        if missedBritaCarrier then speed = speed * 1.15 end
        character:setVariable("ReloadSpeed", speed)
        return
    end

    if not missedBritaCarrier then
        return originalSetReloadSpeed(character, rack, ...)
    end

    local expectedVanillaSpeed = vanillaBaseSpeed(character, rack, vanillaBonus)
    local results = packResults(originalSetReloadSpeed(character, rack, ...))
    local reloadSpeed = character:getVariableFloat("ReloadSpeed", 1.0)
    -- If another reload mod changed the result, respect its calculation instead
    -- of guessing whether it already grants a carrier bonus (or stacking it).
    if reloadSpeed == reloadSpeed and math.abs(reloadSpeed - expectedVanillaSpeed) < 0.000001 then
        character:setVariable("ReloadSpeed", reloadSpeed * 1.15)
    end
    return unpack(results, 1, results.n)
end

BritasArmorReloadCompat.Installed = true
print("[BritasArmorPackB42] Installed scoped B42 reload-carrier compatibility.")
