require "NVFramework_Modes"
require "NVFramework_Overlay"
require "NVFramework_LightController"

NV = NV or {}

local PHOSPHOR_PROFILE = {
    -- Tuned toward a cooler cyan-turquoise phosphor instead of a bright blue-white cast.
    overlayR = 0.00,
    overlayG = 0.95,
    overlayB = 1.00,
    overlayAlpha = 0.55,
    useClimateTint = false,

    exteriorR = 0.00,
    exteriorG = 0.95,
    exteriorB = 1.00,
    exteriorAlpha = 1.00,

    interiorR = 0.00,
    interiorG = 0.95,
    interiorB = 1.00,
    interiorAlpha = 0.46,

    ambientLight = 0.0,
    fogIntensity = 0.0,

    noiseEnabled = true,

    noiseIntensity = 0.50,
    noiseCount = 400,
    noiseBrightnessThreshold = 0.16,
    noiseFrameInterval = 4,
    noiseMinSize = 4,
    noiseMaxSize = 5,
    noiseR = 0.08,
    noiseG = 0.90,
    noiseB = 0.76,

    vignetteSize = 350,
    vignetteAlpha = 0.55,
    vignetteLayers = 4,

    scanLinesEnabled = true,
    scanLineSpacing = 1,
    scanLineAlpha = 0.25,

    flickerEnabled = true,
    flickerChance = 0.16,
    flickerIntensity = 0.12,

    glareEnabled = true,
    glareRoomOnly = true,
    glareThreshold = 0.42,
    glareMaxAlpha = 0.40,
    glareBloomAlpha = 0.24,
    glareLayers = 2,
    glareR = 0.18,
    glareG = 0.95,
    glareB = 0.12,
}

local PHOSPHOR_LIGHT_PROFILE = {
    maxDistance = 12,
    step = 0.4,
    radius = 3.5,
    legacyRadius = 1,
    coneAngle = 75,
    samplingMode = "legacy",
    r = 0.03,
    g = 0.54,
    b = 0.50,
}

NV.RegisterNightVisionMode({
    id = "nvframework_phosphor",
    label = "White Phosphor",
    source = "NVFramework",
    priority = 5,
    usesDirectionalLight = true,
    overlayProfile = PHOSPHOR_PROFILE,
    lightProfile = PHOSPHOR_LIGHT_PROFILE,

    activate = function(player, options)
        if not player then return false end

        if NV.Overlay and NV.Overlay.ApplyProfile then
            NV.Overlay.ApplyProfile(PHOSPHOR_PROFILE)
        end
        if NV.LightController and NV.LightController.ApplyProfile then
            NV.LightController.ApplyProfile(PHOSPHOR_LIGHT_PROFILE)
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
