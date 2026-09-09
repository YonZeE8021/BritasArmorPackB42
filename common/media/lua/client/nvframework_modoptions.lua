--[[
    Night Vision Framework - Mod Options
    
    Per-client options registered in the in-game Mod Options panel (PZAPI).
    Values persist across sessions in Zomboid/Lua/ModOptions.ini.
    The selected NV mode is also stored by exact mode id in a dedicated
    NVFramework settings file so dynamic dropdown entries from external mods do
    not shift the saved selection.
    
    Options:
        NVMode  (combobox, default: single_light)
            single_light = omnidirectional room-scale point light (Brita pack default)
            custom  = NVFramework custom overlay + directional flashlight cone
            vanilla = Zomboid's built-in setWearingNightVisionGoggles()
        UseLegacyLightSampling  (tickbox, default: true)
            false = sparse cone sampling for lower FPS cost
            true  = legacy cone sampling for denser lighting on faster PCs
        ToggleKey  (keybind, default: Keyboard.KEY_V)
            Key code used to toggle night vision on/off.
        DebugEditorKey  (keybind, default: Keyboard.KEY_N)
            Key code used to open the debug overlay editor while the debug NV mode is active.
        EnableBaseSound  (tickbox, default: true)
            Whether to play the ambient NV hum loop while NV is active.
        BaseSoundVolume  (slider 0.0-1.0, default: 0.3)
            Volume of the ambient NV hum loop.
        ToggleSoundVolume  (slider 0.0-1.0, default: 0.6)
            Volume of the NV on/off toggle one-shot sounds.
--]]

NV = NV or {}
NV.Options = NV.Options or {}

require "NVFramework_Modes"

local OPT = NV.Options

local function tr(key, fallback)
    if getText then
        local translated = getText(key)
        if translated and translated ~= "" and translated ~= key then
            return translated
        end
    end
    return fallback
end

local MODE_LABEL_KEYS = {
    vanilla = "UI_NVFramework_Mode_Vanilla",
    single_light = "UI_NVFramework_Mode_SingleLight",
    single_light_glare = "UI_NVFramework_Mode_SingleLightGlare",
    nvframework_phosphor = "UI_NVFramework_Mode_Phosphor",
    nvframework_phosphor_overlay = "UI_NVFramework_Mode_PhosphorOverlay",
    nvframework_phosphor_glare_overlay = "UI_NVFramework_Mode_PhosphorGlareOverlay",
    custom = "UI_NVFramework_Mode_Custom",
    custom_glare = "UI_NVFramework_Mode_CustomGlare",
    debug = "UI_NVFramework_Mode_Debug",
}

local function getLocalizedModeLabel(modeId, fallback)
    local key = MODE_LABEL_KEYS[tostring(modeId or "")]
    if key then
        return tr(key, fallback)
    end
    return fallback
end

OPT.MOD_OPTIONS_ID = "NVFramework"
OPT.NV_MODE_ID_STORAGE_TYPE = "nvmode"
OPT.NV_MODE_ID_OPTION = "NVModeId"
OPT.NV_MODE_SETTINGS_FILE = "NVFramework_ClientOptions.ini"
OPT.NV_MODE_SETTINGS_KEY = "NVModeId"
OPT.NV_MODE_CUSTOM = (NV.Modes and NV.Modes.MODE_CUSTOM) or "custom"
OPT.NV_MODE_VANILLA = (NV.Modes and NV.Modes.MODE_VANILLA) or "vanilla"
OPT.NV_MODE_SINGLE_LIGHT = (NV.Modes and NV.Modes.MODE_SINGLE_LIGHT) or "single_light"
OPT.NV_MODE_DEFAULT = OPT.NV_MODE_SINGLE_LIGHT
OPT.NV_MODE_OPTIONS = OPT.NV_MODE_OPTIONS or {}
OPT._modeCombo = OPT._modeCombo or nil
OPT._modeComboBaseWidth = OPT._modeComboBaseWidth or nil
OPT._modeComboElement = OPT._modeComboElement or nil
OPT._pendingModeIndex = OPT._pendingModeIndex or nil
OPT._modeBootstrapResolved = OPT._modeBootstrapResolved or false
OPT._modeBootstrapEventHooked = OPT._modeBootstrapEventHooked or false
OPT._mainOptionsHookInstalled = OPT._mainOptionsHookInstalled or false

local MODE_COMBO_WIDTH_SCALE = 1.20
local shouldRegisterDebugEditorOption

-- Live value -- updated immediately when player changes setting in Options panel
OPT._nvMode          = OPT._nvMode or OPT.NV_MODE_DEFAULT or OPT.NV_MODE_SINGLE_LIGHT or OPT.NV_MODE_CUSTOM
OPT._toggleKey       = (OPT._toggleKey       ~= nil) and OPT._toggleKey       or Keyboard.KEY_V
OPT._debugEditorKey  = (OPT._debugEditorKey  ~= nil) and OPT._debugEditorKey  or Keyboard.KEY_N
OPT._useLegacyLightSampling = (OPT._useLegacyLightSampling ~= nil) and OPT._useLegacyLightSampling or true
OPT._enableBaseSound   = (OPT._enableBaseSound   ~= nil) and OPT._enableBaseSound   or true
OPT._baseSoundVolume   = (OPT._baseSoundVolume   ~= nil) and OPT._baseSoundVolume   or 0.3
OPT._toggleSoundVolume = (OPT._toggleSoundVolume ~= nil) and OPT._toggleSoundVolume or 0.6

local function refreshRegisteredModeCache()
    OPT.NV_MODE_CUSTOM = (NV.Modes and NV.Modes.MODE_CUSTOM) or OPT.NV_MODE_CUSTOM or "custom"
    OPT.NV_MODE_VANILLA = (NV.Modes and NV.Modes.MODE_VANILLA) or OPT.NV_MODE_VANILLA or "vanilla"
    OPT.NV_MODE_OPTIONS = {}

    local modes = (NV.Modes and NV.Modes.GetRegisteredModes and NV.Modes.GetRegisteredModes()) or {}
    for _, mode in ipairs(modes) do
        table.insert(OPT.NV_MODE_OPTIONS, {
            id = mode.id,
            label = getLocalizedModeLabel(mode.id, mode.label),
            source = mode.source,
            priority = mode.priority,
        })
    end

    if #OPT.NV_MODE_OPTIONS == 0 then
        table.insert(OPT.NV_MODE_OPTIONS, {
            id = OPT.NV_MODE_CUSTOM,
            label = getLocalizedModeLabel(
                OPT.NV_MODE_CUSTOM,
                "NVFramework Custom Overlay + Light Cone"
            ),
        })
    end
end

local function getModeSettingsLine(modeId)
    return OPT.NV_MODE_SETTINGS_KEY .. "=" .. tostring(modeId or "")
end

local function parseModeSettingsLine(line)
    if type(line) ~= "string" then return nil end

    local prefix = OPT.NV_MODE_SETTINGS_KEY .. "="
    if string.sub(line, 1, #prefix) ~= prefix then
        return nil
    end

    local modeId = string.sub(line, #prefix + 1)
    if modeId == "" then
        return nil
    end

    return modeId
end

local function saveModeIdToSettingsFile(modeId)
    if not getFileWriter then
        return false
    end

    local file = getFileWriter(OPT.NV_MODE_SETTINGS_FILE, true, false)
    if not file then
        return false
    end

    file:write(getModeSettingsLine(modeId) .. "\r\n")
    file:close()
    return true
end

local function loadModeIdFromSettingsFile()
    if not getFileReader then
        return nil
    end

    local file = getFileReader(OPT.NV_MODE_SETTINGS_FILE, true)
    if not file then
        return nil
    end

    local savedModeId = nil

    while true do
        local line = file:readLine()
        if not line then break end

        savedModeId = parseModeSettingsLine(line)
        if savedModeId then
            break
        end
    end

    file:close()
    return savedModeId
end

local function normalizeModeId(modeId)
    local resolvedModeId = nil
    local fallback = OPT.NV_MODE_DEFAULT or OPT.NV_MODE_SINGLE_LIGHT or OPT.NV_MODE_CUSTOM

    if NV.Modes and NV.Modes.ResolveModeId then
        resolvedModeId = NV.Modes.ResolveModeId(modeId) or fallback
    else
        resolvedModeId = modeId or fallback
    end

    -- Brita pack preference: cone "flashlight" modes map to room-scale point light.
    if resolvedModeId == OPT.NV_MODE_CUSTOM or resolvedModeId == "custom_glare" then
        resolvedModeId = OPT.NV_MODE_SINGLE_LIGHT or "single_light"
    end

    return resolvedModeId
end

refreshRegisteredModeCache()

local function applyModeComboWidth()
    local modeCombo = OPT._modeCombo
    local element = modeCombo and modeCombo.element or nil
    if not element then
        return false
    end

    if OPT._modeComboElement ~= element then
        OPT._modeComboElement = element
        if element.getWidth then
            OPT._modeComboBaseWidth = element:getWidth()
        else
            OPT._modeComboBaseWidth = element.width
        end
    elseif not OPT._modeComboBaseWidth then
        if element.getWidth then
            OPT._modeComboBaseWidth = element:getWidth()
        else
            OPT._modeComboBaseWidth = element.width
        end
    end

    local baseWidth = tonumber(OPT._modeComboBaseWidth)
    if not baseWidth then
        return false
    end

    local targetWidth = math.floor((baseWidth * MODE_COMBO_WIDTH_SCALE) + 0.5)
    if element.setWidth then
        element:setWidth(targetWidth)
    else
        element.width = targetWidth
    end

    return true
end

local function installMainOptionsHook()
    if OPT._mainOptionsHookInstalled then
        return true
    end

    local mainOptionsClass = rawget(_G, "MainOptions")
    if not (mainOptionsClass and mainOptionsClass.addModOptionsPanel) then
        pcall(require, "OptionScreens/MainOptions")
        mainOptionsClass = rawget(_G, "MainOptions")
    end

    if not (mainOptionsClass and mainOptionsClass.addModOptionsPanel) then
        return false
    end

    if mainOptionsClass._nvFrameworkModeWidthHookInstalled then
        OPT._mainOptionsHookInstalled = true
        return true
    end

    local originalAddModOptionsPanel = mainOptionsClass.addModOptionsPanel
    mainOptionsClass.addModOptionsPanel = function(self, ...)
        local result = originalAddModOptionsPanel(self, ...)
        -- B42.20 uses the localized label as the lookup identity in
        -- keyPressHandler, but sets btn.internal to the untranslated name.
        -- Repair only our two widgets, after vanilla has created the labels.
        -- Keep option.name as a translation key (do not restore double getText).
        local options = PZAPI and PZAPI.ModOptions
            and PZAPI.ModOptions:getOptions(OPT.MOD_OPTIONS_ID)
        if options then
            for _, id in ipairs({ "ToggleKey", "DebugEditorKey" }) do
                local option = options:getOption(id)
                local entry = option and option.element
                if entry and entry.btn and entry.txt and entry.txt.getName then
                    entry.btn.internal = entry.txt:getName()
                end
            end
        end
        OPT.RefreshModeOptions()
        applyModeComboWidth()
        return result
    end

    mainOptionsClass._nvFrameworkModeWidthHookInstalled = true
    OPT._mainOptionsHookInstalled = true
    return true
end

local function isDebugModeEnabled()
    local isDebugEnabledFunc = rawget(_G, "isDebugEnabled")
    if isDebugEnabledFunc then
        return isDebugEnabledFunc() == true
    end

    local getDebugFunc = rawget(_G, "getDebug")
    if getDebugFunc then
        return getDebugFunc() == true
    end

    local getCoreFunc = rawget(_G, "getCore")
    local core = getCoreFunc and getCoreFunc() or nil
    if core and core.getDebug then
        return core:getDebug() == true
    end

    return false
end

local function isNonMultiplayerContext()
    local isServerFunc = rawget(_G, "isServer")
    if isServerFunc and isServerFunc() then
        return false
    end

    local isClientFunc = rawget(_G, "isClient")
    if isClientFunc and isClientFunc() then
        return false
    end

    local isMultiplayerFunc = rawget(_G, "isMultiplayer")
    if isMultiplayerFunc and isMultiplayerFunc() then
        return false
    end

    return true
end

shouldRegisterDebugEditorOption = function()
    return isDebugModeEnabled() and isNonMultiplayerContext()
end

function OPT.IsDebugAuthoringAvailable()
    return shouldRegisterDebugEditorOption()
end

local function removeOption(options, optionId)
    if not options or not optionId then
        return false
    end

    local option = options:getOption(optionId)
    if not option then
        return false
    end

    if options.data then
        for index = #options.data, 1, -1 do
            local entry = options.data[index]
            if entry == option or (entry and entry.id == optionId) then
                table.remove(options.data, index)
            end
        end
    end

    if options.dict then
        options.dict[optionId] = nil
    end

    return true
end

local getModeIndex

getModeIndex = function(modeId)
    refreshRegisteredModeCache()

    for index, mode in ipairs(OPT.NV_MODE_OPTIONS) do
        if mode.id == normalizeModeId(modeId) then
            return index
        end
    end

    return 1
end

local function getModeId(index)
    refreshRegisteredModeCache()

    local mode = OPT.NV_MODE_OPTIONS[index]
    return mode and mode.id or normalizeModeId(OPT._nvMode)
end

local function getRuntimeSelectedModeId()
    if not OPT._modeBootstrapResolved then
        return nil
    end

    if not (PZAPI and PZAPI.ModOptions) then
        return nil
    end

    local options = PZAPI.ModOptions:getOptions(OPT.MOD_OPTIONS_ID)
    if not options then
        return nil
    end

    local modeOption = options:getOption("NVMode")
    if not modeOption then
        return nil
    end

    local selectedIndex = tonumber(modeOption.selected)
    if not selectedIndex and modeOption.getValue then
        selectedIndex = tonumber(modeOption:getValue())
    end
    if not selectedIndex then
        return nil
    end

    return getModeId(selectedIndex)
end

local function setSelectedModeId(modeId, persist)
    local requestedModeId = tostring(modeId or "")
    if requestedModeId == "" then
        requestedModeId = OPT.NV_MODE_CUSTOM
    end

    local resolvedModeId = normalizeModeId(requestedModeId)
    OPT._nvMode = resolvedModeId
    OPT._pendingModeIndex = nil
    local modeCombo = OPT._modeCombo
    if modeCombo then
        modeCombo.selected = getModeIndex(resolvedModeId)
        if modeCombo.element then
            modeCombo.element.selected = modeCombo.selected
        end
    end

    if persist ~= false then
        saveModeIdToSettingsFile(resolvedModeId)
    end

    return resolvedModeId
end

-- --- Accessor ----------------------------------------------------------------
-- `nvMode()` returns the currently applied mode id tracked by this module.
-- The sound and keybind accessors read from PZAPI at call time when available,
-- then fall back to the values bootstrapped from ModOptions.ini at startup.

function OPT.nvMode()
    local runtimeModeId = getRuntimeSelectedModeId()
    if runtimeModeId then
        local resolvedRuntimeModeId = normalizeModeId(runtimeModeId)
        if OPT._nvMode ~= resolvedRuntimeModeId or runtimeModeId ~= resolvedRuntimeModeId then
            OPT._nvMode = resolvedRuntimeModeId
            saveModeIdToSettingsFile(resolvedRuntimeModeId)
        end
        return resolvedRuntimeModeId
    end

    local resolvedStoredModeId = normalizeModeId(OPT._nvMode)
    if OPT._nvMode ~= resolvedStoredModeId then
        OPT._nvMode = resolvedStoredModeId
        saveModeIdToSettingsFile(resolvedStoredModeId)
    end

    return resolvedStoredModeId
end

function OPT.isMode(modeId)
    return OPT.nvMode() == normalizeModeId(modeId)
end

function OPT.useVanillaNV()
    return OPT.isMode(OPT.NV_MODE_VANILLA)
end

function OPT.toggleKey()
    if PZAPI and PZAPI.ModOptions then
        local opts = PZAPI.ModOptions:getOptions(OPT.MOD_OPTIONS_ID)
        if opts then
            local opt = opts:getOption("ToggleKey")
            if opt then return opt:getValue() end
        end
    end
    return OPT._toggleKey
end

function OPT.debugEditorKey()
    if PZAPI and PZAPI.ModOptions then
        local opts = PZAPI.ModOptions:getOptions(OPT.MOD_OPTIONS_ID)
        if opts then
            local opt = opts:getOption("DebugEditorKey")
            if opt then return opt:getValue() end
        end
    end
    return OPT._debugEditorKey
end

function OPT.enableBaseSound()
    if PZAPI and PZAPI.ModOptions then
        local opts = PZAPI.ModOptions:getOptions(OPT.MOD_OPTIONS_ID)
        if opts then
            local opt = opts:getOption("EnableBaseSound")
            if opt then return opt:getValue() end
        end
    end
    return OPT._enableBaseSound
end

function OPT.baseSoundVolume()
    if PZAPI and PZAPI.ModOptions then
        local opts = PZAPI.ModOptions:getOptions(OPT.MOD_OPTIONS_ID)
        if opts then
            local opt = opts:getOption("BaseSoundVolume")
            if opt then return opt:getValue() end
        end
    end
    return OPT._baseSoundVolume
end

function OPT.toggleSoundVolume()
    if PZAPI and PZAPI.ModOptions then
        local opts = PZAPI.ModOptions:getOptions(OPT.MOD_OPTIONS_ID)
        if opts then
            local opt = opts:getOption("ToggleSoundVolume")
            if opt then return opt:getValue() end
        end
    end
    return OPT._toggleSoundVolume
end

function OPT.useLegacyLightSampling()
    if PZAPI and PZAPI.ModOptions then
        local opts = PZAPI.ModOptions:getOptions(OPT.MOD_OPTIONS_ID)
        if opts then
            local opt = opts:getOption("UseLegacyLightSampling")
            if opt then return opt:getValue() end
        end
    end
    return OPT._useLegacyLightSampling
end

function OPT.availableModes()
    refreshRegisteredModeCache()

    local result = {}
    for index, mode in ipairs(OPT.NV_MODE_OPTIONS) do
        result[index] = mode
    end
    return result
end

function OPT.RefreshModeOptions()
    refreshRegisteredModeCache()

    local modeCombo = OPT._modeCombo
    if not modeCombo then
        return false
    end

    local selectedModeId = OPT.nvMode()
    modeCombo.values = {}
    modeCombo.selected = 1

    for _, mode in ipairs(OPT.NV_MODE_OPTIONS) do
        -- Labels are localized above. PZAPI.addItem would translate them again.
        table.insert(modeCombo.values, mode.label)
    end

    modeCombo.selected = getModeIndex(selectedModeId)

    local element = modeCombo.element
    if element then
        if element.clear then
            element:clear()
        else
            element.options = {}
        end

        for _, mode in ipairs(OPT.NV_MODE_OPTIONS) do
            if element.addOption then
                element:addOption(mode.label)
            elseif element.options then
                table.insert(element.options, mode.label)
            end
        end

        element.selected = modeCombo.selected
    end

    applyModeComboWidth()

    return true
end

-- --- Bootstrap from ModOptions.ini -------------------------------------------
-- Runs before PZAPI loads so the value is correct from the very first frame.

local function loadSaved()
    local savedModeId = loadModeIdFromSettingsFile()
    local savedModeIndex = nil
    local legacyUseVanillaNV = nil

    if not getFileReader then
        if savedModeId then
            OPT._nvMode = normalizeModeId(savedModeId)
        end
        return
    end

    local file = getFileReader("ModOptions.ini", true)
    if not file then
        if savedModeId then
            OPT._nvMode = normalizeModeId(savedModeId)
        end
        return
    end

    while true do
        local line = file:readLine()
        if not line then break end
        -- Format written by PZAPI: type|modID|optionID|value
        local t = luautils and luautils.split(line, "|")
        if t and t[2] == OPT.MOD_OPTIONS_ID then
            if not savedModeId and t[1] == OPT.NV_MODE_ID_STORAGE_TYPE and t[3] == OPT.NV_MODE_ID_OPTION and t[4] and t[4] ~= "" then
                savedModeId = t[4]
            end
            if not savedModeId and t[1] == "combobox" and t[3] == "NVMode" and tonumber(t[4]) then
                savedModeIndex = tonumber(t[4])
            end
            if t[1] == "tickbox" and t[3] == "UseVanillaNV" then
                if t[4] == "true"  then legacyUseVanillaNV = true  end
                if t[4] == "false" then legacyUseVanillaNV = false end
            end
            if t[1] == "keybind" and t[3] == "ToggleKey" and tonumber(t[4]) then
                OPT._toggleKey = tonumber(t[4])
            end
            if t[1] == "keybind" and t[3] == "DebugEditorKey" and tonumber(t[4]) then
                OPT._debugEditorKey = tonumber(t[4])
            end
            if t[1] == "tickbox" and t[3] == "UseLegacyLightSampling" then
                if t[4] == "true"  then OPT._useLegacyLightSampling = true  end
                if t[4] == "false" then OPT._useLegacyLightSampling = false end
            end
            if t[1] == "tickbox" and t[3] == "EnableBaseSound" then
                if t[4] == "true"  then OPT._enableBaseSound = true  end
                if t[4] == "false" then OPT._enableBaseSound = false end
            end
            if t[1] == "slider" and t[3] == "BaseSoundVolume" and tonumber(t[4]) then
                OPT._baseSoundVolume = tonumber(t[4])
            end
            if t[1] == "slider" and t[3] == "ToggleSoundVolume" and tonumber(t[4]) then
                OPT._toggleSoundVolume = tonumber(t[4])
            end
        end
    end
    file:close()

    if savedModeId then
        OPT._nvMode = normalizeModeId(savedModeId)
    elseif savedModeIndex then
        OPT._pendingModeIndex = savedModeIndex
    elseif legacyUseVanillaNV ~= nil then
        OPT._nvMode = legacyUseVanillaNV and OPT.NV_MODE_VANILLA or (OPT.NV_MODE_DEFAULT or OPT.NV_MODE_SINGLE_LIGHT)
    else
        OPT._nvMode = OPT.NV_MODE_DEFAULT or OPT.NV_MODE_SINGLE_LIGHT or OPT.NV_MODE_CUSTOM
    end
end

loadSaved()

if NV.Config then
    NV.Config.keyBinding = OPT._toggleKey
    NV.Config.debugEditorBinding = OPT._debugEditorKey
end

local function finalizePendingSavedModeIndex()
    local pendingModeIndex = tonumber(OPT._pendingModeIndex)
    if not pendingModeIndex then
        return false
    end

    OPT._pendingModeIndex = nil
    setSelectedModeId(getModeId(pendingModeIndex), true)
    return true
end

local function finalizeBootstrappedModeSelection()
    if OPT._modeBootstrapResolved then
        return
    end

    OPT._modeBootstrapResolved = true

    if finalizePendingSavedModeIndex() then
        return
    end

    saveModeIdToSettingsFile(OPT._nvMode)
end

-- --- PZAPI registration ------------------------------------------------------

local _registered = false

local function applyToggleKeyOption(value)
    OPT._toggleKey = value
    if NV.Config then
        NV.Config.keyBinding = value
    end
end

local function applyDebugEditorKeyOption(value)
    OPT._debugEditorKey = value
    if NV.Config then
        NV.Config.debugEditorBinding = value
    end
    if NV.DebugOverlayEditor and NV.DebugOverlayEditor.RefreshWindowTitle then
        NV.DebugOverlayEditor.RefreshWindowTitle()
    end
end

local function refreshActiveDirectionalLights()
    if not (NV.State and NV.State.isActive) then
        return
    end

    local activeModeId = (NV.State and NV.State.activeModeId) or OPT.nvMode()
    local activeMode = NV.Modes and NV.Modes.GetMode and NV.Modes.GetMode(activeModeId) or nil
    if not (activeMode and activeMode.usesDirectionalLight) then
        return
    end

    require "NVFramework_LightController"

    local debugModeId = (NV.Modes and NV.Modes.MODE_DEBUG) or "debug"
    local lightProfile = nil
    if activeModeId == debugModeId and NV.DebugOverlayEditor and NV.DebugOverlayEditor.GetLightProfile then
        lightProfile = NV.DebugOverlayEditor.GetLightProfile()
    elseif NV.Modes and NV.Modes.GetLightProfile then
        lightProfile = NV.Modes.GetLightProfile(activeModeId)
    end

    if NV.LightController and NV.LightController.ApplyProfile then
        NV.LightController.ApplyProfile(lightProfile)
        if NV.LightController.Enable then
            NV.LightController.Enable()
        end
    end
end

local function applyLegacyLightSamplingOption(value)
    OPT._useLegacyLightSampling = value == true
    refreshActiveDirectionalLights()
end

local function ensureLightSamplingOption(options)
    local lightSamplingTick = options:getOption("UseLegacyLightSampling")
    if not lightSamplingTick then
        -- PZAPI stores translation keys here. MainOptions resolves them while
        -- constructing the panel; passing an already translated string makes
        -- it call getText() a second time. A localized label containing a
        -- literal '%' can then be misread as a Java format conversion.
        lightSamplingTick = options:addTickBox(
            "UseLegacyLightSampling",
            "UI_NVFramework_LegacySampling",
            OPT._useLegacyLightSampling,
            "UI_NVFramework_LegacySampling_Tooltip"
        )
    end

    if lightSamplingTick then
        lightSamplingTick.onChangeApply = function(self, value)
            applyLegacyLightSamplingOption(value)
        end
    end

    return lightSamplingTick
end

local function ensureToggleSoundVolumeOption(options)
    local toggleVolSlider = options:getOption("ToggleSoundVolume")
    if not toggleVolSlider then
        toggleVolSlider = options:addSlider(
            "ToggleSoundVolume",
            "UI_NVFramework_ToggleSoundVolume",
            0.0, 1.0, 0.05,
            OPT._toggleSoundVolume,
            "UI_NVFramework_ToggleSoundVolume_Tooltip"
        )
    end

    if toggleVolSlider then
        toggleVolSlider.onChangeApply = function(self, value)
            OPT._toggleSoundVolume = value
        end
    end

    return toggleVolSlider
end

local function ensureKeyBindOptions(options)
    local bind = options:getOption("ToggleKey")
    if not bind then
        bind = options:addKeyBind(
            "ToggleKey",
            "UI_NVFramework_ToggleKey",
            OPT._toggleKey,
            "UI_NVFramework_ToggleKey_Tooltip"
        )
    end
    if bind then
        bind.onChangeApply = function(self, value)
            applyToggleKeyOption(value)
        end
    end

    if not shouldRegisterDebugEditorOption() then
        removeOption(options, "DebugEditorKey")
        return
    end

    local debugBind = options:getOption("DebugEditorKey")
    if not debugBind then
        debugBind = options:addKeyBind(
            "DebugEditorKey",
            "UI_NVFramework_DebugEditorKey",
            OPT._debugEditorKey,
            "UI_NVFramework_DebugEditorKey_Tooltip"
        )
    end
    if debugBind then
        debugBind.onChangeApply = function(self, value)
            applyDebugEditorKeyOption(value)
        end
    end
end

local OPTION_TRANSLATION_KEYS = {
    NVMode = { "UI_NVFramework_Mode", "UI_NVFramework_Mode_Tooltip" },
    UseLegacyLightSampling = {
        "UI_NVFramework_LegacySampling",
        "UI_NVFramework_LegacySampling_Tooltip",
    },
    EnableBaseSound = {
        "UI_NVFramework_EnableBaseSound",
        "UI_NVFramework_EnableBaseSound_Tooltip",
    },
    BaseSoundVolume = {
        "UI_NVFramework_BaseSoundVolume",
        "UI_NVFramework_BaseSoundVolume_Tooltip",
    },
    ToggleSoundVolume = {
        "UI_NVFramework_ToggleSoundVolume",
        "UI_NVFramework_ToggleSoundVolume_Tooltip",
    },
    ToggleKey = { "UI_NVFramework_ToggleKey", "UI_NVFramework_ToggleKey_Tooltip" },
    DebugEditorKey = {
        "UI_NVFramework_DebugEditorKey",
        "UI_NVFramework_DebugEditorKey_Tooltip",
    },
}

local function normalizeModOptionTranslationKeys(options)
    if not options then
        return
    end

    options.name = "UI_NVFramework_Title"

    for optionId, keys in pairs(OPTION_TRANSLATION_KEYS) do
        local option = options:getOption(optionId)
        if option then
            option.name = keys[1]
            option.tooltip = keys[2]
        end
    end

    -- Also repairs an options table left in memory by a Lua hot reload of an
    -- older build, so testing the patch does not require rebuilding the table.
    if options.data then
        for _, option in ipairs(options.data) do
            if option and option.type == "title" then
                option.name = "UI_NVFramework_Title"
            end
        end
    end
end

local function registerModOptions()
    if _registered then return end
    if not (PZAPI and PZAPI.ModOptions and PZAPI.ModOptions.create) then return end

    local options = PZAPI.ModOptions:getOptions(OPT.MOD_OPTIONS_ID)
    if not options then
        options = PZAPI.ModOptions:create(
            OPT.MOD_OPTIONS_ID,
            "UI_NVFramework_Title"
        )
    end
    if not options then return end

    normalizeModOptionTranslationKeys(options)

    -- Hot-reload / double-init guard
    if options:getOption("NVMode") then
        OPT._modeCombo = options:getOption("NVMode")
        OPT.RefreshModeOptions()
        applyModeComboWidth()
        ensureKeyBindOptions(options)
        ensureLightSamplingOption(options)
        ensureToggleSoundVolumeOption(options)

        _registered = true
        return
    end

    options:addTitle("UI_NVFramework_Title")

    local modeCombo = options:addComboBox(
        "NVMode",
        "UI_NVFramework_Mode",
        "UI_NVFramework_Mode_Tooltip"
    )
    OPT._modeCombo = modeCombo
    OPT.RefreshModeOptions()
    applyModeComboWidth()
    modeCombo.onChangeApply = function(self, value)
        local newMode = getModeId(tonumber(value) or self:getValue())
        local previousMode = OPT.nvMode()
        local resolvedMode = setSelectedModeId(newMode, true)

        -- If NV is currently active and the mode just changed, swap systems live
        if NV.State and NV.State.isActive and (resolvedMode ~= previousMode) then
            local player = getPlayer()

            if player and NV.ApplyLocalNightVisionState then
                NV.ApplyLocalNightVisionState(player, true, {
                    playSound = false,
                    force = true,
                    modeId = resolvedMode,
                })
            end
        end
    end

    ensureLightSamplingOption(options)

    options:addSeparator()

    local soundTick = options:addTickBox(
        "EnableBaseSound",
        "UI_NVFramework_EnableBaseSound",
        OPT._enableBaseSound,
        "UI_NVFramework_EnableBaseSound_Tooltip"
    )
    soundTick.onChangeApply = function(self, value)
        OPT._enableBaseSound = value
        -- If NV is active, start or stop the loop immediately
        if NV.State and NV.State.isActive then
            require "NVFramework_Overlay"
            if NV.Overlay and NV.Overlay.SyncLoopSound then
                NV.Overlay.SyncLoopSound()
            end
        end
    end

    local volSlider = options:addSlider(
        "BaseSoundVolume",
        "UI_NVFramework_BaseSoundVolume",
        0.0, 1.0, 0.05,
        OPT._baseSoundVolume,
        "UI_NVFramework_BaseSoundVolume_Tooltip"
    )
    volSlider.onChangeApply = function(self, value)
        OPT._baseSoundVolume = value
        -- Apply immediately to the running loop if active
        if NV.Overlay and NV.Overlay._loopSoundHandle then
            local player = getSpecificPlayer(0)
            if player then
                player:getEmitter():setVolume(NV.Overlay._loopSoundHandle, value)
            end
        end
    end

    ensureToggleSoundVolumeOption(options)

    ensureKeyBindOptions(options)

    _registered = true
end

if Events and Events.OnGameBoot and not OPT._modeBootstrapEventHooked then
    Events.OnGameBoot.Add(finalizeBootstrappedModeSelection)
    OPT._modeBootstrapEventHooked = true
end

pcall(require, "PZAPI/ModOptions")
registerModOptions()
installMainOptionsHook()

print("[NV] ModOptions loaded")
