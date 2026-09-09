require "NVFramework_Modes"
require "NVFramework_Overlay"
require "NVFramework_LightController"

NV = NV or {}

local CUSTOM_OVERLAY_PROFILE = {
    overlayR = 0.00,
    overlayG = 1.00,
    overlayB = 0.00,
    overlayAlpha = 0.25,
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

    vignetteSize = 500,
    vignetteAlpha = 0.78,
    vignetteLayers = 6,

    scanLinesEnabled = false,
    scanLineSpacing = 3,
    scanLineAlpha = 0.0,

    flickerEnabled = true,
    flickerChance = 0.16,
    flickerIntensity = 0.08,

    glareEnabled = false,
    glareRoomOnly = true,
    glareThreshold = 0.36,
    glareMaxAlpha = 0.46,
    glareBloomAlpha = 0.28,
    glareLayers = 4,
    glareR = 0.16,
    glareG = 0.98,
    glareB = 0.10,
}

local CUSTOM_LIGHT_PROFILE = {
    maxDistance = 12,
    step = 0.4,
    radius = 3.5,
    legacyRadius = 1,
    coneAngle = 75,
    samplingMode = "legacy",
    r = 0.0,
    g = 0.8,
    b = 0.2,
}

NV.RegisterNightVisionMode({
    id = (NV.Modes and NV.Modes.MODE_CUSTOM) or "custom",
    label = "Default",
    source = "NVFramework",
    priority = 0,
    usesDirectionalLight = true,
    overlayProfile = CUSTOM_OVERLAY_PROFILE,
    lightProfile = CUSTOM_LIGHT_PROFILE,

    activate = function(player, options)
        if not player then return false end

        if NV.Overlay and NV.Overlay.ResetProfile then
            NV.Overlay.ResetProfile()
        end
        if NV.Overlay and NV.Overlay.ApplyProfile then
            NV.Overlay.ApplyProfile(CUSTOM_OVERLAY_PROFILE)
        end

        if NV.LightController and NV.LightController.ResetProfile then
            NV.LightController.ResetProfile()
        end
        if NV.LightController and NV.LightController.ApplyProfile then
            NV.LightController.ApplyProfile(CUSTOM_LIGHT_PROFILE)
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

        if NV.Overlay then
            NV.Overlay.Disable(options and options.playSound)
            if NV.Overlay.ResetProfile then
                NV.Overlay.ResetProfile()
            end
        end

        if NV.LightController and NV.LightController.ResetProfile then
            NV.LightController.ResetProfile()
        end

        return true
    end,
})