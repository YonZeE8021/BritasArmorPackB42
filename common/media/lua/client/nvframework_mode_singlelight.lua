require "NVFramework_Modes"
require "NVFramework_Overlay"
require "NVFramework_LightController"

NV = NV or {}

local SINGLE_LIGHT_OVERLAY_PROFILE = {
    overlayR = 0.00,
    overlayG = 0.10,
    overlayB = 0.00,
    overlayAlpha = 0.1,
    useClimateTint = false,

    exteriorR = 0.00,
    exteriorG = 1.20,
    exteriorB = 0.00,
    exteriorAlpha = 1.00,

    interiorR = 0.00,
    interiorG = 1.20,
    interiorB = 0.00,
    interiorAlpha = 1.00,

    ambientLight = 0.0,
    fogIntensity = 0.0,

    noiseEnabled = true,
    noiseIntensity = 0.40,
    noiseBrightnessThreshold = 0.14,
    noiseFrameInterval = 2,
    noiseMinSize = 1,
    noiseMaxSize = 1,
    noiseR = 0.10,
    noiseG = 0.92,
    noiseB = 0.10,
    noiseTexturePaths = {
        "media/textures/NVFramework/Overlay/nvo1.png",
    },
    noiseTextureAlpha = 0.45,
    noiseTextureTintR = 1.00,
    noiseTextureTintG = 1.00,
    noiseTextureTintB = 1.00,
    noiseTextureFrameInterval = 2,
    noiseCount = 0,

    vignetteSize = 900,
    vignetteAlpha = 0.22,
    vignetteLayers = 3,

    scanLinesEnabled = false,
    scanLineSpacing = 3,
    scanLineAlpha = 0.0,

    flickerEnabled = true,
    flickerChance = 0.04,
    flickerIntensity = 0.90,

    glareEnabled = true,
    glareRoomOnly = true,
    glareThreshold = 0.36,
    glareMaxAlpha = 0.46,
    glareBloomAlpha = 0.28,
    glareLayers = 4,
    glareR = 0.16,
    glareG = 0.98,
    glareB = 0.10,
}

-- Brita pack: room-scale omnidirectional light (not a flashlight cone).
local SINGLE_LIGHT_PROFILE = {
    pointLightRadius = 120,
    pointLightStrength = 5.0,
    r = 0.25,
    g = 1.0,
    b = 0.25,
}

NV.RegisterNightVisionMode({
    id = (NV.Modes and NV.Modes.MODE_SINGLE_LIGHT) or "single_light",
    label = "Single Point Light",
    source = "NVFramework",
    priority = 1,
    usesPlayerPointLight = true,
    overlayProfile = SINGLE_LIGHT_OVERLAY_PROFILE,
    lightProfile = SINGLE_LIGHT_PROFILE,

    activate = function(player, options)
        if not player then return false end

        if NV.Overlay and NV.Overlay.ResetProfile then
            NV.Overlay.ResetProfile()
        end
        if NV.Overlay and NV.Overlay.ApplyProfile then
            NV.Overlay.ApplyProfile(SINGLE_LIGHT_OVERLAY_PROFILE)
        end

        if NV.LightController and NV.LightController.ResetProfile then
            NV.LightController.ResetProfile()
        end
        if NV.LightController and NV.LightController.ApplyProfile then
            NV.LightController.ApplyProfile(SINGLE_LIGHT_PROFILE)
        end

        if not NV.InitializeController or not NV.InitializeController() then
            if NV.LightController and NV.LightController.ResetProfile then
                NV.LightController.ResetProfile()
            end
            if NV.Overlay and NV.Overlay.ResetProfile then
                NV.Overlay.ResetProfile()
            end
            return false
        end

        if NV.Overlay then
            NV.Overlay.Enable(options and options.playSound)
        end
        return true
    end,

    deactivate = function(player, options)
        if not player then return false end

        if NV.LightController then
            NV.LightController.Disable()
            if NV.LightController.ResetProfile then
                NV.LightController.ResetProfile()
            end
        end

        if NV.Overlay then
            NV.Overlay.Disable(options and options.playSound)
            if NV.Overlay.ResetProfile then
                NV.Overlay.ResetProfile()
            end
        end

        return true
    end,
})