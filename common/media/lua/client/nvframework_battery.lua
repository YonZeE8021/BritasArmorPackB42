--[[
    Night Vision Framework - Battery System

    Battery consumption for NV items. A charged Base.Battery must be installed
    to activate NV; drain always runs while NV is active.

    Model:
    - A Base.Battery is "installed" into the NV goggle via a context menu action.
      The battery's charge is stored in the item's ModData ("nvBatteryCharge").
    - Toggle is gated: NV cannot be activated unless a battery is installed and charged.
    - Drain subtracts USE_DELTA (2/720) from ModData every game minute via EveryOneMinute,
      giving an exact 12 in-game hour battery life.
    - Below 20 % charge: screen flicker ramps up as a visual warning.
    - At 0 % charge: NV shuts off; the dead battery remains installed (shown as 0%).
    - "Remove Battery" via context menu retrieves the partially-charged battery.
      A depleted battery (<= 1 %) is discarded (nothing returned).

    Config keys (NV.Config in NVFramework_Core.lua):
        batteryDrainInterval  number  default 5  game-minutes per drain tick
        --  UseDelta 0.007 x 5 min \u2248 143 ticks \u00d7 5 = 715 min \u2248 12 game hours per battery

    Public API:
        NV.Battery.GetCharge(player)              \u2192 float 0.0\u20131.0 or nil (no battery installed)
        NV.Battery.HasBattery(player)             \u2192 bool (installed AND charge > 0)
        NV.Battery.OnLowBattery(player, charge)   callback \u2014 override for custom warning
        NV.Battery.OnBatteryDepleted(player)      callback \u2014 override for custom shutdown

    ModData key on NV item:
        "nvBatteryCharge"  float 0.0\u20131.0   present = battery installed, absent = no battery
--]]

require "NVFramework_BatteryState"

NV = NV or {}
NV.Battery = NV.Battery or {}

-- Constants
NV.Battery.MODDATA_KEY       = "nvBatteryCharge"
local LOW_BATTERY_THRESHOLD  = 0.20               -- 20 % triggers flicker warning
local LOW_BATTERY_FLICKER_BOOST = 0.40

local function clamp01(value)
    if value < 0 then return 0 end
    if value > 1 then return 1 end
    return value
end

local function getBaseFlickerValues()
    local overlay = NV.Overlay
    local config = overlay and overlay.Config or nil
    local baseConfig = overlay and overlay.BaseConfig or nil

    return {
        chance = (baseConfig and baseConfig.flickerChance) or (config and config.flickerChance) or 0.08,
        intensity = (baseConfig and baseConfig.flickerIntensity) or (config and config.flickerIntensity) or 0.45,
    }
end

local function restoreNormalFlicker()
    if NV.Overlay and NV.Overlay.Config then
        local baseFlicker = getBaseFlickerValues()
        NV.Overlay.Config.flickerChance    = baseFlicker.chance
        NV.Overlay.Config.flickerIntensity = baseFlicker.intensity
    end
end

-- Warning / depletion callbacks

--- Called each drain tick while charge is below LOW_BATTERY_THRESHOLD.
--- Override from an external mod to add custom behaviour (sounds, UI, etc.).
function NV.Battery.OnLowBattery(player, charge)
    if NV.Overlay and NV.Overlay.Config then
        local baseFlicker = getBaseFlickerValues()
        local severity = 1.0 - (charge / LOW_BATTERY_THRESHOLD)  -- 0 at 20 %, 1 at 0 %
        NV.Overlay.Config.flickerChance = clamp01(baseFlicker.chance + severity * LOW_BATTERY_FLICKER_BOOST)
        NV.Overlay.Config.flickerIntensity = clamp01(baseFlicker.intensity + severity * LOW_BATTERY_FLICKER_BOOST)
    end
end

--- Called when the installed battery reaches 0 %.
--- Override from an external mod to add custom behaviour.
function NV.Battery.OnBatteryDepleted(player)
    restoreNormalFlicker()
    if NV.ApplyLocalNightVisionState then
        NV.ApplyLocalNightVisionState(player, false, { playSound = true, force = true })
    elseif NV.DisableNightVision then
        NV.DisableNightVision(player)
    end
end

-- Client effects tick: authoritative drain runs in shared/server code.
local function onMinutePassed()
    if not (NV.State and NV.State.isActive) then
        restoreNormalFlicker()
        return
    end

    local player = (NV.GetPlayer and NV.GetPlayer()) or getPlayer()
    if not player then return end

    local nvItem = NV.GetWornNVItem and NV.GetWornNVItem(player) or nil
    if not nvItem or (NV.IsNVBatteryHostItem and not NV.IsNVBatteryHostItem(nvItem)) then
        restoreNormalFlicker()
        return
    end

    local md = nvItem:getModData()
    local charge = md[NV.Battery.MODDATA_KEY]

    if charge == nil then
        restoreNormalFlicker()
        return
    end

    if charge <= 0 then
        restoreNormalFlicker()
    elseif charge < LOW_BATTERY_THRESHOLD then
        NV.Battery.OnLowBattery(player, charge)
    else
        restoreNormalFlicker()
    end
end

Events.EveryOneMinute.Add(onMinutePassed)

print("[NV] Battery module loaded")
