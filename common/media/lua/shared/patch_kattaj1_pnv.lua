---@diagnostic disable: undefined-field, undefined-global
local Events = _G.Events
local ScriptManager = _G.ScriptManager

local TARGET_MOD_IDS = {
    ["3470491629"] = true,
    ["PNV"] = true,
}

local TARGET_ITEMS = {
    "Base.NVG_ANPVS-14_DOWN",
    "Base.NVG_ANPVS-14_DOWN-HeadStrap",
    "Base.NVG_ANPVS-14_UP",
    "Base.NVG_ANPVS-14_UP-HeadStrap",
    "Base.NVG_ArmasightN-15_DOWN",
    "Base.NVG_ArmasightN-15_DOWN-HeadStrap",
    "Base.NVG_ArmasightN-15_UP",
    "Base.NVG_ArmasightN-15_UP-HeadStrap",
    "Base.NVG_GPNVG-18_DOWN",
    "Base.NVG_GPNVG-18_DOWN-HeadStrap",
    "Base.NVG_GPNVG-18_UP",
    "Base.NVG_GPNVG-18_UP-HeadStrap",
    "Base.NVG_PNV-10T_DOWN",
    "Base.NVG_PNV-10T_DOWN-HeadStrap",
    "Base.NVG_PNV-10T_UP",
    "Base.NVG_PNV-10T_UP-HeadStrap",
}

local patchApplied = false

local function getScriptItem(fullType)
    if not ScriptManager or not ScriptManager.instance or not ScriptManager.instance.getItem then
        return nil
    end

    return ScriptManager.instance:getItem(fullType)
end

local function isTargetModActivated()
    local activatedMods = getActivatedMods()
    if not activatedMods or not activatedMods.contains then
        return false
    end

    for modId in pairs(TARGET_MOD_IDS) do
        if activatedMods:contains(modId) then
            return true
        end
    end

    return false
end

local function hasAnyTargetItem()
    for i = 1, #TARGET_ITEMS do
        if getScriptItem(TARGET_ITEMS[i]) then
            return true
        end
    end

    return false
end

local function clearNVIdentityCache()
    if NV and NV.Shared and NV.Shared.ClearScriptNightVisionCache then
        NV.Shared.ClearScriptNightVisionCache()
    end
end

local function registerNightVisionIdentity(fullType)
    if NV and NV.Shared and NV.Shared.RegisterNightVisionItem then
        NV.Shared.RegisterNightVisionItem(fullType)
    end
end

local function applyPatch()
    if patchApplied then
        return
    end

    if not isTargetModActivated() and not hasAnyTargetItem() then
        return
    end

    local appliedAny = false

    for i = 1, #TARGET_ITEMS do
        local fullType = TARGET_ITEMS[i]
        local item = getScriptItem(fullType)
        if item then
            item:DoParam("NightVision = true")
            registerNightVisionIdentity(fullType)
            appliedAny = true
        end
    end

    if appliedAny then
        clearNVIdentityCache()
    end

    patchApplied = appliedAny
end

if Events and Events.OnGameBoot then
    Events.OnGameBoot.Add(applyPatch)
end

if Events and Events.OnGameStart then
    Events.OnGameStart.Add(applyPatch)
end