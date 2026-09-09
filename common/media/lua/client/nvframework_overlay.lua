--[[
    NV Overlay - Pure Tint Patch
    
    Removes brightness amplification from the NV overlay.
    Only applies green color tint without illuminating dark areas.
    Relies on the directional light cone from NV_LightController for actual illumination.
    
    Installation:
    Replace the original NV_Overlay.lua with this file, or copy the modified
    sections to the original file.
    
    Changes:
    - Removed brightness boost layer in render()
    - Reduced ClimateManager ambient light to 0.0 (no brightness boost)
    - Reduced interior color values to pure tint (no extra brightness)
    - Removed the 40-radius ambient light (nvLight)
    - Kept only green color tint overlay
--]]

require "ISUI/ISPanel"

NV = NV or {}
NV.Overlay = NV.Overlay or {}

-- Configuration
NV.Overlay.Config = {
    -- === MAIN TINT SETTINGS (No Brightness Boost) ===
    overlayR = 0.0,                -- Main overlay red tint (0-1)
    overlayG = 0.9,                -- Main overlay green tint (0-1)
    overlayB = 0.0,                -- Main overlay blue tint (0-1)
    greenIntensity = 0.9,          -- Legacy alias retained for green-profile compatibility
    overlayAlpha = 0.2,            -- Overall overlay transparency (0-1)
    useClimateTint = true,         -- Apply ClimateManager tint/admin overrides
    
    -- ClimateManager Color Tint (TINT ONLY - NO BRIGHTNESS)
    exteriorR = 0.0,               -- Exterior red tint (0-1)
    exteriorG = 0.7,               -- Exterior green tint (0-1)
    exteriorB = 0.0,               -- Exterior blue tint (0-1)
    exteriorAlpha = 0.6,           -- Exterior alpha (0-1)
    
    interiorR = 0.0,               -- Interior red tint (NO BRIGHTNESS)
    interiorG = 0.7,               -- Interior green tint (NO BRIGHTNESS)
    interiorB = 0.0,               -- Interior blue tint (NO BRIGHTNESS)
    interiorAlpha = 0.6,           -- Interior alpha (0-1)
    
    -- === LIGHTING SETTINGS (NO BOOST) ===
    ambientLight = 0.0,            -- NO ambient light boost - rely on light cone only
    fogIntensity = 0.0,            -- Fog intensity (0-1)
    
    -- === NOISE SETTINGS ===
    noiseEnabled = true,           -- Enable film grain effect and gate the ambient hum loop
    noiseIntensity = 0.25,         -- Noise opacity (0-1)
    noiseCount = 250,              -- Number of noise particles per frame
    noiseBrightnessThreshold = 0.1,  -- Only show noise pixels brighter than this (0-1)
    noiseFrameInterval = 1,        -- Draw grain every Nth frame to reduce UI cost
    noiseMinSize = 1,              -- Smallest grain block size in pixels
    noiseMaxSize = 1,              -- Largest grain block size in pixels
    noiseR = 1.0,                  -- Noise tint red channel
    noiseG = 1.0,                  -- Noise tint green channel
    noiseB = 1.0,                  -- Noise tint blue channel
    noiseTexturePaths = nil,       -- Optional full-screen noise texture sequence
    noiseTextureAlpha = 0.0,       -- Texture noise opacity (0-1)
    noiseTextureTintR = 1.0,       -- Texture noise tint red channel
    noiseTextureTintG = 1.0,       -- Texture noise tint green channel
    noiseTextureTintB = 1.0,       -- Texture noise tint blue channel
    noiseTextureFrameInterval = 1, -- Advance to the next texture every N frames
    
    -- === OTHER VISUAL EFFECTS ===
    vignetteSize = 350,            -- Dark edges size (pixels)
    vignetteAlpha = 0.65,          -- Dark edges opacity (0-1)
    vignetteLayers = 4,            -- Number of vignette bands to draw
    scanLinesEnabled = true,       -- Enable horizontal scan lines
    scanLineSpacing = 4,           -- Pixels between scan lines
    scanLineAlpha = 0.18,          -- Scan line darkness (0-1)
    flickerEnabled = true,         -- Enable random flicker
    flickerChance = 0.08,          -- Flicker probability per frame (0-1)
    flickerIntensity = 0.45,       -- Flicker strength (0-1)

    -- === BRIGHT-LIGHT GLARE ===
    glareEnabled = false,          -- Blow out the image when exposed to bright light
    glareRoomOnly = false,          -- Indoors, only react to actual room lighting instead of tile light
    glareThreshold = 0.42,         -- Light level where glare begins (0-1)
    glareMaxAlpha = 0.40,          -- Maximum full-screen glare opacity
    glareBloomAlpha = 0.24,        -- Additional center bloom opacity
    glareLayers = 2,               -- Number of additional bloom layers to draw
    glareR = 0.18,                 -- Glare tint red channel
    glareG = 0.95,                 -- Glare tint green channel
    glareB = 0.12,                 -- Glare tint blue channel
}

local PROFILE_FIELDS = {
    "overlayR",
    "overlayG",
    "overlayB",
    "greenIntensity",
    "overlayAlpha",
    "useClimateTint",
    "exteriorR",
    "exteriorG",
    "exteriorB",
    "exteriorAlpha",
    "interiorR",
    "interiorG",
    "interiorB",
    "interiorAlpha",
    "ambientLight",
    "fogIntensity",
    "noiseEnabled",
    "noiseIntensity",
    "noiseCount",
    "noiseBrightnessThreshold",
    "noiseFrameInterval",
    "noiseMinSize",
    "noiseMaxSize",
    "noiseR",
    "noiseG",
    "noiseB",
    "noiseTexturePaths",
    "noiseTextureAlpha",
    "noiseTextureTintR",
    "noiseTextureTintG",
    "noiseTextureTintB",
    "noiseTextureFrameInterval",
    "vignetteSize",
    "vignetteAlpha",
    "vignetteLayers",
    "scanLinesEnabled",
    "scanLineSpacing",
    "scanLineAlpha",
    "flickerEnabled",
    "flickerChance",
    "flickerIntensity",
    "glareEnabled",
    "glareRoomOnly",
    "glareThreshold",
    "glareMaxAlpha",
    "glareBloomAlpha",
    "glareLayers",
    "glareR",
    "glareG",
    "glareB",
}

local DEFAULT_PROFILE = {}
for _, key in ipairs(PROFILE_FIELDS) do
    DEFAULT_PROFILE[key] = NV.Overlay.Config[key]
end

NV.Overlay.BaseConfig = NV.Overlay.BaseConfig or {
    flickerEnabled = DEFAULT_PROFILE.flickerEnabled,
    flickerChance = DEFAULT_PROFILE.flickerChance,
    flickerIntensity = DEFAULT_PROFILE.flickerIntensity,
}

local function updateBaseConfig(cfg)
    NV.Overlay.BaseConfig.flickerEnabled = cfg.flickerEnabled
    NV.Overlay.BaseConfig.flickerChance = cfg.flickerChance
    NV.Overlay.BaseConfig.flickerIntensity = cfg.flickerIntensity
end

local function getProfileValue(profile, key)
    if not profile then
        return DEFAULT_PROFILE[key]
    end

    if profile[key] ~= nil then
        return profile[key]
    end

    if key == "overlayG" and profile.greenIntensity ~= nil then
        return profile.greenIntensity
    end

    if key == "greenIntensity" and profile.overlayG ~= nil then
        return profile.overlayG
    end

    if key == "noiseTexturePaths" and type(profile.noiseTexturePaths) == "table" then
        local normalized = {}
        for _, texturePath in ipairs(profile.noiseTexturePaths) do
            if type(texturePath) == "string" and texturePath ~= "" then
                table.insert(normalized, texturePath)
            end
        end
        if #normalized > 0 then
            return normalized
        end
    end

    return DEFAULT_PROFILE[key]
end

function NV.Overlay.ResolveProfile(profile)
    local resolved = {}
    for _, key in ipairs(PROFILE_FIELDS) do
        resolved[key] = getProfileValue(profile, key)
    end
    return resolved
end

local function applyProfile(profile)
    local cfg = NV.Overlay.Config
    local resolved = NV.Overlay.ResolveProfile(profile)
    for _, key in ipairs(PROFILE_FIELDS) do
        cfg[key] = resolved[key]
    end

    updateBaseConfig(cfg)
end

local function applyClimateSettings(cfg)
    if not cfg.useClimateTint then return end

    local clim = getClimateManager()
    if not clim then return end

    local globalLight = clim:getClimateColor(ClimateManager.COLOR_GLOBAL_LIGHT)
    local globalLightIntensity = clim:getClimateFloat(ClimateManager.FLOAT_GLOBAL_LIGHT_INTENSITY)
    local ambient = clim:getClimateFloat(ClimateManager.FLOAT_AMBIENT)
    local fogIntensity = clim:getClimateFloat(ClimateManager.FLOAT_FOG_INTENSITY)

    if not (globalLight and globalLightIntensity and ambient and fogIntensity) then
        return
    end

    ambient:setEnableAdmin(true)
    globalLight:setEnableAdmin(true)
    globalLightIntensity:setEnableAdmin(true)
    fogIntensity:setEnableAdmin(true)

    globalLightIntensity:setAdminValue(1.0)
    ambient:setAdminValue(cfg.ambientLight)
    fogIntensity:setAdminValue(cfg.fogIntensity)
    -- ClimateManager global-light admin colors present red/blue swapped in live NV testing,
    -- so normalize here to keep profile field names and editor labels truthful.
    globalLight:setAdminValueExterior(cfg.exteriorB, cfg.exteriorG, cfg.exteriorR, cfg.exteriorAlpha)
    globalLight:setAdminValueInterior(cfg.interiorB, cfg.interiorG, cfg.interiorR, cfg.interiorAlpha)

    clim:update()
end

local function clearClimateSettings()
    local clim = getClimateManager()
    if not clim then return end

    local globalLight = clim:getClimateColor(ClimateManager.COLOR_GLOBAL_LIGHT)
    local globalLightIntensity = clim:getClimateFloat(ClimateManager.FLOAT_GLOBAL_LIGHT_INTENSITY)
    local ambient = clim:getClimateFloat(ClimateManager.FLOAT_AMBIENT)
    local fogIntensity = clim:getClimateFloat(ClimateManager.FLOAT_FOG_INTENSITY)

    if not (globalLight and globalLightIntensity and ambient and fogIntensity) then
        return
    end

    if globalLight:isEnableAdmin() then
        globalLight:setEnableAdmin(false)
        globalLightIntensity:setEnableAdmin(false)
        ambient:setEnableAdmin(false)
        fogIntensity:setEnableAdmin(false)
        clim:update()
    end
end

function NV.Overlay.ApplyProfile(profile)
    applyProfile(profile)

    if NV.Overlay.isActive then
        if NV.Overlay.Config.useClimateTint then
            applyClimateSettings(NV.Overlay.Config)
        else
            clearClimateSettings()
        end
        if NV.Overlay.SyncLoopSound then
            NV.Overlay.SyncLoopSound()
        end
    end
end

function NV.Overlay.ResetProfile()
    applyProfile(nil)
end

-- State
NV.Overlay.isActive = false
NV.Overlay.panel = nil
NV.Overlay.frameCounter = 0
NV.Overlay.currentFlicker = 0

local function startLoopSound(player)
    local noiseEnabled = NV.Overlay.Config and NV.Overlay.Config.noiseEnabled == true
    local soundEnabled = not (NV.Options and NV.Options.enableBaseSound) or NV.Options.enableBaseSound()
    if not soundEnabled or not noiseEnabled then return end
    if NV.Overlay._loopSoundHandle and player:getEmitter():isPlaying(NV.Overlay._loopSoundHandle) then return end

    NV.Overlay._loopSoundHandle = player:getEmitter():playSound("nv-base")
    if NV.Overlay._loopSoundHandle then
        local vol = (NV.Options and NV.Options.baseSoundVolume) and NV.Options.baseSoundVolume() or 1.0
        player:getEmitter():setVolume(NV.Overlay._loopSoundHandle, vol)
    end
end

local function stopLoopSound(player)
    if NV.Overlay._loopSoundHandle then
        player:getEmitter():stopSound(NV.Overlay._loopSoundHandle)
        NV.Overlay._loopSoundHandle = nil
    end
end

local function playToggleSound(player, soundName)
    if not (player and soundName) then return end

    local handle = player:getEmitter():playSound(soundName)
    if not handle then return end

    local vol = 0.1
    if NV.Options and NV.Options.toggleSoundVolume then
        local optVol = tonumber(NV.Options.toggleSoundVolume())
        if optVol then
            vol = math.max(0, math.min(1, optVol))
        end
    end

    player:getEmitter():setVolume(handle, vol)
end

function NV.Overlay.SyncLoopSound()
    local player = getSpecificPlayer(0)
    if not player then return end

    local soundEnabled = not (NV.Options and NV.Options.enableBaseSound) or NV.Options.enableBaseSound()
    local noiseEnabled = NV.Overlay.Config and NV.Overlay.Config.noiseEnabled == true

    if not soundEnabled or not noiseEnabled then
        stopLoopSound(player)
        return
    end

    startLoopSound(player)
end

-- Create the overlay panel class
NV.NVPanel = ISPanel:derive("NVPanel")

function NV.NVPanel:new(x, y, width, height)
    local o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.backgroundColor = {r=0, g=0, b=0, a=0}
    o.borderColor = {r=0, g=0, b=0, a=0}
    
    -- Make panel completely mouse-transparent
    o:setAlwaysOnTop(true)
    o:setCapture(false)
    o:setWantKeyEvents(false)
    o.mouseOver = false
    
    return o
end

function NV.NVPanel:initialise()
    ISPanel.initialise(self)
end

-- Override mouse event handlers to make panel fully transparent to input
function NV.NVPanel:onMouseDown(x, y) return false end
function NV.NVPanel:onMouseUp(x, y) return false end
function NV.NVPanel:onMouseMove(dx, dy) return false end
function NV.NVPanel:onMouseMoveOutside(dx, dy) return false end
function NV.NVPanel:onRightMouseDown(x, y) return false end
function NV.NVPanel:onRightMouseUp(x, y) return false end
function NV.NVPanel:isMouseOver() return false end
function NV.NVPanel:getMouseX() return -1 end
function NV.NVPanel:getMouseY() return -1 end

local function clamp01(value)
    if value < 0 then return 0 end
    if value > 1 then return 1 end
    return value
end

local function getPositiveInt(value, fallback)
    local number = math.floor(tonumber(value) or fallback or 1)
    if number < 1 then
        return fallback or 1
    end
    return number
end

local function getBrightLightGlareStrength(cfg)
    if not cfg.glareEnabled then return 0 end

    local player = getSpecificPlayer(0)
    if not player then return 0 end

    local square = player:getCurrentSquare()
    if not square then return 0 end

    local room = square:getRoom()
    if cfg.glareRoomOnly and not room then
        return 0
    end

    local function getSwitchActivationState(lightSwitch)
        if not lightSwitch then return false end
        if lightSwitch.isActivated then
            return lightSwitch:isActivated() == true
        end
        if lightSwitch.Activated then
            return lightSwitch:Activated() == true
        end
        return false
    end

    local function getRoomLightStrength(currentRoom)
        if not currentRoom then return nil end

        local switches = currentRoom.getLightSwitches and currentRoom:getLightSwitches() or currentRoom.lightSwitches
        if switches and switches.size and switches:size() > 0 then
            for index = 0, switches:size() - 1 do
                if getSwitchActivationState(switches:get(index)) then
                    return 1
                end
            end
            return 0
        end

        local roomLights = currentRoom.roomLights
        if roomLights and roomLights.size and roomLights:size() > 0 then
            for index = 0, roomLights:size() - 1 do
                local roomLight = roomLights:get(index)
                if roomLight and roomLight.bActive == true then
                    return 1
                end
            end
            return 0
        end

        return nil
    end

    local roomLightStrength = getRoomLightStrength(room)
    if cfg.glareRoomOnly then
        return clamp01(roomLightStrength or 0)
    end

    if roomLightStrength and roomLightStrength > 0 then
        return clamp01(roomLightStrength)
    end

    local playerNum = player:getPlayerNum()
    local lightLevel = square:getLightLevel(playerNum)
    if not lightLevel then return 0 end

    local threshold = clamp01(cfg.glareThreshold or 0.42)
    if lightLevel <= threshold then
        return 0
    end

    return clamp01((lightLevel - threshold) / math.max(0.001, 1 - threshold))
end

local function renderBrightLightGlare(panel, cfg, glareStrength, width, height)
    if glareStrength <= 0 then return end

    local glareAlpha = (cfg.glareMaxAlpha or 0.4) * glareStrength
    local bloomAlpha = (cfg.glareBloomAlpha or 0.24) * glareStrength
    local glareR = cfg.glareR or 0.18
    local glareG = cfg.glareG or 0.95
    local glareB = cfg.glareB or 0.12
    local glareLayers = getPositiveInt(cfg.glareLayers, 2)

    panel:drawRect(0, 0, width, height, glareAlpha, glareR, glareG, glareB)

    -- Stack centered layers to fake bloom without introducing large, obvious bands.
    for i = 0, glareLayers - 1 do
        local factor = glareLayers == 1 and 0 or (i / (glareLayers - 1))
        local easedFactor = factor * factor
        local insetX = math.floor(width * 0.10 * easedFactor)
        local insetY = math.floor(height * 0.12 * easedFactor)
        local layerAlpha = bloomAlpha * (1 - factor) * 0.55
        panel:drawRect(insetX, insetY, width - insetX * 2, height - insetY * 2, layerAlpha, glareR, glareG, glareB)
    end
end

local function renderVignette(panel, cfg, width, height)
    local vignetteSize = math.max(0, math.floor(cfg.vignetteSize or 0))
    local vignetteAlpha = cfg.vignetteAlpha or 0
    if vignetteSize <= 0 or vignetteAlpha <= 0 then
        return
    end

    local layers = getPositiveInt(cfg.vignetteLayers, 6)

    for i = 0, layers - 1 do
        local factor = layers == 1 and 0 or (i / (layers - 1))
        local inset = math.floor(vignetteSize * factor)
        if inset * 2 < width and inset * 2 < height then
            local alpha = vignetteAlpha * (1 - factor) * 0.34
            panel:drawRect(0, inset, width, 1, alpha, 0, 0, 0)
            panel:drawRect(0, height - inset - 1, width, 1, alpha, 0, 0, 0)
            panel:drawRect(inset, 0, 1, height, alpha, 0, 0, 0)
            panel:drawRect(width - inset - 1, 0, 1, height, alpha, 0, 0, 0)
        end
    end
end

local function shouldRenderNoiseThisFrame(cfg)
    local frameInterval = getPositiveInt(cfg.noiseFrameInterval, 1)
    if frameInterval <= 1 then
        return true
    end

    return NV.Overlay.frameCounter % frameInterval == 0
end

local function getNoiseTextureCache()
    NV.Overlay._noiseTextureCache = NV.Overlay._noiseTextureCache or {}
    return NV.Overlay._noiseTextureCache
end

local function resolveNoiseTextures(cfg)
    if type(cfg.noiseTexturePaths) ~= "table" or #cfg.noiseTexturePaths == 0 then
        return nil
    end

    local cache = getNoiseTextureCache()
    local textures = {}

    for _, texturePath in ipairs(cfg.noiseTexturePaths) do
        local texture = cache[texturePath]
        if texture == nil then
            texture = getTexture(texturePath) or false
            cache[texturePath] = texture
        end
        if texture and texture ~= false then
            table.insert(textures, texture)
        end
    end

    if #textures == 0 then
        return nil
    end

    return textures
end

local function getCurrentNoiseTexture(cfg)
    local textures = resolveNoiseTextures(cfg)
    if not textures then
        return nil
    end

    local frameInterval = getPositiveInt(cfg.noiseTextureFrameInterval, 1)
    local frameIndex = math.floor(NV.Overlay.frameCounter / frameInterval) % #textures + 1
    return textures[frameIndex]
end

function NV.NVPanel:render()
    if not NV.Overlay.isActive then return end
    
    local cfg = NV.Overlay.Config
    local w = self.width
    local h = self.height
    local glareStrength = getBrightLightGlareStrength(cfg)
    local noiseTexture = cfg.noiseEnabled and getCurrentNoiseTexture(cfg) or nil
    
    -- 1. Main tint overlay (pure tint, no brightness boost)
    local overlayAlpha = cfg.overlayAlpha * (1 - NV.Overlay.currentFlicker * 0.5)
    local overlayR = cfg.overlayR or 0
    local overlayG = cfg.overlayG or cfg.greenIntensity or 0.9
    local overlayB = cfg.overlayB or 0
    self:drawRect(0, 0, w, h, overlayAlpha, overlayR, overlayG, overlayB)
    
    -- 2. Vignette (dark edges)
    renderVignette(self, cfg, w, h)
    
    -- 4. Scan lines
    if cfg.scanLinesEnabled then
        local y = 0
        while y < h do
            self:drawRect(0, y, w, 1, cfg.scanLineAlpha, 0, 0, 0)
            y = y + cfg.scanLineSpacing
        end
    end

    if noiseTexture then
        self:drawTextureScaled(
            noiseTexture,
            0,
            0,
            w,
            h,
            cfg.noiseTextureAlpha or cfg.noiseIntensity or 0.25,
            cfg.noiseTextureTintR or 1.0,
            cfg.noiseTextureTintG or 1.0,
            cfg.noiseTextureTintB or 1.0
        )
    end
    
    -- 5. Noise/grain
    if cfg.noiseEnabled and not noiseTexture and shouldRenderNoiseThisFrame(cfg) then
        local noiseThreshold = cfg.noiseBrightnessThreshold or 0.1
        local noiseMinSize = math.max(1, math.floor(cfg.noiseMinSize or 1))
        local noiseMaxSize = math.max(noiseMinSize, math.floor(cfg.noiseMaxSize or noiseMinSize))
        for i = 1, cfg.noiseCount do
            local brightness = ZombRand(100) / 100.0
            if brightness > noiseThreshold then
                local noiseSize = noiseMinSize
                if noiseMaxSize > noiseMinSize then
                    noiseSize = noiseMinSize + ZombRand(noiseMaxSize - noiseMinSize + 1)
                end

                local x = ZombRand(math.max(1, w - noiseSize + 1))
                local y = ZombRand(math.max(1, h - noiseSize + 1))
                self:drawRect(
                    x,
                    y,
                    noiseSize,
                    noiseSize,
                    cfg.noiseIntensity,
                    (cfg.noiseR or 1.0) * brightness,
                    (cfg.noiseG or 1.0) * brightness,
                    (cfg.noiseB or 1.0) * brightness
                )
            end
        end
    end

    renderBrightLightGlare(self, cfg, glareStrength, w, h)
end

function NV.NVPanel:prerender()
    -- Update flicker effect
    local cfg = NV.Overlay.Config
    if cfg.flickerEnabled then
        if ZombRand(100) < cfg.flickerChance * 100 then
            NV.Overlay.currentFlicker = cfg.flickerIntensity
        else
            NV.Overlay.currentFlicker = NV.Overlay.currentFlicker * 0.7
            if NV.Overlay.currentFlicker < 0.01 then
                NV.Overlay.currentFlicker = 0
            end
        end
    end
    
    NV.Overlay.frameCounter = NV.Overlay.frameCounter + 1
end

-- Manual render function (called from OnPostUIDraw event)
function NV.Overlay.ManualRender()
    if not NV.Overlay.isActive then return end
    
    local screenWidth = getCore():getScreenWidth()
    local screenHeight = getCore():getScreenHeight()
    
    -- Create or recreate panel if screen size changed
    if not NV.Overlay.panel or NV.Overlay.panel.width ~= screenWidth or NV.Overlay.panel.height ~= screenHeight then
        NV.Overlay.panel = NV.NVPanel:new(0, 0, screenWidth, screenHeight)
        NV.Overlay.panel:initialise()
    end
    
    -- Call prerender for flickering and other updates
    NV.Overlay.panel:prerender()
    
    -- Manually call render
    NV.Overlay.panel:render()
end

-- Enable overlay
function NV.Overlay.Enable(playSound)
    if NV.Overlay.isActive then return end
    
    NV.Overlay.isActive = true
    
    -- Play turn-on sound and switch to _ON model
    local player = getSpecificPlayer(0)
    if player then
        if playSound ~= false then
            playToggleSound(player, "nv-turnon")
        end
        NV.Overlay.SyncLoopSound()
    end
    
    -- Apply PURE TINT only (no brightness boost)
    if NV.Overlay.Config.useClimateTint then
        applyClimateSettings(NV.Overlay.Config)
    else
        clearClimateSettings()
    end
    
    NV.DebugPrint("NV Overlay enabled - Pure tint (no brightness boost)")
end

-- Disable overlay
function NV.Overlay.Disable(playSound)
    if not NV.Overlay.isActive then return end
    
    NV.Overlay.isActive = false
    NV.Overlay.currentFlicker = 0
    
    -- Play turn-off sound and switch to _OFF model
    local player = getSpecificPlayer(0)
    if player then
        stopLoopSound(player)
        if playSound ~= false then
            playToggleSound(player, "nv-turnoff")
        end
    end
    
    clearClimateSettings()
    
    NV.DebugPrint("NV Overlay disabled - Tint removed")
end

-- Toggle overlay
function NV.Overlay.Toggle()
    if NV.Overlay.isActive then
        NV.Overlay.Disable()
    else
        NV.Overlay.Enable()
    end
end

-- Sound-only helper for vanilla NV mode.
function NV.Overlay.PlaySoundAndSwapModel(enable, playSound)
    local player = getSpecificPlayer(0)
    if not player then return end

    if enable then
        if playSound ~= false then
            playToggleSound(player, "nv-turnon")
        end
        NV.Overlay.SyncLoopSound()
    else
        stopLoopSound(player)
        if playSound ~= false then
            playToggleSound(player, "nv-turnoff")
        end
    end
end

-- Loop keeper: OGG file clips don't honour loop=true in FMOD's FileSound path,
-- so we re-trigger the sound every time isPlaying() reports it has ended.
local function onOverlayPlayerUpdate()
    if not (NV.State and NV.State.isActive) then return end

    local player = getSpecificPlayer(0)
    if not player then return end

    local soundEnabled = not (NV.Options and NV.Options.enableBaseSound) or NV.Options.enableBaseSound()
    local noiseEnabled = NV.Overlay.Config and NV.Overlay.Config.noiseEnabled == true

    if not soundEnabled or not noiseEnabled then
        stopLoopSound(player)
        return
    end

    local handle = NV.Overlay._loopSoundHandle
    if not handle or not player:getEmitter():isPlaying(handle) then
        startLoopSound(player)
    end
end
Events.OnPlayerUpdate.Add(onOverlayPlayerUpdate)

-- Hook into OnPostUIDraw for rendering
Events.OnPostUIDraw.Add(NV.Overlay.ManualRender)

print("[NV] Overlay system loaded (Pure Tint - No Brightness Boost)")
