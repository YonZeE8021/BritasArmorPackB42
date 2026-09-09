require "NVFramework_Modes"
require "NVFramework_Overlay"
require "NVFramework_LightController"

NV = NV or {}

local PHOSPHOR_OVERLAY_GLARE_PROFILE = {
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
    noiseTexturePaths = {
        "media/textures/NVFramework/Overlay/nvo1_b.png",
    },
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
    glareMaxAlpha = 0.7,
    glareBloomAlpha = 0.24,
    glareLayers = 2,
    glareR = 0.03,
    glareG = 1,
    glareB = 1,
}

local PHOSPHOR_OVERLAY_LIGHT_PROFILE = {
    pointLightRadius = 120,
    pointLightStrength = 4.5,
    r = 0.15,
    g = 0.70,
    b = 0.65,
}

NV.RegisterNightVisionMode({
    id = "nvframework_phosphor_glare_overlay",
    label = "White Phosphor Overlay /w Glare",
    source = "NVFramework",
    priority = 5,
    usesPlayerPointLight = true,
    overlayProfile = PHOSPHOR_OVERLAY_GLARE_PROFILE,
    lightProfile = PHOSPHOR_OVERLAY_LIGHT_PROFILE,

    activate = function(player, options)
        if not player then return false end

        if NV.Overlay and NV.Overlay.ApplyProfile then
            NV.Overlay.ApplyProfile(PHOSPHOR_OVERLAY_GLARE_PROFILE)
        end
        if NV.LightController and NV.LightController.ApplyProfile then
            NV.LightController.ApplyProfile(PHOSPHOR_OVERLAY_LIGHT_PROFILE)
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
