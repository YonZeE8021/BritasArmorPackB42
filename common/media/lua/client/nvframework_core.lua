--[[
    Night Vision Framework - Core System
    
    Project Zomboid Build 42 (Lua 5.1)
    
    Description:
        Core NV framework for modders. Handles NV item detection, state management,
        and controller initialization. Provides automatic detection of items with
        `NightVision = true` in their script definition and manages the overlay
        and lighting systems.
    
    Features:
        - Automatic detection of worn NV items via script identity flag
        - State tracking and player management
        - Dynamic lighting controller (physical IsoLightSource lights)
        - Overlay system with green tint and vignette
        - Key binding management (V key)
        - Event system integration
    
    For Modders:
        Add `NightVision = true` to any NV clothing item and this framework
        will automatically enable NV functionality when worn.
    
    API Functions:
        NV.GetWornNVItem(player)     - Returns worn NV item or nil
        NV.Core.GetWornNVItem(player) - Alias for overlay compatibility
        NV.ToggleNightVision(player)  - Toggle NV for specified player
        NV.InitializeController()     - Initialize NV systems
    
    Configuration:
        NV.Config.keyBinding  - Key code for toggle (default: KEY_V)
        NV.Config.nvTag       - Legacy fallback tag (default: "NVITEM")
        NV.Config.debugMode   - Enable debug logging (default: false)
    
    Integration:
        This module works with NVFramework_Overlay.lua for visual effects,
        NVFramework_LightController.lua for dynamic lighting, and
        NVFramework_ClothingEvents.lua for automatic toggle on equip/unequip.
--]]


NV = NV or {}
NV.Core = NV.Core or {}

-- Core configuration
NV.Config = {
    keyBinding = Keyboard.KEY_V, -- V key for toggle
    debugEditorBinding = Keyboard.KEY_N, -- N key for the debug overlay editor
    nvTag = "NVITEM", -- Legacy fallback tag used by older NV items
    debugMode = false, -- Set to true for debug messages
    soundEnabled = true, -- Play sounds when toggling
}

-- NV state tracking
NV.State = {
    isActive = false, -- Is NV currently active
    lastPlayerID = nil, -- Track player changes
    nvItemWorn = nil, -- Currently worn NV item
    nvController = nil, -- NVAPI controller instance
    activeModeId = nil, -- Currently applied night-vision mode id
    localPlayerNum = nil, -- Local split-screen player currently owning the visual effect
}

-- Initialize the NV controller
function NV.InitializeController()
    if not NV.State.nvController then
        -- Use our built-in overlay system with physical lights
        require "NVFramework_Overlay"
        require "NVFramework_LightController"
        NV.State.nvController = {
            toggle = function() 
                NV.Overlay.Toggle()
                NV.LightController.Toggle()
            end,
            disable = function() 
                NV.Overlay.Disable()
                NV.LightController.Disable()
            end
        }
        --print("[NV] Using built-in NV overlay with physical lights")
        return true
    end
    return NV.State.nvController ~= nil
end

-- Debug printing function
function NV.DebugPrint(message)
    if NV.Config.debugMode then
        --print("[NV DEBUG] " .. tostring(message))
    end
end

require "NVFramework_Shared"
require "NVFramework_BatteryState"

-- Get the player safely
function NV.GetPlayer()
    if NV.State and NV.State.localPlayerNum ~= nil and getSpecificPlayer then
        local statePlayer = getSpecificPlayer(NV.State.localPlayerNum)
        if statePlayer then return statePlayer end
    end
    return getPlayer()
end

local function resolveCommandPlayer(args)
    args = args or {}

    if args.playerNum ~= nil and getSpecificPlayer then
        local indexedPlayer = getSpecificPlayer(tonumber(args.playerNum) or 0)
        if indexedPlayer then return indexedPlayer end
    end

    if args.onlineID ~= nil and getNumActivePlayers and getSpecificPlayer then
        for index = 0, getNumActivePlayers() - 1 do
            local candidate = getSpecificPlayer(index)
            if candidate and candidate.getOnlineID and candidate:getOnlineID() == args.onlineID then
                return candidate
            end
        end
    end

    return NV.GetPlayer()
end

local function isMultiplayerClient()
    return isClient() and isMultiplayer()
end

local function modeUsesBuiltInNightVision(modeId)
    local vanillaModeId = NV.Modes and NV.Modes.MODE_VANILLA or "vanilla"
    return modeId == vanillaModeId
end

local function clearBuiltInNightVisionIfNeeded(player, ...)
    if not player then return end

    local modeIds = {...}
    for index = 1, #modeIds do
        if modeUsesBuiltInNightVision(modeIds[index]) then
            player:setWearingNightVisionGoggles(false)
            return
        end
    end
end

local function triggerToggleEvent(player, isActive)
    if player and triggerEvent then
        triggerEvent("OnNVToggled", player, isActive, NV.GetWornNVItem(player))
    end
end

local function resolveLocalInventoryItem(player, itemId, fallback)
    if not player then return fallback end

    local inventory = player.getInventory and player:getInventory() or nil
    if not inventory then return fallback end

    if fallback and inventory.contains and inventory:contains(fallback) then
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

function NV.RefreshInventoryViews(player)
    if not player then
        player = NV.GetPlayer()
        if not player then return false end
    end

    local inventory = player.getInventory and player:getInventory() or nil
    if inventory and inventory.setDrawDirty then
        inventory:setDrawDirty(true)
    end

    local playerNum = player.getPlayerNum and player:getPlayerNum() or 0

    if getPlayerInventory then
        local playerInventory = getPlayerInventory(playerNum)
        if playerInventory and playerInventory.refreshBackpacks then
            playerInventory:refreshBackpacks()
        end
    end

    if getPlayerLoot then
        local lootInventory = getPlayerLoot(playerNum)
        if lootInventory and lootInventory.refreshBackpacks then
            lootInventory:refreshBackpacks()
        end
    end

    if ISInventoryPage then
        ISInventoryPage.renderDirty = true
    end

    return true
end

function NV.ApplyLocalItemActiveState(player, args)
    args = args or {}

    if not player then
        player = NV.GetPlayer()
        if not player then return false end
    end

    local nvItem = resolveLocalInventoryItem(player, args.itemId, NV.GetWornNVItem and NV.GetWornNVItem(player) or nil)
    if not nvItem or not (NV.Shared and NV.Shared.IsNVTaggedItem and NV.Shared.IsNVTaggedItem(nvItem)) then
        return false
    end

    nvItem:getModData()[NV.Shared.ACTIVE_MODDATA_KEY] = args.active == true
    return true
end

function NV.ApplyLocalBatteryCharge(player, args)
    args = args or {}

    if not player then
        player = NV.GetPlayer()
        if not player then return false end
    end

    local nvItem = resolveLocalInventoryItem(player, args.itemId, NV.GetWornNVItem and NV.GetWornNVItem(player) or nil)
    if not nvItem or (NV.IsNVBatteryHostItem and not NV.IsNVBatteryHostItem(nvItem)) then
        return false
    end

    local modData = nvItem:getModData()
    if args.installed == true then
        modData[NV.Battery.MODDATA_KEY] = args.charge or 0
    else
        modData[NV.Battery.MODDATA_KEY] = nil
    end

    NV.RefreshInventoryViews(player)
    return true
end

function NV.ApplyLocalNightVisionState(player, enable, options)
    options = options or {}

    if not player then
        player = NV.GetPlayer()
        if not player then return false end
    end

    local wasActive = NV.State.isActive == true
    local active = enable == true and NV.Shared.IsEmbeddedNightVisionEnabled()
    local playerNum = player.getPlayerNum and player:getPlayerNum() or 0
    NV.State.localPlayerNum = playerNum
    local requestedModeId = options.modeId
        or (NV.Options and NV.Options.nvMode and NV.Options.nvMode())
        or (NV.Options and NV.Options.NV_MODE_CUSTOM)
        or "custom"
    local resolvedModeId = (NV.Modes and NV.Modes.ResolveModeId and NV.Modes.ResolveModeId(requestedModeId)) or requestedModeId
    local previousModeId = NV.State.activeModeId
    local stateChanged = NV.State.isActive ~= active
    local modeChangedWhileActive = active and NV.State.isActive and previousModeId ~= resolvedModeId

    if not stateChanged and not modeChangedWhileActive then
        NV.State.nvItemWorn = active and NV.GetWornNVItem(player) or nil
        return true
    end

    require "NVFramework_LightController"

    if active then
        NV.State.nvItemWorn = NV.GetWornNVItem(player)

        if previousModeId and modeChangedWhileActive and NV.Modes and NV.Modes.DeactivateMode then
            NV.Modes.DeactivateMode(previousModeId, player, {
                playSound = false,
                nextModeId = resolvedModeId,
            })
        end

        if NV.LightController then
            NV.LightController.Disable()
        end

        if not (NV.Modes and NV.Modes.ActivateMode and NV.Modes.ActivateMode(resolvedModeId, player, options)) then
            clearBuiltInNightVisionIfNeeded(player, previousModeId, resolvedModeId)
            NV.State.isActive = false
            NV.State.activeModeId = nil
            NV.State.nvItemWorn = nil

            if wasActive then
                triggerToggleEvent(player, false)
            end

            NV.DebugPrint("Failed to activate NV mode '" .. tostring(resolvedModeId) .. "'")
            return false
        end

        NV.State.activeModeId = resolvedModeId
        NV.State.isActive = true

        local activeMode = NV.Modes and NV.Modes.GetMode and NV.Modes.GetMode(resolvedModeId) or nil
        if activeMode and (activeMode.usesDirectionalLight or activeMode.usesPlayerPointLight or activeMode.usesVanillaIndoorLight) and NV.LightController then
            NV.LightController.Enable()
        end
    else
        local modeToDisable = previousModeId or resolvedModeId

        if modeToDisable and NV.Modes and NV.Modes.DeactivateMode then
            NV.Modes.DeactivateMode(modeToDisable, player, options)
        end

        clearBuiltInNightVisionIfNeeded(player, modeToDisable)

        if NV.LightController then
            NV.LightController.Disable()
        end

        NV.State.nvItemWorn = nil
        NV.State.activeModeId = nil
    end

    NV.State.isActive = active

    if stateChanged then
        triggerToggleEvent(player, active)
    end

    NV.DebugPrint("NV state set " .. (active and "ON" or "OFF") .. " (mode=" .. tostring(active and NV.State.activeModeId or "none") .. ")")
    return true
end

function NV.RequestNightVisionState(player, enable, options)
    options = options or {}

    if not player then
        player = NV.GetPlayer()
    end
    if not player then return false end

    if isMultiplayerClient() then
        if sendClientCommand then
            sendClientCommand(player, "NVFramework", "SetNightVisionActive", {
                active = enable == true,
            })
            return true
        end
        return false
    end

    return NV.SetPlayerNightVisionState(player, enable, {
        playSound = options.playSound ~= false,
        syncLocal = options.syncLocal ~= false,
    })
end

local function onServerCommand(module, command, args)
    if module ~= "NVFramework" then return end

    local player = resolveCommandPlayer(args)
    if not player then return end

    if command == "SyncNVItemActiveState" then
        NV.ApplyLocalItemActiveState(player, args)
        return
    end

    if command == "SyncBatteryCharge" then
        NV.ApplyLocalBatteryCharge(player, args)
        return
    end

    if command == "RefreshInventoryUI" then
        NV.RefreshInventoryViews(player)
        return
    end

    if command ~= "SetLocalNightVision" then return end

    NV.ApplyLocalNightVisionState(player, args and args.active == true, {
        playSound = not args or args.playSound ~= false,
        force = true,
    })
end

if not NV._serverCommandHookAdded then
    Events.OnServerCommand.Add(onServerCommand)
    NV._serverCommandHookAdded = true
end

-- Play NV activation/deactivation sound on the local player
function NV.PlayNVSound(player, enable)
    if not player or not NV.Config.soundEnabled then return end

    local handle = player:getEmitter():playSound(enable and "nv-turnon" or "nv-turnoff")
    if not handle then return end

    local vol = 0.1
    if NV.Options and NV.Options.toggleSoundVolume then
        local optVol = tonumber(NV.Options.toggleSoundVolume())
        if optVol then
            vol = math.max(0, math.min(1, optVol))
        end
    end

    player:getEmitter():setVolume(handle, vol)
end

local function sayNVTip(player, text)
    if not player or not text then return end
    if HaloTextHelper and HaloTextHelper.addText then
        local shown = pcall(function()
            if HaloTextHelper.getColorWhite then
                HaloTextHelper.addText(player, text, "[br/]", HaloTextHelper.getColorWhite())
            else
                HaloTextHelper.addText(player, text)
            end
        end)
        if shown then return end
    end
    if player.Say then
        player:Say(text)
    end
end

-- Main NV toggle function
function NV.ToggleNightVision(player)
    if not player then
        player = NV.GetPlayer()
        if not player then 
            NV.DebugPrint("No player found for NV toggle")
            return false
        end
    end
    
    -- Check if player is wearing NV equipment
    local nvItem = NV.GetWornNVItem(player)
    if not nvItem then
        NV.DebugPrint("No NV item worn")
        sayNVTip(player, getText("UI_BritaArmor_NV_NeedWear") ~= "UI_BritaArmor_NV_NeedWear"
            and getText("UI_BritaArmor_NV_NeedWear")
            or "Wear night vision goggles first.")
        return false
    end

    -- Battery gate: when the sandbox battery system is enabled, NV cannot activate
    -- unless the worn item has a charged battery installed.
    -- Derive the toggle from this player's actual worn item, not the global
    -- visual state, so local split-screen players do not toggle each other.
    local targetState = not (NV.IsNVItemActive and NV.IsNVItemActive(nvItem))
    if targetState then
        if NV.Battery and not NV.Battery.HasBattery(player) then
            NV.DebugPrint("No charged battery installed -- cannot activate NV")
            sayNVTip(player, getText("UI_BritaArmor_NV_NeedBattery") ~= "UI_BritaArmor_NV_NeedBattery"
                and getText("UI_BritaArmor_NV_NeedBattery")
                or "Unequip goggles, insert a battery, then press V.")
            return false
        end
    end

    -- Store current NV item
    NV.State.nvItemWorn = nvItem

    return NV.RequestNightVisionState(player, targetState, {
        playSound = true,
        syncLocal = true,
    })
end

-- Force disable NV (when taking off goggles, etc.)
function NV.DisableNightVision(player)
    local item = player and NV.GetWornNVItem(player) or nil
    if not NV.State.isActive and not (item and NV.IsNVItemActive and NV.IsNVItemActive(item)) then return end
    return NV.RequestNightVisionState(player, false, {
        playSound = true,
        syncLocal = true,
    })
end

-- Check NV state consistency (called periodically)
function NV.CheckNVState(player)
    if not player then return end

    if not NV.Shared.IsEmbeddedNightVisionEnabled() then
        if NV.State.isActive then
            NV.ApplyLocalNightVisionState(player, false, { playSound = false })
        end
        return
    end

    local selectedModeId = (NV.Options and NV.Options.nvMode and NV.Options.nvMode()) or nil

    if NV.State.isActive and selectedModeId and NV.State.activeModeId ~= selectedModeId then
        NV.ApplyLocalNightVisionState(player, true, {
            playSound = false,
            force = true,
            modeId = selectedModeId,
        })
        return
    end
    
    local currentNVItem = NV.GetWornNVItem(player)
    
    -- If NV is active but no NV item worn, disable it
    if NV.State.isActive and not currentNVItem then
        NV.DebugPrint("NV active but no NV item worn - disabling")
        NV.DisableNightVision(player)
        return
    end
    
    -- If NV is active but item switched to OFF position, disable it
    if NV.State.isActive and currentNVItem and not NV.IsNVItemActive(currentNVItem) then
        NV.DebugPrint("NV active but item switched to OFF position - disabling")
        NV.DisableNightVision(player)
        return
    end
    
    -- Update stored NV item
    NV.State.nvItemWorn = currentNVItem
end

-- Key handler
function NV.OnKeyPressed(key)
    if not NV.Shared.IsEmbeddedNightVisionEnabled() then return end
    -- Read binding from ModOptions if available, fall back to Config
    local binding = (NV.Options and NV.Options.toggleKey and NV.Options.toggleKey()) or NV.Config.keyBinding

    if key == binding then
        local player = NV.GetPlayer()
        if not player then return end
        -- A foreign device may use the same physical key. Leave its handler
        -- alone and avoid an incorrect "wear goggles" prompt from this pack.
        if not NV.GetWornNVItem(player) and player.getWornItems then
            local worn = player:getWornItems()
            for index = 0, worn:size() - 1 do
                local entry = worn:get(index)
                local item = entry and entry:getItem()
                if NV.Shared.IsChuckedDevice(item) then return end
            end
        end
        NV.ToggleNightVision(player)
        return
    end

    local debugAuthoringAvailable = NV.Options
        and NV.Options.IsDebugAuthoringAvailable
        and NV.Options.IsDebugAuthoringAvailable()
    if not debugAuthoringAvailable then
        return
    end

    local debugEditorBinding = (NV.Options and NV.Options.debugEditorKey and NV.Options.debugEditorKey())
        or NV.Config.debugEditorBinding
        or Keyboard.KEY_N
    if key ~= debugEditorBinding then return end

    pcall(require, "NVFramework_DebugOverlayEditor")
    if NV.DebugOverlayEditor and NV.DebugOverlayEditor.Toggle then
        NV.DebugOverlayEditor.Toggle()
    end
end

-- Called once the game world is ready
function NV.OnGameStart()
    require "NVFramework_ClothingEvents"
    NV.ClothingEvents.Initialize()
    Events.OnKeyPressed.Add(NV.OnKeyPressed)
    NV.DebugPrint("NV OnGameStart: events registered")
    local player = NV.GetPlayer()
    if player then NV.CheckNVState(player) end
end

-- Initialize the system
function NV.Initialize()
    NV.DebugPrint("NV System initializing...")

    -- Mode registry and built-in mode definitions.
    pcall(require, "NVFramework_Modes")

    -- Load per-client mod options (PZAPI, persisted in ModOptions.ini)
    pcall(require, "NVFramework_ModOptions")

    -- Always load LightController so its OnPlayerUpdate hook is registered.
    -- This is needed for vanilla NV interior illumination even when custom
    -- lights are never created.
    pcall(require, "NVFramework_LightController")

    -- Optional battery drain system (hooks Events.EveryOneMinute)
    pcall(require, "NVFramework_Battery")

    -- UI helpers are leaf modules and should not require Core during bootstrap.
    -- Load them after the battery module so they only observe initialized state.
    pcall(require, "NVFramework_ContextMenu")

    -- Inventory tooltip overlay: appends charge progress bar to NVITEM hover tips
    pcall(require, "NVFramework_Tooltip")

    LuaEventManager.AddEvent("OnNVToggled")
    Events.OnGameStart.Add(NV.OnGameStart)
    NV.DebugPrint("NV System initialized")
end

-- Initialize when this file loads
NV.Initialize()
