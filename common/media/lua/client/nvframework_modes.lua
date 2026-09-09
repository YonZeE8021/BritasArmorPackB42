NV = NV or {}
NV.Modes = NV.Modes or {}

local MODES = NV.Modes

MODES.MODE_CUSTOM = MODES.MODE_CUSTOM or "custom"
MODES.MODE_SINGLE_LIGHT = MODES.MODE_SINGLE_LIGHT or "single_light"
MODES.MODE_VANILLA = MODES.MODE_VANILLA or "vanilla"
MODES.MODE_DEBUG = MODES.MODE_DEBUG or "debug"
MODES._registry = MODES._registry or {}
MODES._ordered = MODES._ordered or {}

local function cloneTable(source)
    local result = {}
    for key, value in pairs(source or {}) do
        result[key] = value
    end
    return result
end

local function debugPrint(message)
    if NV and NV.DebugPrint then
        NV.DebugPrint(message)
    end
end

local function compareModes(left, right)
    if left.priority ~= right.priority then
        return left.priority < right.priority
    end

    local leftLabel = string.lower(left.label or left.id)
    local rightLabel = string.lower(right.label or right.id)
    if leftLabel ~= rightLabel then
        return leftLabel < rightLabel
    end

    return left.id < right.id
end

local function rebuildOrderedModes()
    local ordered = {}
    for _, mode in pairs(MODES._registry) do
        table.insert(ordered, mode)
    end

    table.sort(ordered, compareModes)
    MODES._ordered = ordered
end

local function notifyModeRegistryChanged()
    if NV.Options and NV.Options.RefreshModeOptions then
        NV.Options.RefreshModeOptions()
    end
end

local function normalizeModeLabel(modeDefinition)
    return modeDefinition.label or modeDefinition.name or modeDefinition.id
end

local function normalizeOverlayProfileGetter(modeDefinition)
    if type(modeDefinition.getOverlayProfile) == "function" then
        return modeDefinition.getOverlayProfile, true
    end

    if type(modeDefinition.overlayProfile) == "table" then
        local overlayProfile = cloneTable(modeDefinition.overlayProfile)
        return function()
            return cloneTable(overlayProfile)
        end, true
    end

    return nil, false
end

local function normalizeLightProfileGetter(modeDefinition)
    if type(modeDefinition.getLightProfile) == "function" then
        return modeDefinition.getLightProfile, true
    end

    if type(modeDefinition.lightProfile) == "table" then
        local lightProfile = cloneTable(modeDefinition.lightProfile)
        return function()
            return cloneTable(lightProfile)
        end, true
    end

    return nil, false
end

function MODES.GetRegisteredModes()
    local result = {}
    for index, mode in ipairs(MODES._ordered) do
        result[index] = mode
    end
    return result
end

function MODES.GetMode(modeId)
    return modeId and MODES._registry[modeId] or nil
end

function MODES.GetOverlayProfile(modeId)
    local mode = MODES.GetMode(modeId)
    if not (mode and mode.getOverlayProfile) then
        return nil
    end

    local ok, profile = pcall(mode.getOverlayProfile, mode)
    if not ok or type(profile) ~= "table" then
        return nil
    end

    return cloneTable(profile)
end

function MODES.GetLightProfile(modeId)
    local mode = MODES.GetMode(modeId)
    if not (mode and mode.getLightProfile) then
        return nil
    end

    local ok, profile = pcall(mode.getLightProfile, mode)
    if not ok or type(profile) ~= "table" then
        return nil
    end

    return cloneTable(profile)
end

function MODES.ResolveModeId(modeId)
    if modeId and MODES._registry[modeId] then
        return modeId
    end

    if MODES._registry[MODES.MODE_CUSTOM] then
        return MODES.MODE_CUSTOM
    end

    local firstMode = MODES._ordered[1]
    return firstMode and firstMode.id or nil
end

function MODES.RegisterMode(modeDefinition)
    if type(modeDefinition) ~= "table" then
        debugPrint("NV mode registration failed: mode definition must be a table")
        return false
    end

    local modeId = tostring(modeDefinition.id or "")
    if modeId == "" then
        debugPrint("NV mode registration failed: missing mode id")
        return false
    end

    if MODES._registry[modeId] then
        local existingMode = MODES._registry[modeId]
        debugPrint("NV mode registration skipped for duplicate id '" .. modeId .. "' from " .. tostring(modeDefinition.source or "unknown") .. "; already registered by " .. tostring(existingMode.source or "unknown"))
        return false
    end

    if type(modeDefinition.activate) ~= "function" or type(modeDefinition.deactivate) ~= "function" then
        debugPrint("NV mode registration failed for '" .. modeId .. "': activate and deactivate callbacks are required")
        return false
    end

    local getOverlayProfile, hasOverlayProfile = normalizeOverlayProfileGetter(modeDefinition)
    local getLightProfile, hasLightProfile = normalizeLightProfileGetter(modeDefinition)

    local mode = {
        id = modeId,
        label = normalizeModeLabel(modeDefinition),
        source = modeDefinition.source or "unknown",
        priority = tonumber(modeDefinition.priority) or 100,
        description = modeDefinition.description,
        usesDirectionalLight = modeDefinition.usesDirectionalLight == true,
        usesPlayerPointLight = modeDefinition.usesPlayerPointLight == true,
        usesVanillaIndoorLight = modeDefinition.usesVanillaIndoorLight == true,
        hasOverlayProfile = hasOverlayProfile,
        getOverlayProfile = getOverlayProfile,
        hasLightProfile = hasLightProfile,
        getLightProfile = getLightProfile,
        activate = modeDefinition.activate,
        deactivate = modeDefinition.deactivate,
    }

    MODES._registry[modeId] = mode
    rebuildOrderedModes()
    notifyModeRegistryChanged()
    return true
end

function MODES.ActivateMode(modeId, player, options)
    local resolvedModeId = MODES.ResolveModeId(modeId)
    local mode = MODES.GetMode(resolvedModeId)
    if not mode then return false end
    return mode.activate(player, options or {}) ~= false
end

function MODES.DeactivateMode(modeId, player, options)
    local mode = MODES.GetMode(modeId)
    if not mode and modeId == nil then
        mode = MODES.GetMode(MODES.ResolveModeId(modeId))
    end
    if not mode then return false end
    return mode.deactivate(player, options or {}) ~= false
end

function NV.RegisterNightVisionMode(modeDefinition)
    return MODES.RegisterMode(modeDefinition)
end
