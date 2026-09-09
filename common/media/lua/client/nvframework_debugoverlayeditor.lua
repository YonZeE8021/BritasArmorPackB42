---@diagnostic disable: undefined-global

require "ISUI/ISCollapsableWindow"
require "ISUI/ISButton"
require "ISUI/ISComboBox"
require "ISUI/ISLabel"
require "ISUI/ISTickBox"
require "RadioCom/ISUIRadio/ISSliderPanel"

NV = NV or {}
NV.DebugOverlayEditor = NV.DebugOverlayEditor or {}

local EDITOR = NV.DebugOverlayEditor

local WINDOW_W = 1040
local WINDOW_H = 820
local MARGIN = 14
local COLUMN_GAP = 24
local NOTE_GAP = 10
local SECTION_GAP = 8
local SECTION_ROW_H = 20
local ROW_H = 22
local SLIDER_H = 18
local BUTTON_W = 150
local BUTTON_H = 24
local PRESET_COMBO_W = 320
local PRESET_GAP = 8
local LABEL_W = 132
local VALUE_W = 60
local VALUE_GAP = 12

local LEFT_COLUMN_LAYOUT = {
    { kind = "section", label = "Main Tint" },
    { kind = "slider", key = "overlayR", label = "Overlay R", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "overlayG", label = "Overlay G", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "overlayB", label = "Overlay B", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "overlayAlpha", label = "Overlay Alpha", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },

    { kind = "section", label = "Exterior World Tint" },
    { kind = "slider", key = "exteriorR", label = "Exterior R", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "exteriorG", label = "Exterior G", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "exteriorB", label = "Exterior B", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "exteriorAlpha", label = "Exterior Alpha", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },

    { kind = "section", label = "Directional Light" },
    { kind = "slider", profile = "light", key = "r", label = "Lamp R", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", profile = "light", key = "g", label = "Lamp G", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", profile = "light", key = "b", label = "Lamp B", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", profile = "light", key = "coneAngle", label = "Cone Angle", min = 20, max = 120, step = 1, shift = 5, decimals = 0 },
    { kind = "slider", profile = "light", key = "maxDistance", label = "Max Distance", min = 2, max = 20, step = 0.5, shift = 1, decimals = 1 },
    { kind = "slider", profile = "light", key = "radius", label = "Sparse Radius", min = 1, max = 6, step = 0.5, shift = 0.5, decimals = 1 },
    { kind = "slider", profile = "light", key = "legacyRadius", label = "Legacy Radius", min = 1, max = 6, step = 0.5, shift = 0.5, decimals = 1 },
    { kind = "toggle", profile = "light", key = "samplingModeLegacy", label = "Legacy Sampling" },

    { kind = "section", label = "Base Visibility" },
    { kind = "slider", key = "ambientLight", label = "Ambient Light", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "fogIntensity", label = "Fog Intensity", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },

    { kind = "section", label = "Noise" },
    { kind = "slider", key = "noiseIntensity", label = "Noise Intensity", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "noiseCount", label = "Noise Count", min = 0, max = 500, step = 1, shift = 10, decimals = 0 },
    { kind = "slider", key = "noiseBrightnessThreshold", label = "Noise Threshold", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "noiseFrameInterval", label = "Noise Interval", min = 1, max = 10, step = 1, shift = 1, decimals = 0 },
    { kind = "slider", key = "noiseMinSize", label = "Noise Min Size", min = 1, max = 8, step = 1, shift = 1, decimals = 0 },
    { kind = "slider", key = "noiseMaxSize", label = "Noise Max Size", min = 1, max = 8, step = 1, shift = 1, decimals = 0 },
    { kind = "slider", key = "noiseR", label = "Noise R", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "noiseG", label = "Noise G", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "noiseB", label = "Noise B", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
}

local RIGHT_COLUMN_LAYOUT = {
    { kind = "section", label = "Toggles" },
    { kind = "toggle", key = "noiseEnabled", label = "Noise Enabled" },
    { kind = "toggle", key = "scanLinesEnabled", label = "Scan Lines Enabled" },
    { kind = "toggle", key = "flickerEnabled", label = "Flicker Enabled" },
    { kind = "toggle", key = "glareEnabled", label = "Glare Enabled" },
    { kind = "toggle", key = "glareRoomOnly", label = "Glare Room Only" },

    { kind = "section", label = "Vignette" },
    { kind = "slider", key = "vignetteSize", label = "Vignette Size", min = 0, max = 800, step = 5, shift = 25, decimals = 0 },
    { kind = "slider", key = "vignetteAlpha", label = "Vignette Alpha", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "vignetteLayers", label = "Vignette Layers", min = 1, max = 10, step = 1, shift = 1, decimals = 0 },

    { kind = "section", label = "Scan Lines" },
    { kind = "slider", key = "scanLineSpacing", label = "Line Spacing", min = 1, max = 12, step = 1, shift = 1, decimals = 0 },
    { kind = "slider", key = "scanLineAlpha", label = "Line Alpha", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },

    { kind = "section", label = "Flicker" },
    { kind = "slider", key = "flickerChance", label = "Flicker Chance", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "flickerIntensity", label = "Flicker Intensity", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },

    { kind = "section", label = "Glare" },
    { kind = "slider", key = "glareThreshold", label = "Glare Threshold", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "glareMaxAlpha", label = "Glare Max Alpha", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "glareBloomAlpha", label = "Glare Bloom", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "glareLayers", label = "Glare Layers", min = 1, max = 8, step = 1, shift = 1, decimals = 0 },
    { kind = "slider", key = "glareR", label = "Glare R", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "glareG", label = "Glare G", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
    { kind = "slider", key = "glareB", label = "Glare B", min = 0, max = 1, step = 0.01, shift = 0.05, decimals = 2 },
}

local FIELD_LOOKUP = {}
for _, layout in ipairs({ LEFT_COLUMN_LAYOUT, RIGHT_COLUMN_LAYOUT }) do
    for _, entry in ipairs(layout) do
        if entry.key then
            FIELD_LOOKUP[entry.key] = entry
        end
    end
end

local function cloneTable(source)
    local result = {}
    for key, value in pairs(source or {}) do
        result[key] = value
    end
    return result
end

local function roundToInt(value)
    return math.floor((tonumber(value) or 0) + 0.5)
end

local function formatValue(value, decimals)
    if decimals and decimals > 0 then
        return string.format("%." .. tostring(decimals) .. "f", tonumber(value) or 0)
    end

    return tostring(roundToInt(value))
end

local function resolveProfile(profile)
    if NV.Overlay and NV.Overlay.ResolveProfile then
        return NV.Overlay.ResolveProfile(profile)
    end

    return cloneTable(profile)
end

local function resolveLightProfile(profile)
    if NV.LightController and NV.LightController.ResolveProfile then
        return NV.LightController.ResolveProfile(profile)
    end

    return cloneTable(profile)
end

local function clonePreviewModeFlags(flags)
    return {
        usesDirectionalLight = flags and flags.usesDirectionalLight == true,
        usesPlayerPointLight = flags and flags.usesPlayerPointLight == true,
        usesVanillaIndoorLight = flags and flags.usesVanillaIndoorLight == true,
    }
end

local function isLightField(entry)
    return entry and entry.profile == "light"
end

local function getFieldProfileValue(entry, overlayProfile, lightProfile, key)
    if isLightField(entry) then
        if key == "samplingModeLegacy" then
            return (lightProfile.samplingMode or "sparse") == "legacy"
        end

        return lightProfile[key]
    end

    return overlayProfile[key]
end

local function getDebugModeId()
    if NV.Modes and NV.Modes.MODE_DEBUG then
        return NV.Modes.MODE_DEBUG
    end

    return "debug"
end

local function getVanillaModeId()
    if NV.Modes and NV.Modes.MODE_VANILLA then
        return NV.Modes.MODE_VANILLA
    end

    return "vanilla"
end

local function getEditorKeyCode()
    return (NV.Options and NV.Options.debugEditorKey and NV.Options.debugEditorKey())
        or (NV.Config and NV.Config.debugEditorBinding)
        or Keyboard.KEY_N
end

local function getEditorKeyName()
    local keyCode = getEditorKeyCode()
    if not keyCode or keyCode == Keyboard.KEY_NONE then
        return "Unbound"
    end

    if Keyboard and Keyboard.getKeyName then
        local keyName = Keyboard.getKeyName(keyCode)
        if keyName and keyName ~= "" then
            return keyName
        end
    end

    return tostring(keyCode)
end

local function getWindowTitle()
    return "NVFramework Debug Overlay Editor [" .. getEditorKeyName() .. "]"
end

local function ensureProfile()
    if not EDITOR._profile then
        EDITOR._profile = resolveProfile(EDITOR._defaultProfile)
    end

    return EDITOR._profile or {}
end

local function ensureLightProfile()
    if not EDITOR._lightProfile then
        EDITOR._lightProfile = resolveLightProfile(EDITOR._defaultLightProfile)
    end

    return EDITOR._lightProfile or {}
end

local function ensurePreviewModeFlags()
    if not EDITOR._previewModeFlags then
        EDITOR._previewModeFlags = clonePreviewModeFlags(EDITOR._defaultPreviewModeFlags)
    end

    return EDITOR._previewModeFlags or clonePreviewModeFlags(nil)
end

local function getModePresetEntries()
    local entries = {}
    if not (NV.Modes and NV.Modes.GetRegisteredModes) then
        return entries
    end

    local vanillaModeId = getVanillaModeId()

    for _, mode in ipairs(NV.Modes.GetRegisteredModes()) do
        if mode.id ~= vanillaModeId then
            table.insert(entries, {
                id = mode.id,
                label = mode.label or mode.id,
                hasOverlayProfile = mode.hasOverlayProfile == true,
                hasLightProfile = mode.hasLightProfile == true,
                usesDirectionalLight = mode.usesDirectionalLight == true,
                usesPlayerPointLight = mode.usesPlayerPointLight == true,
                usesVanillaIndoorLight = mode.usesVanillaIndoorLight == true,
            })
        end
    end

    return entries
end

local function applyProfileIfActive()
    if not EDITOR.IsDebugModeActive() then return end
    if not (NV.Overlay and NV.Overlay.ApplyProfile) then return end

    NV.Overlay.ApplyProfile(ensureProfile())
end

local function applyLightProfileIfActive()
    if not EDITOR.IsDebugModeActive() then return end
    if not (NV.LightController and NV.LightController.ApplyProfile) then return end

    NV.LightController.ApplyProfile(ensureLightProfile())
end

function EDITOR.IsDebugModeActive()
    return NV
        and NV.State
        and NV.State.isActive == true
        and NV.State.activeModeId == getDebugModeId()
end

function EDITOR.RegisterDefaultProfile(profile)
    EDITOR._defaultProfile = resolveProfile(profile)
    if not EDITOR._profile then
        EDITOR._profile = resolveProfile(profile)
    end
end

function EDITOR.RegisterDefaultLightProfile(profile)
    EDITOR._defaultLightProfile = resolveLightProfile(profile)
    if not EDITOR._lightProfile then
        EDITOR._lightProfile = resolveLightProfile(profile)
    end
end

function EDITOR.RegisterDefaultPreviewModeFlags(flags)
    EDITOR._defaultPreviewModeFlags = clonePreviewModeFlags(flags)
    if not EDITOR._previewModeFlags then
        EDITOR._previewModeFlags = clonePreviewModeFlags(flags)
    end
end

function EDITOR.GetProfile()
    return cloneTable(ensureProfile())
end

function EDITOR.GetLightProfile()
    return cloneTable(ensureLightProfile())
end

function EDITOR.GetPreviewModeFlags()
    return clonePreviewModeFlags(ensurePreviewModeFlags())
end

function EDITOR.SetLoadedState(overlayProfile, lightProfile, previewModeFlags)
    EDITOR._profile = resolveProfile(overlayProfile or EDITOR._defaultProfile)
    EDITOR._lightProfile = resolveLightProfile(lightProfile or EDITOR._defaultLightProfile)
    EDITOR._previewModeFlags = clonePreviewModeFlags(previewModeFlags or EDITOR._defaultPreviewModeFlags)

    applyLightProfileIfActive()
    applyProfileIfActive()

    if EDITOR.instance and EDITOR.instance.syncFromProfile then
        EDITOR.instance:syncFromProfile()
    end
end

function EDITOR.SetProfile(profile)
    EDITOR._profile = resolveProfile(profile)
    applyProfileIfActive()

    if EDITOR.instance and EDITOR.instance.syncFromProfile then
        EDITOR.instance:syncFromProfile()
    end
end

function EDITOR.SetFieldValue(key, value)
    local profile = ensureProfile()
    profile[key] = value
    applyProfileIfActive()

    if key == "noiseEnabled" and NV.Overlay and NV.Overlay.isActive and NV.Overlay.SyncLoopSound then
        NV.Overlay.SyncLoopSound()
    end
end

function EDITOR.SetLightFieldValue(key, value)
    local profile = ensureLightProfile()

    if key == "samplingModeLegacy" then
        profile.samplingMode = value and "legacy" or "sparse"
    else
        profile[key] = value
    end

    applyLightProfileIfActive()
end

function EDITOR.LoadModeProfile(modeId)
    if not (NV.Modes and NV.Modes.GetMode) then
        return false
    end

    local mode = NV.Modes.GetMode(modeId)
    if not mode then
        return false
    end

    local overlayProfile = NV.Modes.GetOverlayProfile and NV.Modes.GetOverlayProfile(modeId) or nil
    local lightProfile = NV.Modes.GetLightProfile and NV.Modes.GetLightProfile(modeId) or nil

    if not overlayProfile and not lightProfile then
        return false
    end

    EDITOR.SetLoadedState(
        overlayProfile or EDITOR.GetProfile(),
        lightProfile or EDITOR.GetLightProfile(),
        {
            usesDirectionalLight = mode.usesDirectionalLight == true,
            usesPlayerPointLight = mode.usesPlayerPointLight == true,
            usesVanillaIndoorLight = mode.usesVanillaIndoorLight == true,
        }
    )
    return true
end

function EDITOR.ResetProfile()
    EDITOR.SetLoadedState(EDITOR._defaultProfile, EDITOR._defaultLightProfile, EDITOR._defaultPreviewModeFlags)
end

function EDITOR.Close()
    if EDITOR.instance and EDITOR.instance.close then
        EDITOR.instance:close()
    end
end

function EDITOR.RefreshWindowTitle()
    if EDITOR.instance and EDITOR.instance.updateWindowTitle then
        EDITOR.instance:updateWindowTitle()
    end
end

local DebugOverlayWindow = ISCollapsableWindow:derive("DebugOverlayWindow")

function DebugOverlayWindow:addSectionLabel(x, y, text)
    local label = ISLabel:new(x, y, self.fontHgtMedium, text, 0.95, 0.98, 1.0, 1.0, UIFont.Medium, true)
    label:initialise()
    label:instantiate()
    self:addChild(label)
    return y + SECTION_ROW_H
end

function DebugOverlayWindow:addSliderRow(x, y, columnWidth, entry)
    local sliderWidth = columnWidth - LABEL_W - VALUE_W - VALUE_GAP

    local label = ISLabel:new(x, y, self.fontHgtSmall, entry.label, 1.0, 1.0, 1.0, 1.0, UIFont.Small, true)
    label:initialise()
    label:instantiate()
    self:addChild(label)

    local sliderX = x + LABEL_W
    local slider = ISSliderPanel:new(sliderX, y + 1, sliderWidth, SLIDER_H, self, self.onSliderChanged)
    slider:initialise()
    slider:instantiate()
    slider:setValues(entry.min, entry.max, entry.step, entry.shift or entry.step, true)
    slider.dataKey = entry.key
    slider.decimals = entry.decimals or 2
    self:addChild(slider)

    local valueLabel = ISLabel:new(sliderX + sliderWidth + VALUE_GAP, y, self.fontHgtSmall, "", 0.80, 1.0, 0.82, 1.0, UIFont.Small, true)
    valueLabel:initialise()
    valueLabel:instantiate()
    self:addChild(valueLabel)

    self.sliderControls[entry.key] = slider
    self.valueLabels[entry.key] = valueLabel

    return y + ROW_H
end

function DebugOverlayWindow:addToggleRow(x, y, columnWidth, entry)
    local tickBox = ISTickBox:new(x, y, columnWidth, 18, entry.label, self, self.onToggleChanged, entry.key)
    tickBox:initialise()
    tickBox:instantiate()
    tickBox:setFont(UIFont.Small)
    tickBox:addOption(entry.label, entry.key)
    tickBox.dataKey = entry.key
    tickBox:setWidth(columnWidth)
    self:addChild(tickBox)

    self.toggleControls[entry.key] = tickBox
    return y + ROW_H
end

function DebugOverlayWindow:buildColumn(x, startY, columnWidth, layout)
    local y = startY

    for _, entry in ipairs(layout) do
        if entry.kind == "section" then
            y = y + SECTION_GAP
            y = self:addSectionLabel(x, y, entry.label)
        elseif entry.kind == "slider" then
            y = self:addSliderRow(x, y, columnWidth, entry)
        elseif entry.kind == "toggle" then
            y = self:addToggleRow(x, y, columnWidth, entry)
        end
    end

    return y
end

function DebugOverlayWindow:updateValueLabel(key, value)
    local definition = FIELD_LOOKUP[key]
    local label = self.valueLabels[key]
    if not (definition and label) then return end

    label:setName(formatValue(value, definition.decimals or 2))
end

function DebugOverlayWindow:syncFromProfile()
    local overlayProfile = EDITOR.GetProfile()
    local lightProfile = EDITOR.GetLightProfile()

    for key, slider in pairs(self.sliderControls) do
        local definition = FIELD_LOOKUP[key]
        local value = getFieldProfileValue(definition, overlayProfile, lightProfile, key)
        if value == nil then
            value = slider.minValue
        end
        slider:setCurrentValue(value, true)
        self:updateValueLabel(key, value)
    end

    for key, tickBox in pairs(self.toggleControls) do
        local definition = FIELD_LOOKUP[key]
        local value = getFieldProfileValue(definition, overlayProfile, lightProfile, key) == true
        tickBox:setSelected(1, value)
    end
end

function DebugOverlayWindow:onSliderChanged(value, slider)
    if not slider or not slider.dataKey then return end

    local definition = FIELD_LOOKUP[slider.dataKey]
    local normalizedValue = value
    if definition and (definition.decimals or 0) == 0 then
        normalizedValue = roundToInt(value)
    end

    if isLightField(definition) then
        EDITOR.SetLightFieldValue(slider.dataKey, normalizedValue)
    else
        EDITOR.SetFieldValue(slider.dataKey, normalizedValue)
    end
    self:updateValueLabel(slider.dataKey, normalizedValue)
end

function DebugOverlayWindow:onToggleChanged(index, selected, key, unused, tickBox)
    if index ~= 1 then return end

    if (not key or key == "") and tickBox then
        if tickBox.getOptionData then
            key = tickBox:getOptionData(index)
        end
        if (not key or key == "") and tickBox.dataKey then
            key = tickBox.dataKey
        end
    end

    if not key then return end

    local definition = FIELD_LOOKUP[key]
    if isLightField(definition) then
        EDITOR.SetLightFieldValue(key, selected == true)
        return
    end

    EDITOR.SetFieldValue(key, selected == true)
end

function DebugOverlayWindow:onResetButton()
    EDITOR.ResetProfile()
    if self.selectModePreset then
        self:selectModePreset(getDebugModeId())
    end
    self:updateModePresetStatus("Reset to debug preset.")
end

function DebugOverlayWindow:selectModePreset(modeId)
    if not (self.modePresetCombo and modeId) then
        return false
    end

    for index = 1, self.modePresetCombo:getOptionCount() do
        local optionData = self.modePresetCombo:getOptionData(index)
        if optionData and optionData.id == modeId then
            self.modePresetCombo:setSelected(index)
            return true
        end
    end

    return false
end

function DebugOverlayWindow:getSelectedModePreset()
    if not self.modePresetCombo then
        return nil
    end

    local selectedIndex = self.modePresetCombo:getSelected()
    if not selectedIndex or selectedIndex < 1 then
        return nil
    end

    return self.modePresetCombo:getOptionData(selectedIndex)
end

function DebugOverlayWindow:updateModePresetStatus(message)
    if not self.modePresetStatusLabel then
        return
    end

    if message and message ~= "" then
        self.modePresetStatusLabel:setName(message)
        return
    end

    local preset = self:getSelectedModePreset()
    if not preset then
        self.modePresetStatusLabel:setName("Choose a registered mode preset.")
        return
    end

    if preset.hasOverlayProfile and preset.hasLightProfile then
        self.modePresetStatusLabel:setName("Selecting loads overlay and light from " .. preset.label .. ".")
        return
    end

    if preset.hasOverlayProfile then
        self.modePresetStatusLabel:setName("Selecting loads overlay settings from " .. preset.label .. ".")
        return
    end

    if preset.hasLightProfile then
        self.modePresetStatusLabel:setName("Selecting loads light settings from " .. preset.label .. ".")
        return
    end

    self.modePresetStatusLabel:setName(preset.label .. " has no importable preset.")
end

function DebugOverlayWindow:onPresetSelectionChanged(combo)
    local preset = self:getSelectedModePreset()
    if not preset then
        self:updateModePresetStatus("Choose a registered mode preset.")
        return
    end

    if not EDITOR.LoadModeProfile(preset.id) then
        self:updateModePresetStatus(preset.label .. " has no importable preset.")
        return
    end

    if preset.hasOverlayProfile and preset.hasLightProfile then
        self:updateModePresetStatus("Loaded overlay and light from " .. preset.label .. ".")
        return
    end

    if preset.hasOverlayProfile then
        self:updateModePresetStatus("Loaded overlay settings from " .. preset.label .. ".")
        return
    end

    self:updateModePresetStatus("Loaded light settings from " .. preset.label .. ".")
end

function DebugOverlayWindow:onCloseButton()
    self:close()
end

function DebugOverlayWindow:updateWindowTitle()
    self:setTitle(getWindowTitle())
end

function DebugOverlayWindow:createChildren()
    ISCollapsableWindow.createChildren(self)
    self:setResizable(false)
    self:updateWindowTitle()
    if self.closeButton then
        self.closeButton:setVisible(false)
    end

    self.fontHgtSmall = getTextManager():getFontHeight(UIFont.Small)
    self.fontHgtMedium = getTextManager():getFontHeight(UIFont.Medium)
    self.sliderControls = {}
    self.toggleControls = {}
    self.valueLabels = {}

    local contentX = MARGIN
    local contentY = self:titleBarHeight() + MARGIN
    local innerWidth = self.width - (MARGIN * 2)
    local columnWidth = math.floor((innerWidth - COLUMN_GAP) / 2)
    local leftX = contentX
    local rightX = contentX + columnWidth + COLUMN_GAP
    local toolbarY = contentY
    local presetComboX = contentX + innerWidth - PRESET_COMBO_W

    self.infoLabel = ISLabel:new(contentX, toolbarY + 4, self.fontHgtSmall,
        "Preset preview loads overlay and light settings.",
        0.8, 0.88, 0.96, 1.0, UIFont.Small, true)
    self.infoLabel:initialise()
    self.infoLabel:instantiate()
    self:addChild(self.infoLabel)

    self.modePresetCombo = ISComboBox:new(presetComboX, toolbarY, PRESET_COMBO_W, BUTTON_H, self, self.onPresetSelectionChanged)
    self.modePresetCombo:initialise()
    self.modePresetCombo:instantiate()
    self:addChild(self.modePresetCombo)

    self.modePresetEntries = getModePresetEntries()
    for index, entry in ipairs(self.modePresetEntries) do
        self.modePresetCombo:addOptionWithData(entry.label, entry)
        local option = self.modePresetCombo.options[index]
        if type(option) == "table" then
            if entry.hasOverlayProfile and entry.hasLightProfile then
                option.tooltip = "Load this mode's overlay and light presets into the debug editor preview."
            elseif entry.hasOverlayProfile then
                option.tooltip = "Load this mode's overlay preset into the debug editor."
            elseif entry.hasLightProfile then
                option.tooltip = "Load this mode's light preset into the debug preview."
            else
                option.tooltip = "This mode does not expose importable overlay or light presets."
            end
        end
        if entry.id == getDebugModeId() then
            self.modePresetCombo:setSelected(index)
        end
    end

    self.modePresetStatusLabel = ISLabel:new(contentX, toolbarY + BUTTON_H + 4, self.fontHgtSmall,
        "", 0.8, 1.0, 0.82, 1.0, UIFont.Small, true)
    self.modePresetStatusLabel:initialise()
    self.modePresetStatusLabel:instantiate()
    self:addChild(self.modePresetStatusLabel)
    self:updateModePresetStatus()

    local columnStartY = toolbarY + BUTTON_H + self.fontHgtSmall + NOTE_GAP + 8
    local leftBottomY = self:buildColumn(leftX, columnStartY, columnWidth, LEFT_COLUMN_LAYOUT)
    local rightBottomY = self:buildColumn(rightX, columnStartY, columnWidth, RIGHT_COLUMN_LAYOUT)
    local bottomY = math.max(leftBottomY, rightBottomY) + SECTION_GAP

    self.resetButton = ISButton:new(contentX, bottomY, BUTTON_W, BUTTON_H, "Reset Debug Preset", self, self.onResetButton)
    self.resetButton:initialise()
    self.resetButton:instantiate()
    self:addChild(self.resetButton)

    self.closeButtonEditor = ISButton:new(contentX + BUTTON_W + 10, bottomY, BUTTON_W, BUTTON_H, "Close", self, self.onCloseButton)
    self.closeButtonEditor:initialise()
    self.closeButtonEditor:instantiate()
    self:addChild(self.closeButtonEditor)

    self:setHeight(bottomY + BUTTON_H + MARGIN)
    self:syncFromProfile()
end

function DebugOverlayWindow:close()
    self:removeFromUIManager()
    if EDITOR.instance == self then
        EDITOR.instance = nil
    end
end

function DebugOverlayWindow:new(x, y, width, height)
    local o = ISCollapsableWindow:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.title = getWindowTitle()
    o.moveWithMouse = true
    o.isCollapsed = false
    o.collapseCounter = 0
    o.resizable = false
    o.drawFrame = true
    o.backgroundColor = { r = 0, g = 0, b = 0, a = 0.92 }
    o.borderColor = { r = 0.4, g = 0.4, b = 0.4, a = 1 }
    return o
end

function EDITOR.Toggle()
    if EDITOR.instance then
        EDITOR.Close()
        return true
    end

    if not EDITOR.IsDebugModeActive() then
        return false
    end

    local x = math.floor((getCore():getScreenWidth() - WINDOW_W) / 2)
    local y = math.max(40, math.floor((getCore():getScreenHeight() - WINDOW_H) / 2))

    local window = DebugOverlayWindow:new(x, y, WINDOW_W, WINDOW_H)
    window:initialise()
    window:instantiate()
    window:addToUIManager()
    EDITOR.instance = window
    return true
end