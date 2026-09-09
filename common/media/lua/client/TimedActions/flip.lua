-- Brita NV Flip Timed Action
-- Provides a timed action for flipping NV goggles up/down

require "TimedActions/ISBaseTimedAction"
require "NVFramework_Core"

BritaNVFlipAction = ISBaseTimedAction:derive("BritaNVFlipAction")

function BritaNVFlipAction:new(character, nvItem, targetState)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.nvItem = nvItem
    o.targetState = targetState -- "ON" or "OFF"
    o.stopOnWalk = false
    o.stopOnRun = false
    o.maxTime = 30 -- 30 ticks for flip action (~1.5 seconds)
    o.useProgressBar = true
    return o
end

function BritaNVFlipAction:isValid()
    -- Check if character still has the NV item equipped
    if not self.character or not self.nvItem then
        return false
    end
    
    -- Verify the item is still worn
    local currentNVItem = NV.GetWornNVItem(self.character)
    return currentNVItem == self.nvItem
end

function BritaNVFlipAction:update()
    -- Optional: Add head movement animation
    -- self.character:faceThisObject(self.character)
end

function BritaNVFlipAction:start()
    NV.DebugPrint("Starting NV flip action to " .. self.targetState)
    -- Optional: Play flip start sound
end

function BritaNVFlipAction:stop()
    ISBaseTimedAction.stop(self)
    NV.DebugPrint("NV flip action stopped")
end

function BritaNVFlipAction:perform()
    ISBaseTimedAction.perform(self)

    if NV.RequestNightVisionState then
        NV.RequestNightVisionState(self.character, self.targetState == "ON", {
            playSound = true,
            syncLocal = true,
        })
    else
        NV.DebugPrint("NV request handler unavailable for flip action")
    end
end

function BritaNVFlipAction:getDuration()
    return self.maxTime
end

function BritaNVFlipAction:canBeCancelled()
    return true
end

-- Helper function to determine target item type
function BritaNVFlipAction.GetTargetItemType(currentType, targetState)
    -- Define the mapping between ON and OFF variants
    local itemMappings = {
        -- Sam Fisher goggles
        ["Base.Hat_NightVision_NV_ON"] = "Base.Hat_NightVision_NV_OFF",
        ["Base.Hat_NightVision_NV_OFF"] = "Base.Hat_NightVision_NV_ON",
    }
    
    -- Return the mapped item type
    return itemMappings[currentType]
end