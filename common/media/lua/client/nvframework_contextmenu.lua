--[[
    Night Vision Framework - Battery Context Menu

    Adds "Insert Battery" / "Remove Battery" options when right-clicking
    any inventory item that has the NVITEM tag.

    Insert Battery:
    - Consumes a Base.Battery from the player's inventory (main slot first,
      then bags as fallback).
    - Stores the battery's current charge (0.0-1.0) in the item's ModData
      under the key "nvBatteryCharge".
    - If the item already has a battery installed, the option is replaced by
      "Remove Battery".

    Remove Battery:
    - Clears "nvBatteryCharge" from ModData.
    - If remaining charge > 1 %: spawns a Base.Battery with matching charge
      into the player's inventory (setUsedDelta = 1.0 - charge).
    - If charge <= 1 %: battery is considered dead and nothing is returned.
    - If NV is currently active, it is shut off immediately.

--]]

require "ISUI/ISInventoryPaneContextMenu"
require "TimedActions/ISNVBatteryActions"

NV = NV or {}

-- Helpers

local function findAllBatteriesInInventory(player)
    local batteries = {}
    local inv = player:getInventory()

    -- Search nested carried containers too.  The previous direct getItems()
    -- scan ignored batteries stored inside backpacks, chest rigs and pouches.
    local items = inv:getAllTypeRecurse("Battery")
    if items then
        for i = 0, items:size() - 1 do
            table.insert(batteries, items:get(i))
        end
    end

    return batteries
end

local function chargeLabel(charge)
    local normalizedCharge = tonumber(charge) or 0
    if normalizedCharge < 0 then
        normalizedCharge = 0
    elseif normalizedCharge > 1 then
        normalizedCharge = 1
    end

    -- Engine drainable values can land just under 1.0 for a fresh battery.
    if normalizedCharge >= 0.99 then
        normalizedCharge = 1
    end

    local percent = math.floor((normalizedCharge * 100) + 0.5)
    if normalizedCharge > 0 and percent == 0 then
        percent = 1
    end

    return string.format("%d%%", percent)
end

local function addBlockedBatteryTooltip(option, context, displayItem)
    if not option or not context or not ISInventoryPaneContextMenu or not ISInventoryPaneContextMenu.addToolTip then
        return
    end

    local tooltip = ISInventoryPaneContextMenu.addToolTip()
    local description = getText("ContextMenu_NVBatteryRequiresUnequip")
    if description == "ContextMenu_NVBatteryRequiresUnequip" then
        description = "Unequip the night vision item before changing the battery."
    end
    tooltip.description = description
    if displayItem and displayItem.getName then
        tooltip:setName(displayItem:getName())
    end
    option.toolTip = tooltip
end

-- Returns true if 'item' is currently worn by 'player'.
local function isItemWorn(player, item)
    local worn = player:getWornItems()
    for i = 0, worn:size() - 1 do
        if worn:get(i):getItem() == item then
            return true
        end
    end
    return false
end

local function queueTransferIfNeeded(player, item)
    if not player or not item then return end
    if ISInventoryPaneContextMenu and ISInventoryPaneContextMenu.transferIfNeeded then
        ISInventoryPaneContextMenu.transferIfNeeded(player, item)
    end
end

-- Context menu handler

local function onFillInventoryContextMenu(playerNum, context, items)
    local player = getSpecificPlayer(playerNum)
    if not player then return end
    if NV.Battery and NV.Battery.IsSystemEnabled and not NV.Battery.IsSystemEnabled() then return end

    for i = 1, #items do
        local entry = items[i]
        -- In B42 the list entries are InventoryItem instances directly.
        -- Older stacked-item tables (with an .items sub-array) are handled as fallback.
        local item = (type(entry) == "table" and entry.items) and entry.items[1] or entry

        -- B42.14+: ItemTag enum is generated from all script tags, including mod-defined ones.
        if NV.IsNVBatteryHostItem and NV.IsNVBatteryHostItem(item) then
            local installedCharge = NV.Battery.GetChargeFromItem(item)
            local worn = isItemWorn(player, item)

            if installedCharge == nil then
                -- No battery installed
                local batteries = findAllBatteriesInInventory(player)
                if #batteries > 0 then
                    local mainLabel = getText("ContextMenu_InsertBattery")
                    local subMenu = context:getNew(context)
                    local mainOpt = context:addOption(mainLabel, nil, nil)
                    mainOpt.itemForTexture = batteries[1]
                    
                    if worn then
                        mainOpt.notAvailable = true   -- red, non-clickable
                        addBlockedBatteryTooltip(mainOpt, context, batteries[1])
                    else
                        context:addSubMenu(mainOpt, subMenu)
                        
                        for _, bat in ipairs(batteries) do
                            local label = chargeLabel(bat:getCurrentUsesFloat())
                            local option = subMenu:addOption(label, {item = item, playerNum = playerNum, bat = bat}, function(args)
                                local p = getSpecificPlayer(args.playerNum)
                                if not p then return end
                                queueTransferIfNeeded(p, args.item)
                                queueTransferIfNeeded(p, args.bat)
                                ISTimedActionQueue.add(ISNVInsertBattery:new(p, args.item, args.bat))
                            end)
                            option.itemForTexture = bat
                        end
                    end
                else
                    local opt = context:addOption(getText("ContextMenu_AddBattery") .. " (" .. getText("UI_Battery_NotInstalled") .. ")", nil, nil)
                    opt.isDisabled = true
                end
            else
                -- Battery installed
                local removeLabel = getText("ContextMenu_RemoveBattery") .. " (" .. chargeLabel(installedCharge) .. ")"
                local opt = context:addOption(removeLabel, {item = item, playerNum = playerNum}, function(args)
                    local p = getSpecificPlayer(args.playerNum)
                    if not p then return end
                    queueTransferIfNeeded(p, args.item)
                    ISTimedActionQueue.add(ISNVRemoveBattery:new(p, args.item))
                end)
                if worn then
                    opt.notAvailable = true   -- red, non-clickable
                    addBlockedBatteryTooltip(opt, context, item)
                end
            end
        end
    end
end

Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryContextMenu)

print("[NV] Context menu loaded")
