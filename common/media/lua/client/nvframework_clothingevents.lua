-- Night Vision Framework - Clothing Update Handler
-- Monitors when clothing items change to manage NV state

require "NVFramework_Core"

NV.ClothingEvents = NV.ClothingEvents or {}

-- Handle clothing updates (when items are equipped/unequipped)
function NV.ClothingEvents.OnClothingUpdated(player)
    if not player then return end
    
    -- Check NV state consistency
    NV.CheckNVState(player)
end

-- Handle when player equips an item
function NV.ClothingEvents.OnEquipPrimary(player, item)
    if not player or not item then return end

    
    -- Check if the equipped item is an NV device
    if NV.Shared and NV.Shared.IsNVTaggedItem and NV.Shared.IsNVTaggedItem(item) then
        NV.DebugPrint("NV item equipped: " .. item:getDisplayName())
        
        -- If it's an OFF version and NV is currently active, disable NV
        if NV.State.isActive and not NV.IsNVItemActive(item) then
            NV.DebugPrint("OFF version equipped while NV active - disabling")
            NV.DisableNightVision(player)
        end
    end
end

-- Handle when player unequips an item
function NV.ClothingEvents.OnUnequipPrimary(player, item)
    if not player or not item then return end
    
    -- Check if the unequipped item is an NV device
    if NV.Shared and NV.Shared.IsNVTaggedItem and NV.Shared.IsNVTaggedItem(item) then
        NV.DebugPrint("NV item unequipped: " .. item:getDisplayName())
        
        -- If NV is currently active and this was the active NV item, disable NV
        if NV.State.isActive then
            NV.DebugPrint("Active NV item removed - disabling NV")
            NV.DisableNightVision(player)
        end
    end
end

-- Handle player updates (called frequently - use sparingly)
function NV.ClothingEvents.OnPlayerUpdate(player)
    if not player then return end
    
    -- Only check every few updates to avoid performance issues
    if not NV.ClothingEvents.updateCounter then
        NV.ClothingEvents.updateCounter = 0
    end
    
    NV.ClothingEvents.updateCounter = NV.ClothingEvents.updateCounter + 1
    
    -- Check every 30 updates (roughly every 1-2 seconds)
    if NV.ClothingEvents.updateCounter >= 30 then
        NV.ClothingEvents.updateCounter = 0
        NV.CheckNVState(player)
    end
end

-- Handle when a new game starts
function NV.ClothingEvents.OnNewGame(player, square)
    if not player then return end
    
    NV.DebugPrint("New game started - initializing NV state")
    
    -- Reset NV state for new game
    NV.State.isActive = false
    NV.State.nvItemWorn = nil
    NV.State.lastPlayerID = player:getOnlineID()
end

-- Handle when loading a save game
function NV.ClothingEvents.OnGameStart()
    local player = NV.GetPlayer()
    if not player then return end
    
    NV.DebugPrint("Game loaded - checking NV state")
    
    -- Check current NV state on load
    NV.CheckNVState(player)
end

-- Initialize all clothing event handlers
function NV.ClothingEvents.Initialize()
    -- Safety check - ensure Events is available
    if not Events then
        --print("[NV] ERROR: Events not available yet, retrying...")
        return
    end
    
    -- Clothing change events
    -- Note: OnClothingUpdated doesn't exist in PZ, we use OnPlayerUpdate instead
    Events.OnEquipPrimary.Add(NV.ClothingEvents.OnEquipPrimary)
    
    -- Player update events (use carefully due to frequency)
    Events.OnPlayerUpdate.Add(NV.ClothingEvents.OnPlayerUpdate)
    
    -- Game state events
    Events.OnNewGame.Add(NV.ClothingEvents.OnNewGame)
    Events.OnGameStart.Add(NV.ClothingEvents.OnGameStart)
    
    NV.DebugPrint("Clothing event handlers initialized")
end

-- NOTE: Do NOT call Initialize() here!
-- This file is loaded before the Events table exists.
-- Instead, call NV.ClothingEvents.Initialize() from NVFramework_Core.lua's OnGameStart handler.
