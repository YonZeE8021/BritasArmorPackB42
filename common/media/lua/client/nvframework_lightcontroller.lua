--[[
    Night Vision Framework - Light Controller
    
    Creates dynamic IsoLightSource lights in a directional cone for realistic NV illumination.
    Provides 75deg field of view with wall collision detection via raycasting.
    
    Features:
    - Dynamic green light cone following player direction (75deg FOV)
    - 12 tile range with 0.4 tile step for smooth coverage
    - Raycasting wall detection (0.5 tile intervals)
    - Automatic cleanup on NV disable
    - Performance optimized with sparse sampling and change-driven rebuilds
    - Green NV tint (r=0.0, g=0.8, b=0.2)
    
    Configuration:
    Modify LIGHT_CONFIG below to adjust range, cone angle, color, etc.
--]]

NV = NV or {}
NV.LightController = NV.LightController or {}

require "NVFramework_Modes"
require "NVFramework_Sandbox"

local createItemInstance = rawget(_G, "instanceItem")

local function getActiveMode()
    if not (NV.State and NV.State.isActive) then return nil end

    local activeModeId = NV.State.activeModeId
    if not activeModeId and NV.Options and NV.Options.nvMode then
        activeModeId = NV.Options.nvMode()
    end

    if NV.Modes and NV.Modes.GetMode then
        return NV.Modes.GetMode(activeModeId)
    end

    return nil
end

local function getDebugPreviewModeFlags()
    if not (NV.DebugOverlayEditor and NV.DebugOverlayEditor.IsDebugModeActive and NV.DebugOverlayEditor.IsDebugModeActive()) then
        return nil
    end

    if not (NV.DebugOverlayEditor and NV.DebugOverlayEditor.GetPreviewModeFlags) then
        return nil
    end

    local flags = NV.DebugOverlayEditor.GetPreviewModeFlags()
    if type(flags) ~= "table" then
        return nil
    end

    return flags
end

local function activeModeUsesDirectionalLight()
    local previewFlags = getDebugPreviewModeFlags()
    if previewFlags then
        return previewFlags.usesDirectionalLight == true
    end

    local mode = getActiveMode()
    return mode and mode.usesDirectionalLight == true or false
end

local function activeModeUsesPlayerPointLight()
    local previewFlags = getDebugPreviewModeFlags()
    if previewFlags then
        return previewFlags.usesPlayerPointLight == true
    end

    local mode = getActiveMode()
    return mode and mode.usesPlayerPointLight == true or false
end

local function activeModeUsesVanillaIndoorLight()
    local previewFlags = getDebugPreviewModeFlags()
    if previewFlags then
        return previewFlags.usesVanillaIndoorLight == true
    end

    local mode = getActiveMode()
    return mode and mode.usesVanillaIndoorLight == true or false
end

-- Light management
local Lights = {}
local _lastDirectionalSample = nil
local _directionalUpdateTick = 0
local _directionalPlayerUpdateCounter = 0
local _attachedDirectionalHelper = nil

local DIRECTIONAL_POSITION_EPSILON = 0.15
local DIRECTIONAL_ANGLE_EPSILON = 4
local DIRECTIONAL_MAX_STALE_UPDATES = 8
local DIRECTIONAL_RING_SPACING_FACTOR = 0.22
local DIRECTIONAL_ARC_SPACING_FACTOR = 0.70
local DIRECTIONAL_MIN_ARC_SPACING = 1.35
local LIGHT_RAYCAST_STEP = 0.5
local LEGACY_DIRECTIONAL_DENSITY = 1.15
local ATTACHED_DIRECTIONAL_HELPER_ITEM = "Base.NVFramework_AttachedLight"
local ATTACHED_DIRECTIONAL_HELPER_LOCATION = "NVFrameworkLight"
local ATTACHED_DIRECTIONAL_HELPER_ATTACHMENT = "knife_head"

-- Configuration
local LIGHT_CONFIG = {
    maxDistance = 12,      -- Range in tiles
    step = 0.4,            -- Distance between light points (smaller = more lights, smoother)
    radius = 3.5,          -- Sparse-sampling light radius per point
    legacyRadius = 1,      -- Legacy-sampling light radius per point
    pointLightRadius = 6,  -- Radius for single point-light modes
    pointLightStrength = 1.0,
    coneAngle = 75,        -- Cone spread angle in degrees (total cone width)
    samplingMode = "legacy", -- "sparse" or "legacy" cone sampling
    directionalBackend = "attached-item", -- "attached-item" or "lamppost"
    r = 0.0,              -- Green tint for NV
    g = 0.8,
    b = 0.2,
    -- Note: No ambient light - overlay provides base visibility
}

local LIGHT_PROFILE_FIELDS = {
    "maxDistance",
    "step",
    "radius",
    "legacyRadius",
    "pointLightRadius",
    "pointLightStrength",
    "coneAngle",
    "samplingMode",
    "directionalBackend",
    "r",
    "g",
    "b",
}

local DEFAULT_LIGHT_PROFILE = {}
for _, key in ipairs(LIGHT_PROFILE_FIELDS) do
    DEFAULT_LIGHT_PROFILE[key] = LIGHT_CONFIG[key]
end

local VANILLA_LIGHT_CONFIG = {
    vanillaLightR = 0.25,
    vanillaLightG = 0.25,
    vanillaLightB = 0.25,
    vanillaLightRadius = 25,
    vanillaLightRadiusMin = 6,
    vanillaDarkThreshold = 0.3,
    vanillaMinDarknessScale = 0.5,
    vanillaStrengthScale = 1.0,
}

local VANILLA_LIGHT_PROFILE_FIELDS = {
    "vanillaLightR",
    "vanillaLightG",
    "vanillaLightB",
    "vanillaLightRadius",
    "vanillaLightRadiusMin",
    "vanillaDarkThreshold",
    "vanillaMinDarknessScale",
    "vanillaStrengthScale",
}

local DEFAULT_VANILLA_LIGHT_PROFILE = {}
for _, key in ipairs(VANILLA_LIGHT_PROFILE_FIELDS) do
    DEFAULT_VANILLA_LIGHT_PROFILE[key] = VANILLA_LIGHT_CONFIG[key]
end

local function resolveLightProfile(profile)
    local resolved = {}

    for _, key in ipairs(LIGHT_PROFILE_FIELDS) do
        if profile and profile[key] ~= nil then
            resolved[key] = profile[key]
        else
            resolved[key] = DEFAULT_LIGHT_PROFILE[key]
        end
    end

    for _, key in ipairs(VANILLA_LIGHT_PROFILE_FIELDS) do
        if profile and profile[key] ~= nil then
            resolved[key] = profile[key]
        else
            resolved[key] = DEFAULT_VANILLA_LIGHT_PROFILE[key]
        end
    end

    if NV.Options and NV.Options.useLegacyLightSampling then
        resolved.samplingMode = NV.Options.useLegacyLightSampling() and "legacy" or "sparse"
    end

    return resolved
end

local function removeLamppostLights()
    local cell = getCell()
    if cell then
        for _, light in ipairs(Lights) do
            cell:removeLamppost(light)
        end
    end
    Lights = {}
    _lastDirectionalSample = nil
end

local function isMultiplayerClient()
    local isClientFunc = rawget(_G, "isClient")
    local isMultiplayerFunc = rawget(_G, "isMultiplayer")

    return isClientFunc and isMultiplayerFunc and isClientFunc() and isMultiplayerFunc()
end

local function usesAttachedDirectionalHelper()
    if isMultiplayerClient() then
        return false
    end

    if NV.Sandbox and NV.Sandbox.UseLightConeInSingleplayer and not NV.Sandbox.UseLightConeInSingleplayer() then
        return false
    end

    return LIGHT_CONFIG.directionalBackend == "attached-item"
end

local function configureAttachedDirectionalHelper(helperItem)
    if not helperItem then return end

    if helperItem.setActivated then
        helperItem:setActivated(true)
    end
    if helperItem.setTorchCone then
        helperItem:setTorchCone(true)
    end
    if helperItem.setAttachedToModel then
        helperItem:setAttachedToModel(ATTACHED_DIRECTIONAL_HELPER_ATTACHMENT)
    end
end

local function removeAttachedDirectionalHelper(player)
    local helperItem = nil

    if player and player.getAttachedItem then
        helperItem = player:getAttachedItem(ATTACHED_DIRECTIONAL_HELPER_LOCATION)
    end

    if not helperItem then
        helperItem = _attachedDirectionalHelper
    end

    if helperItem and helperItem.setActivated then
        helperItem:setActivated(false)
    end

    if player and helperItem and player.removeAttachedItem then
        player:removeAttachedItem(helperItem)
        if player.reportEvent then
            player:reportEvent("EventAttachItem")
        end
    end

    if helperItem and helperItem.setAttachedSlot then
        helperItem:setAttachedSlot(-1)
    end
    if helperItem and helperItem.setAttachedToModel then
        helperItem:setAttachedToModel(nil)
    end

    _attachedDirectionalHelper = nil
end

local function ensureAttachedDirectionalHelper(player)
    if not (player and player.setAttachedItem and player.getAttachedItem) then
        return false
    end

    local existing = player:getAttachedItem(ATTACHED_DIRECTIONAL_HELPER_LOCATION)
    if existing then
        if existing.getFullType and existing:getFullType() ~= ATTACHED_DIRECTIONAL_HELPER_ITEM then
            return false
        end

        configureAttachedDirectionalHelper(existing)
        _attachedDirectionalHelper = existing
        return true
    end

    local helperItem = createItemInstance and createItemInstance(ATTACHED_DIRECTIONAL_HELPER_ITEM) or nil
    if not helperItem then
        return false
    end

    configureAttachedDirectionalHelper(helperItem)
    player:setAttachedItem(ATTACHED_DIRECTIONAL_HELPER_LOCATION, helperItem)
    if player.reportEvent then
        player:reportEvent("EventAttachItem")
    end

    _attachedDirectionalHelper = helperItem
    return true
end

-- Remove all existing light sources
local function removeAllLights()
    removeLamppostLights()
    removeAttachedDirectionalHelper(getPlayer())
end

local function applyLightProfile(profile)
    local resolved = resolveLightProfile(profile)

    for _, key in ipairs(LIGHT_PROFILE_FIELDS) do
        LIGHT_CONFIG[key] = resolved[key]
    end

    for _, key in ipairs(VANILLA_LIGHT_PROFILE_FIELDS) do
        VANILLA_LIGHT_CONFIG[key] = resolved[key]
    end

    if #Lights > 0 or _attachedDirectionalHelper then
        removeAllLights()
    end
end

function NV.LightController.ResolveProfile(profile)
    return resolveLightProfile(profile)
end

function NV.LightController.ApplyProfile(profile)
    applyLightProfile(profile)
end

function NV.LightController.ResetProfile()
    applyLightProfile(nil)
end

local ISO_FLAG_TYPE = rawget(_G, "IsoFlagType")

local function spriteHasFlag(props, flagName)
    if not (props and flagName) then return false end

    local flag = flagName
    if ISO_FLAG_TYPE and ISO_FLAG_TYPE[flagName] ~= nil then
        flag = ISO_FLAG_TYPE[flagName]
    end

    if props.has then
        return props:has(flag)
    end

    if props.Is then
        return props:Is(flag)
    end

    return false
end

local function spriteGetPropertyValue(props, propertyName)
    if not (props and propertyName) then return nil end

    if props.Val then
        local value = props:Val(propertyName)
        if value ~= nil and value ~= "" then
            return tostring(value)
        end
    end

    if props.get then
        local value = props:get(propertyName)
        if value ~= nil and value ~= "" then
            return tostring(value)
        end
    end

    return nil
end

local function spriteHasProperty(props, propertyName)
    if not (props and propertyName) then return false end

    if props.has and props:has(propertyName) then
        return true
    end

    return spriteGetPropertyValue(props, propertyName) ~= nil
end

local function isNonBlockingLowCover(props)
    return spriteHasFlag(props, "HoppableN")
        or spriteHasFlag(props, "HoppableW")
        or spriteHasFlag(props, "TallHoppableN") and spriteHasFlag(props, "SpearOnlyAttackThrough")
        or spriteHasFlag(props, "TallHoppableW") and spriteHasFlag(props, "SpearOnlyAttackThrough")
        or spriteHasFlag(props, "SpearOnlyAttackThrough")
        or spriteHasFlag(props, "solidtrans")
        or spriteHasFlag(props, "WindowN")
        or spriteHasFlag(props, "WindowW")
end

local function isSpriteWallBlocker(sprite)
    if not (sprite and sprite.getProperties) then return false end

    local props = sprite:getProperties()
    if not props or isNonBlockingLowCover(props) then
        return false
    end

    return spriteHasFlag(props, "solid")
        or (spriteHasFlag(props, "collideN")  and not spriteHasFlag(props, "transparentN")) 
        or (spriteHasFlag(props, "collideW")  and not spriteHasFlag(props, "transparentW"))
        or spriteHasFlag(props, "WallN")
        or spriteHasFlag(props, "WallW")
        or spriteHasFlag(props, "WallNW")
        or spriteHasFlag(props, "DoorWallN")
        or spriteHasFlag(props, "DoorWallW")
end

local function isVanillaSeeThroughDoorLikeObject(object)
    if not (object and object.getProperties) then return false end

    local props = object:getProperties()
    if not props or not spriteHasProperty(props, "doorTrans") or spriteHasProperty(props, "GarageDoor") then
        return false
    end

    if object.HasCurtains then
        local curtains = object:HasCurtains()
        if curtains then
            return curtains.IsOpen and curtains:IsOpen() or false
        end
    end

    return true
end

local function isSeeThroughWithCurtains(object)
    if not (object and object.HasCurtains) then return false end

    local curtains = object:HasCurtains()
    if curtains then
        return curtains.IsOpen and curtains:IsOpen() or false
    end

    return true
end

local function hasOpenCurtains(object)
    if not (object and object.HasCurtains) then return false end

    local curtains = object:HasCurtains()
    return curtains and curtains.IsOpen and curtains:IsOpen() or false
end

local function hasClosedCurtains(object)
    if not (object and object.HasCurtains) then return false end

    local curtains = object:HasCurtains()
    if not curtains then
        return false
    end

    return not (curtains.IsOpen and curtains:IsOpen() or false)
end

local function isSeeThroughOpeningObject(obj)
    if not obj then return false end

    if instanceof(obj, "IsoWindow") then
        return isSeeThroughWithCurtains(obj)
    end

    if instanceof(obj, "IsoDoor") then
        if hasOpenCurtains(obj) then
            return true
        end

        if isVanillaSeeThroughDoorLikeObject(obj) then
            return true
        end

        if obj.IsOpen then
            return obj:IsOpen() == true
        end

        return false
    end

    if instanceof(obj, "IsoThumpable") then
        if obj.isWindow and obj:isWindow() then
            return isSeeThroughWithCurtains(obj)
        end

        if obj.isDoor and obj:isDoor() then
            if hasOpenCurtains(obj) then
                return true
            end

            if isVanillaSeeThroughDoorLikeObject(obj) then
                return true
            end

            if obj.IsOpen then
                return obj:IsOpen() == true
            end
        end
    end

    return false
end

local function squareHasSeeThroughOpening(square)
    if not (square and square.getObjects) then return false end

    local objects = square:getObjects()
    if not objects then return false end

    for i = 0, objects:size() - 1 do
        if isSeeThroughOpeningObject(objects:get(i)) then
            return true
        end
    end

    return false
end

local function isSeeThroughDoorLikeObject(obj)
    if not obj then return false end

    if hasOpenCurtains(obj) then
        return true
    end

    if isVanillaSeeThroughDoorLikeObject(obj) then
        return true
    end

    if obj.IsOpen then
        return obj:IsOpen() == true
    end

    return false
end

local function isBoundaryOpeningObject(obj, originSquare, targetSquare)
    if not (obj and originSquare and targetSquare) then return false end

    local isDoor = instanceof(obj, "IsoDoor")
    local isWindow = instanceof(obj, "IsoWindow")
    local isThumpable = instanceof(obj, "IsoThumpable")
    local isThumpableDoor = isThumpable and obj.isDoor and obj:isDoor()
    local isThumpableWindow = isThumpable and obj.isWindow and obj:isWindow()

    if not (isDoor or isWindow or isThumpableDoor or isThumpableWindow) then
        return false
    end

    local objectSquare = obj.getSquare and obj:getSquare() or nil
    local sheetSquare = obj.getSheetSquare and obj:getSheetSquare() or nil
    if sheetSquare == originSquare or sheetSquare == targetSquare then
        return true
    end

    if objectSquare ~= originSquare and objectSquare ~= targetSquare then
        return false
    end

    local oppositeSquare = objectSquare == originSquare and targetSquare or originSquare
    if obj.isAdjacentToSquare then
        return obj:isAdjacentToSquare(oppositeSquare)
    end

    return true
end

local function squareHasBoundarySeeThroughOpening(square, originSquare, targetSquare)
    if not square then return false end

    local objects = square.getObjects and square:getObjects() or nil
    if objects then
        for i = 0, objects:size() - 1 do
            local obj = objects:get(i)
            if isBoundaryOpeningObject(obj, originSquare, targetSquare) and isSeeThroughOpeningObject(obj) then
                return true
            end
        end
    end

    local specialObjects = square.getSpecialObjects and square:getSpecialObjects() or nil
    if specialObjects then
        for i = 0, specialObjects:size() - 1 do
            local obj = specialObjects:get(i)
            if isBoundaryOpeningObject(obj, originSquare, targetSquare) and isSeeThroughOpeningObject(obj) then
                return true
            end
        end
    end

    return false
end

local function isClosedCurtainBoundaryBlocker(obj)
    if not obj then return false end

    if instanceof(obj, "IsoWindow") then
        return hasClosedCurtains(obj)
    end

    if instanceof(obj, "IsoThumpable") and obj.isWindow and obj:isWindow() then
        return hasClosedCurtains(obj)
    end

    if instanceof(obj, "IsoDoor") then
        return hasClosedCurtains(obj)
    end

    if instanceof(obj, "IsoThumpable") and obj.isDoor and obj:isDoor() then
        return hasClosedCurtains(obj)
    end

    return false
end

local function squareHasClosedCurtainBoundaryBlocker(square, originSquare, targetSquare)
    if not square then return false end

    local objects = square.getObjects and square:getObjects() or nil
    if objects then
        for i = 0, objects:size() - 1 do
            local obj = objects:get(i)
            if isBoundaryOpeningObject(obj, originSquare, targetSquare) and isClosedCurtainBoundaryBlocker(obj) then
                return true
            end
        end
    end

    local specialObjects = square.getSpecialObjects and square:getSpecialObjects() or nil
    if specialObjects then
        for i = 0, specialObjects:size() - 1 do
            local obj = specialObjects:get(i)
            if isBoundaryOpeningObject(obj, originSquare, targetSquare) and isClosedCurtainBoundaryBlocker(obj) then
                return true
            end
        end
    end

    return false
end

local function boundaryHasClosedCurtainBlocker(originSquare, targetSquare)
    if not (originSquare and targetSquare) then return false end

    local dx = targetSquare:getX() - originSquare:getX()
    local dy = targetSquare:getY() - originSquare:getY()
    if (dx ~= 0 and dy ~= 0) or (dx == 0 and dy == 0) then
        return false
    end

    if squareHasClosedCurtainBoundaryBlocker(originSquare, originSquare, targetSquare) then
        return true
    end

    if squareHasClosedCurtainBoundaryBlocker(targetSquare, originSquare, targetSquare) then
        return true
    end

    return false
end

local function boundaryHasSeeThroughDoor(originSquare, targetSquare)
    if not (originSquare and targetSquare) then return false end

    local dx = targetSquare:getX() - originSquare:getX()
    local dy = targetSquare:getY() - originSquare:getY()
    local isNorthSouthBoundary = dy ~= 0 and dx == 0
    local isWestEastBoundary = dx ~= 0 and dy == 0

    if not isNorthSouthBoundary and not isWestEastBoundary then
        return false
    end

    local north = isNorthSouthBoundary
    if originSquare.getDoor and targetSquare.getDoor then
        local originDoor = originSquare:getDoor(north)
        if isSeeThroughDoorLikeObject(originDoor) then
            return true
        end

        local targetDoor = targetSquare:getDoor(north)
        if isSeeThroughDoorLikeObject(targetDoor) then
            return true
        end
    end

    if squareHasBoundarySeeThroughOpening(originSquare, originSquare, targetSquare) then
        return true
    end

    if squareHasBoundarySeeThroughOpening(targetSquare, originSquare, targetSquare) then
        return true
    end

    return false
end

-- Check if square blocks line of sight
local function isLineOfSightBlockedBySquare(square)
    if not square then return true end
    
    local objects = square:getObjects()
    if not objects then return false end
    
    -- First pass: check for transparent objects (windows, open doors)
    for i = 0, objects:size() - 1 do
        local obj = objects:get(i)
        if obj then
            local isDoor = instanceof(obj, "IsoDoor")
            local isThumpableDoor = instanceof(obj, "IsoThumpable") and obj.isDoor and obj:isDoor()
            local isWindow = instanceof(obj, "IsoWindow")
            local isThumpableWindow = instanceof(obj, "IsoThumpable") and obj.isWindow and obj:isWindow()

            if isWindow or isThumpableWindow then
                if isSeeThroughWithCurtains(obj) then
                    return false
                end

                if hasClosedCurtains(obj) then
                    return true
                end
            end

            if (isDoor or isThumpableDoor) and hasOpenCurtains(obj) then
                return false
            end

            if (isDoor or isThumpableDoor) and isVanillaSeeThroughDoorLikeObject(obj) then
                return false
            end

            -- Check actual doors only - fence gates and other thumpables must fall through
            -- to the sprite-property blocker logic below.
            if isDoor or isThumpableDoor then
                if obj.IsOpen then
                    local isOpen = obj:IsOpen()
                    if isOpen then
                        return false  -- Open door, light passes through
                    end
                end
                -- Closed door blocks light
                return true
            end
        end
    end
    
    -- Second pass: check for solid blockers (walls)
    for i = 0, objects:size() - 1 do
        local obj = objects:get(i)
        if obj then
            if obj.getSprite then
                local sprite = obj:getSprite()
                if isSpriteWallBlocker(sprite) then
                    return true
                end
            end
        end
    end
    
    return false
end

local function getSquareCacheKey(square)
    if not square or not square.getX then return nil end
    return tostring(square:getX()) .. ":" .. tostring(square:getY()) .. ":" .. tostring(square:getZ())
end

local function hasLineOfSightBlocker(square, blockerCache)
    if not square then return true end

    local cacheKey = blockerCache and getSquareCacheKey(square) or nil
    if cacheKey ~= nil then
        local cached = blockerCache[cacheKey]
        if cached ~= nil then
            return cached
        end
    end

    local blocked = isLineOfSightBlockedBySquare(square)
    if cacheKey ~= nil then
        blockerCache[cacheKey] = blocked
    end

    return blocked
end

-- Check if there's a clear line of sight between two points (raycasting)
local function hasLineOfSight(cell, blockerCache, fromX, fromY, toX, toY, z)
    local dx = toX - fromX
    local dy = toY - fromY
    local distance = math.sqrt(dx * dx + dy * dy)
    
    if distance < LIGHT_RAYCAST_STEP then return true end
    
    local dirX = dx / distance
    local dirY = dy / distance

    if not cell then return false end
    local originSquare = cell:getGridSquare(fromX, fromY, z)
    local originSquareKey = getSquareCacheKey(originSquare)
    local originBoundaryChecked = false
    local previousSquare = originSquare
    local previousSquareKey = originSquareKey
    
    -- Check points along the line at fixed intervals.
    local steps = math.floor(distance / LIGHT_RAYCAST_STEP)
    for i = 1, steps do
        local checkDist = i * LIGHT_RAYCAST_STEP
        local checkX = fromX + dirX * checkDist
        local checkY = fromY + dirY * checkDist
        
        local square = cell:getGridSquare(checkX, checkY, z)
        local squareKey = getSquareCacheKey(square)
        if squareKey ~= previousSquareKey then
            if previousSquare and square and boundaryHasClosedCurtainBlocker(previousSquare, square) then
                return false
            end

            if not originBoundaryChecked and originSquare and square and originSquare.isBlockedTo and originSquare:isBlockedTo(square) then
                if not (boundaryHasSeeThroughDoor(originSquare, square)
                    or squareHasSeeThroughOpening(originSquare)
                    or squareHasSeeThroughOpening(square)) then
                    return false
                end
            end

            originBoundaryChecked = true

            if hasLineOfSightBlocker(square, blockerCache) then
                return false
            end

            previousSquare = square
            previousSquareKey = squareKey
        end
    end
    
    return true
end

local function usesLegacyDirectionalSampling()
    return LIGHT_CONFIG.samplingMode == "legacy"
end

local function shouldRunDirectionalUpdateThisTick()
    if not usesLegacyDirectionalSampling() then
        return true
    end

    _directionalPlayerUpdateCounter = (_directionalPlayerUpdateCounter % 4) + 1
    return _directionalPlayerUpdateCounter == 1
end

local function getEffectiveDirectionalRadius()
    if usesLegacyDirectionalSampling() then
        return math.max(0, LIGHT_CONFIG.legacyRadius or 1)
    end

    return math.max(0, LIGHT_CONFIG.radius or 3)
end

local function getDirectionalRingStep()
    return math.max(LIGHT_CONFIG.step, getEffectiveDirectionalRadius() * DIRECTIONAL_RING_SPACING_FACTOR)
end

local function getLegacyDirectionalRingStep()
    return math.max(0.1, LIGHT_CONFIG.step)
end

local function getLegacyLightsAtDistance(dist)
    return math.max(1, math.floor(dist * LEGACY_DIRECTIONAL_DENSITY))
end

local function getDirectionalArcSpacing()
    return math.max(DIRECTIONAL_MIN_ARC_SPACING, LIGHT_CONFIG.step * 2, getEffectiveDirectionalRadius() * DIRECTIONAL_ARC_SPACING_FACTOR)
end

local function getLightsAtDistance(dist, coneAngleRad)
    local arcLength = dist * coneAngleRad
    local count = math.max(1, math.floor((arcLength / getDirectionalArcSpacing()) + 0.5))

    if count > 1 and count % 2 == 0 then
        count = count + 1
    end

    return count
end

local function getAngleDeltaDegrees(leftAngle, rightAngle)
    local delta = (leftAngle - rightAngle + 180) % 360 - 180
    if delta < 0 then
        delta = -delta
    end
    return delta
end

local function shouldRebuildDirectionalLights(player)
    if not player or #Lights == 0 or not _lastDirectionalSample then
        return true
    end

    if player:getZ() ~= _lastDirectionalSample.z then
        return true
    end

    local dx = player:getX() - _lastDirectionalSample.x
    local dy = player:getY() - _lastDirectionalSample.y
    if (dx * dx + dy * dy) >= (DIRECTIONAL_POSITION_EPSILON * DIRECTIONAL_POSITION_EPSILON) then
        return true
    end

    if getAngleDeltaDegrees(player:getDirectionAngle(), _lastDirectionalSample.angle) >= DIRECTIONAL_ANGLE_EPSILON then
        return true
    end

    if (_directionalUpdateTick - (_lastDirectionalSample.tick or 0)) >= DIRECTIONAL_MAX_STALE_UPDATES then
        return true
    end

    return false
end

-- Create directional light cone
local function createDirectionalLight(player)
    if not player then return end
    
    local z = player:getZ()
    local px, py = player:getX(), player:getY()
    
    -- Get player facing direction
    local angle = player:getDirectionAngle()
    local angleRad = math.rad(angle)
    
    local cell = getCell()
    if not cell then return end
    local blockerCache = {}
    
    -- Note: No ambient light - NV overlay handles visibility enhancement
    -- Only directional cone for active illumination
    
    -- Create directional cone. Legacy mode restores the older denser light field,
    -- while sparse mode keeps the newer lower-cost sampling.
    local ringStep = usesLegacyDirectionalSampling() and getLegacyDirectionalRingStep() or getDirectionalRingStep()
    local lightRadius = getEffectiveDirectionalRadius()
    local numRings = math.max(1, math.ceil(LIGHT_CONFIG.maxDistance / ringStep))
    local coneAngleRad = math.rad(LIGHT_CONFIG.coneAngle)
    local halfConeAngle = coneAngleRad / 2
    
    -- Create light at player position first
    local playerLight = IsoLightSource.new(
        px, py, z,
        LIGHT_CONFIG.r,
        LIGHT_CONFIG.g,
        LIGHT_CONFIG.b,
        lightRadius
    )
    cell:addLamppost(playerLight)
    table.insert(Lights, playerLight)
    
    for i = 1, numRings do
        local dist = math.min(LIGHT_CONFIG.maxDistance, i * ringStep)
        
        local lightsAtDistance
        if usesLegacyDirectionalSampling() then
            lightsAtDistance = getLegacyLightsAtDistance(dist)
        else
            lightsAtDistance = getLightsAtDistance(dist, coneAngleRad)
        end
        
        for j = 0, lightsAtDistance - 1 do
            -- Calculate angle offset from center (-halfConeAngle to +halfConeAngle)
            local angleOffset = -halfConeAngle + (j / math.max(1, lightsAtDistance - 1)) * coneAngleRad
            local lightAngle = angleRad + angleOffset
            
            local lightDirX = math.cos(lightAngle)
            local lightDirY = math.sin(lightAngle)
            
            local lx = px + lightDirX * dist
            local ly = py + lightDirY * dist
            
            -- Check if there's a clear line of sight from player to this position
            if hasLineOfSight(cell, blockerCache, px, py, lx, ly, z) then
                -- Create light at this position
                local intensityFalloff = 1.0 - (dist / LIGHT_CONFIG.maxDistance) * 0.3
                local light = IsoLightSource.new(
                    lx, ly, z,
                    LIGHT_CONFIG.r * intensityFalloff,
                    LIGHT_CONFIG.g * intensityFalloff,
                    LIGHT_CONFIG.b * intensityFalloff,
                    lightRadius
                )
                cell:addLamppost(light)
                table.insert(Lights, light)
            end
        end
    end

    _lastDirectionalSample = {
        x = px,
        y = py,
        z = z,
        angle = angle,
        tick = _directionalUpdateTick,
    }
end

local function createPlayerPointLight(player)
    if not player then return end

    local cell = getCell()
    if not cell then return end

    local pointLightRadius = math.max(1, math.floor((LIGHT_CONFIG.pointLightRadius or LIGHT_CONFIG.radius or 1) + 0.5))
    local pointLightStrength = math.max(0, LIGHT_CONFIG.pointLightStrength or 1.0)
    local light = IsoLightSource.new(
        player:getX(),
        player:getY(),
        player:getZ(),
        LIGHT_CONFIG.r * pointLightStrength,
        LIGHT_CONFIG.g * pointLightStrength,
        LIGHT_CONFIG.b * pointLightStrength,
        pointLightRadius
    )
    cell:addLamppost(light)
    table.insert(Lights, light)
end

-- Update light cone when the player moved, turned, or the sample is stale.
function NV.LightController.Update()
    local player = getPlayer()
    if not player then
        removeAllLights()
        return
    end

    -- Only create lights if the active mode opted into the shared cone helper.
    if NV.State and NV.State.isActive then
        if activeModeUsesPlayerPointLight() then
            removeLamppostLights()
            createPlayerPointLight(player)
            return
        end

        if not activeModeUsesDirectionalLight() then return end

        if usesAttachedDirectionalHelper() and ensureAttachedDirectionalHelper(player) then
            removeLamppostLights()
            return
        end

        _directionalUpdateTick = _directionalUpdateTick + 1
        if not shouldRebuildDirectionalLights(player) then
            return
        end

        removeAllLights()
        createDirectionalLight(player)
    end
end

-- Enable light controller
function NV.LightController.Enable()
    local player = getPlayer()
    if not player then
        return
    end

    if activeModeUsesPlayerPointLight() then
        _directionalPlayerUpdateCounter = 0
        removeAllLights()
        createPlayerPointLight(player)
        return
    end

    if activeModeUsesDirectionalLight() then
        _directionalPlayerUpdateCounter = 0
        _directionalUpdateTick = _directionalUpdateTick + 1

        if usesAttachedDirectionalHelper() and ensureAttachedDirectionalHelper(player) then
            removeLamppostLights()
            return
        end

        removeAllLights()
        createDirectionalLight(player)
    end
end

-- Disable and cleanup
function NV.LightController.Disable()
    _directionalPlayerUpdateCounter = 0
    removeAllLights()
end

-- Toggle light controller
function NV.LightController.Toggle()
    if NV.State and NV.State.isActive then
        NV.LightController.Enable()
    else
        NV.LightController.Disable()
    end
end

-- Vanilla NV ambient light --------------------------------------------------
-- A single client-local IsoLightSource placed at the player's position.
-- Only active when indoors AND the tile is too dark (lightLevel <= threshold).
-- Moves with the player every frame. Not networked -- other players never see it.

-- Latch flag: once the vanilla light is on, keep it on until the player goes outside.
-- isTooDark() is ONLY evaluated on the OFF->ON transition so that our own IsoLightSource
-- cannot feed back into getLightLevel and cause flickering.
local _vanillaLightActive = false
local _vanillaLightStrength = 0

local function clamp01(value)
    if value < 0 then return 0 end
    if value > 1 then return 1 end
    return value
end

local function isTooDark(player)
    local square = player:getCurrentSquare()
    if not square then return false end
    local darkThreshold = clamp01(VANILLA_LIGHT_CONFIG.vanillaDarkThreshold or 0.3)
    return square:getLightLevel(player:getPlayerNum()) <= darkThreshold
end

local function getSwitchActivationState(lightSwitch)
    if not lightSwitch then return false end
    if lightSwitch.isActivated then
        return lightSwitch:isActivated() == true
    end
    if lightSwitch.Activated then
        return lightSwitch:Activated() == true
    end
    return false
end

local function roomHasActiveLights(room)
    if not room then return false end

    local switches = room.getLightSwitches and room:getLightSwitches() or room.lightSwitches
    if switches and switches.size and switches:size() > 0 then
        for index = 0, switches:size() - 1 do
            if getSwitchActivationState(switches:get(index)) then
                return true
            end
        end
    end

    local roomLights = room.roomLights
    if roomLights and roomLights.size and roomLights:size() > 0 then
        for index = 0, roomLights:size() - 1 do
            local roomLight = roomLights:get(index)
            if roomLight and roomLight.bActive == true then
                return true
            end
        end
    end

    return false
end

local function getSquareDarknessScale(player)
    local square = player:getCurrentSquare()
    if not square then return 0 end
    return clamp01(1 - square:getLightLevel(player:getPlayerNum()))
end

local function getVanillaClimateDarknessScale()
    local climate = getClimateManager()
    if not climate then return 1 end

    local dayLightStrength = climate.getDayLightStrength and climate:getDayLightStrength() or 1
    local ambient = climate.getAmbient and climate:getAmbient() or dayLightStrength
    local nightStrength = climate.getNightStrength and climate:getNightStrength() or (1 - dayLightStrength)

    return clamp01(math.max(1 - dayLightStrength, 1 - ambient, nightStrength))
end

local function getVanillaLightStrength(player, includeSquareDarkness)
    local darknessScale = getVanillaClimateDarknessScale()
    if includeSquareDarkness then
        darknessScale = math.max(darknessScale, getSquareDarknessScale(player))
    end

    local minDarknessScale = clamp01(VANILLA_LIGHT_CONFIG.vanillaMinDarknessScale or 0.5)
    local strengthScale = math.max(0, VANILLA_LIGHT_CONFIG.vanillaStrengthScale or 1.0)
    return clamp01(math.max(darknessScale, minDarknessScale) * strengthScale)
end

local function createVanillaLight(player, darknessScale)
    local cell = getCell()
    if not cell then return end

    darknessScale = clamp01(darknessScale or 1)
    if darknessScale <= 0 then return end

    local px = player:getX()
    local py = player:getY()
    local pz = player:getZ()
    local radiusMin = math.max(0, math.floor(VANILLA_LIGHT_CONFIG.vanillaLightRadiusMin or 6))
    local radiusMax = math.max(radiusMin, math.floor(VANILLA_LIGHT_CONFIG.vanillaLightRadius or 25))
    local radius = math.floor(radiusMin + (radiusMax - radiusMin) * darknessScale + 0.5)
    local light = IsoLightSource.new(px, py, pz,
        (VANILLA_LIGHT_CONFIG.vanillaLightR or 0.25) * darknessScale,
        (VANILLA_LIGHT_CONFIG.vanillaLightG or 0.25) * darknessScale,
        (VANILLA_LIGHT_CONFIG.vanillaLightB or 0.25) * darknessScale,
        radius)
    cell:addLamppost(light)
    table.insert(Lights, light)
end

-- Hook into player update
local function onPlayerUpdate()
    -- Only run if NV system is initialized and active
    if NV.State and NV.State.isActive then
        local player = getPlayer()

        if activeModeUsesVanillaIndoorLight() then
            if _attachedDirectionalHelper then
                removeAttachedDirectionalHelper(player)
            end

            if not player then
                removeAllLights()
                _vanillaLightActive = false
                _vanillaLightStrength = 0
                return
            end

            local square = player:getCurrentSquare()
            local room = square and square:getRoom() or nil

            if player:isOutside() then
                -- Always off outdoors
                if _vanillaLightActive then
                    removeAllLights()
                    _vanillaLightActive = false
                    _vanillaLightStrength = 0
                end
            elseif roomHasActiveLights(room) then
                if _vanillaLightActive then
                    removeAllLights()
                    _vanillaLightActive = false
                    _vanillaLightStrength = 0
                end
            elseif _vanillaLightActive then
                -- Light is on and player is indoors -- update position each frame.
                -- Do not re-check tile darkness here because our own light feeds back into it.
                local activeStrength = math.max(_vanillaLightStrength, getVanillaLightStrength(player, false))
                _vanillaLightStrength = activeStrength
                removeAllLights()
                createVanillaLight(player, activeStrength)
            else
                -- Light is off and player is indoors -- check darkness for OFF->ON transition only
                if isTooDark(player) then
                    _vanillaLightStrength = getVanillaLightStrength(player, true)
                    createVanillaLight(player, _vanillaLightStrength)
                    _vanillaLightActive = true
                end
            end
            return
        end

        if activeModeUsesPlayerPointLight() then
            if _attachedDirectionalHelper then
                removeAttachedDirectionalHelper(player)
            end

            removeLamppostLights()
            createPlayerPointLight(player)
            _vanillaLightActive = false
            _vanillaLightStrength = 0
            return
        end

        if activeModeUsesDirectionalLight() then
            if usesAttachedDirectionalHelper() and ensureAttachedDirectionalHelper(player) then
                if _vanillaLightActive or #Lights > 0 then
                    removeLamppostLights()
                    _vanillaLightActive = false
                    _vanillaLightStrength = 0
                end
                return
            end

            if not shouldRunDirectionalUpdateThisTick() then
                return
            end
            NV.LightController.Update()
        elseif _vanillaLightActive or #Lights > 0 or _attachedDirectionalHelper then
            removeAllLights()
            _vanillaLightActive = false
            _vanillaLightStrength = 0
        end
    else
        -- NV deactivated -- clean up
        if _vanillaLightActive or #Lights > 0 or _attachedDirectionalHelper then
            removeAllLights()
            _vanillaLightActive = false
            _vanillaLightStrength = 0
        end
    end
end

Events.OnPlayerUpdate.Add(onPlayerUpdate)

-- Hook into game start for initialization
local function onGameStart()
    -- Ensure lights are cleaned up on load
    removeAllLights()
end

Events.OnGameStart.Add(onGameStart)

print("[NV] Light controller loaded - Enhanced NV lighting enabled")
