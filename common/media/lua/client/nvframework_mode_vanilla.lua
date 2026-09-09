require "NVFramework_Modes"
require "NVFramework_Overlay"
require "NVFramework_LightController"

NV = NV or {}

local VANILLA_LIGHT_PROFILE = {
    -- Tweak the built-in vanilla helper light here.
    -- These values only affect the extra indoor helper light, not Zomboid's
    -- own setWearingNightVisionGoggles() screen effect.
    vanillaLightR = 0.18,
    vanillaLightG = 0.22,
    vanillaLightB = 0.18,
    vanillaLightRadius = 48,
    vanillaLightRadiusMin = 12,
    vanillaDarkThreshold = 0.18,
    vanillaMinDarknessScale = 0.35,
    vanillaStrengthScale = 1.0,
}

NV.RegisterNightVisionMode({
    id = (NV.Modes and NV.Modes.MODE_VANILLA) or "vanilla",
    label = "Zomboid Native",
    source = "NVFramework",
    priority = 10,
    usesVanillaIndoorLight = true,
    lightProfile = VANILLA_LIGHT_PROFILE,

    activate = function(player, options)
        if not player then return false end

        if NV.Overlay and NV.Overlay.ResetProfile then
            NV.Overlay.ResetProfile()
        end
        if NV.LightController and NV.LightController.ResetProfile then
            NV.LightController.ResetProfile()
        end
        if NV.LightController and NV.LightController.ApplyProfile then
            NV.LightController.ApplyProfile(VANILLA_LIGHT_PROFILE)
        end

        player:setWearingNightVisionGoggles(true)
        if NV.Overlay then
            NV.Overlay.PlaySoundAndSwapModel(true, options and options.playSound)
        end
        return true
    end,

    deactivate = function(player, options)
        if not player then return false end

        player:setWearingNightVisionGoggles(false)

        if NV.LightController and NV.LightController.ResetProfile then
            NV.LightController.ResetProfile()
        end
        if NV.Overlay then
            NV.Overlay.PlaySoundAndSwapModel(false, options and options.playSound)
            if NV.Overlay.ResetProfile then
                NV.Overlay.ResetProfile()
            end
        end

        return true
    end,
})