require "NVFramework_Modes"
require "NVFramework_Overlay"
require "NVFramework_LightController"
require "NVFramework_DebugOverlayEditor"

NV = NV or {}

local DEBUG_OVERLAY_PROFILE = {
    overlayR = 0.02,
    overlayG = 0.90,
    overlayB = 0.05,
    overlayAlpha = 0.18,
    useClimateTint = false,

    exteriorR = 0.02,
    exteriorG = 0.78,
    exteriorB = 0.04,
    exteriorAlpha = 0.54,

    interiorR = 0.02,
    interiorG = 0.84,
    interiorB = 0.04,
    interiorAlpha = 0.60,

    ambientLight = 0.08,
    fogIntensity = 0.0,

    noiseEnabled = true,
    noiseIntensity = 0.40,
    noiseCount = 210,
    noiseBrightnessThreshold = 0.14,
    noiseFrameInterval = 2,
    noiseMinSize = 1,
    noiseMaxSize = 1,
    noiseR = 0.10,
    noiseG = 0.92,
    noiseB = 0.10,

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

local DEBUG_LIGHT_PROFILE = {
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

local function getDebugOverlayProfile()
    local profile = nil

    if NV.DebugOverlayEditor and NV.DebugOverlayEditor.GetProfile then
        profile = NV.DebugOverlayEditor.GetProfile()
    end

    if type(profile) ~= "table" then
        profile = DEBUG_OVERLAY_PROFILE
    end

    if profile.useClimateTint == nil then
        profile.useClimateTint = false
    end

    return profile
end

if NV.DebugOverlayEditor and NV.DebugOverlayEditor.RegisterDefaultProfile then
    NV.DebugOverlayEditor.RegisterDefaultProfile(DEBUG_OVERLAY_PROFILE)
end

if NV.DebugOverlayEditor and NV.DebugOverlayEditor.RegisterDefaultLightProfile then
    NV.DebugOverlayEditor.RegisterDefaultLightProfile(DEBUG_LIGHT_PROFILE)
end

if NV.DebugOverlayEditor and NV.DebugOverlayEditor.RegisterDefaultPreviewModeFlags then
    NV.DebugOverlayEditor.RegisterDefaultPreviewModeFlags({
        usesDirectionalLight = true,
        usesVanillaIndoorLight = false,
    })
end

NV.RegisterNightVisionMode({
    id = (NV.Modes and NV.Modes.MODE_DEBUG) or "debug",
    label = "NVFramework Debug Overlay Editor",
    source = "NVFramework",
    priority = 90,
    usesDirectionalLight = true,
    overlayProfile = DEBUG_OVERLAY_PROFILE,
    lightProfile = DEBUG_LIGHT_PROFILE,

    activate = function(player, options)
        if not player then return false end

        if NV.Overlay and NV.Overlay.ResetProfile then
            NV.Overlay.ResetProfile()
        end
        if NV.Overlay and NV.Overlay.ApplyProfile then
            NV.Overlay.ApplyProfile(getDebugOverlayProfile())
        end

        if NV.LightController and NV.LightController.ResetProfile then
            NV.LightController.ResetProfile()
        end
        if NV.DebugOverlayEditor and NV.DebugOverlayEditor.GetLightProfile and NV.LightController and NV.LightController.ApplyProfile then
            NV.LightController.ApplyProfile(NV.DebugOverlayEditor.GetLightProfile())
        elseif NV.LightController and NV.LightController.ApplyProfile then
            NV.LightController.ApplyProfile(DEBUG_LIGHT_PROFILE)
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

        if NV.DebugOverlayEditor and NV.DebugOverlayEditor.Close then
            NV.DebugOverlayEditor.Close()
        end

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