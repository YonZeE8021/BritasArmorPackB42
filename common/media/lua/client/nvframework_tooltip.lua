--[[
    Night Vision Framework - Battery Tooltip

    Appends a charge progress bar to the inventory hover tooltip of any
    supported NV item. Reads "nvBatteryCharge" from the item's ModData
    -- the same key written/read by the context menu Insert/Remove action and
    the battery drain system.

    Activate gate:
        NV activation is gated in NVFramework_Core.lua via NV.Battery.HasBattery().
        When the "Require batteries" mod option is ON, NV cannot be toggled
        on unless the worn NV item has a battery installed with charge > 0.
        The tooltip displays the current charge at all times so the player
        always knows the status of the installed battery.

    Battery states displayed:
        charge 0.21 - 1.0  green bar
        charge 0.20 - 0.20  transition green/yellow
        charge 0.02 - 0.20  yellow/orange bar
        charge 0.00 - 0.01  red bar (dead -- NV cannot activate)
        charge = nil        "Not installed" (grey text, no bar)

    Technique:
        Uses a chain-safe ISToolTipInv.render wrapper.  NV battery hosts
        render through a standalone battery tooltip path, while non-NV items
        delegate to the captured tooltip chain. The wrapper is installed once;
        later wrappers can call it without being wrapped again every 30 ticks.
--]]

require "ISUI/ISToolTipInv"

NV = NV or {}

NV.Tooltip = NV.Tooltip or {}

local MODDATA_K = "nvBatteryCharge"   -- mirrors NV.Battery.MODDATA_KEY

-- Layout constants (all panel-local pixels unless noted)
local PADX    = 11   -- left panel strip added by ISToolTipInv
local INNER_X =  5   -- inner x-margin from the tooltip content left edge
local BAR_H   =  4   -- slim bar, inline with the label
local LPAD    =  4   -- vertical padding above/below the battery row
local BAR_GAP = 50   -- gap between label text and bar (6 aesthetic + 15 left padding)

-- Lazy-init font so it respects the player's tooltip size preference
local _font, _lh
local function getFont()
    if _font then return _font, _lh end
    local s = getCore():getOptionTooltipFont()
    if     s == "Large"  then _font = UIFont.Large
    elseif s == "Medium" then _font = UIFont.Medium
    else                      _font = UIFont.NewSmall
    end
    _lh = getTextManager():getFontFromEnum(_font):getLineHeight()
    return _font, _lh
end

-- Charge (0..1) to r, g, b, a
local function barColor(c)
    if c > 0.5 then
        local t = (c - 0.5) * 2        -- t=0 at 50%, t=1 at 100%
        return 1 - t, 1.0, 0.0, 0.9   -- orange -> green
    elseif c > 0.2 then
        local t = (c - 0.2) / 0.3     -- t=0 at 20%, t=1 at 50%
        return 1.0, t, 0.0, 0.9       -- red -> orange
    else
        return 1.0, 0.0, 0.0, 0.9     -- red
    end
end

local function renderBatteryTooltip(self)
    local isBatteryHost = self.item and NV.IsNVBatteryHostItem and NV.IsNVBatteryHostItem(self.item)
    local batterySystemEnabled = not (NV.Battery and NV.Battery.IsSystemEnabled) or NV.Battery.IsSystemEnabled()
    if not isBatteryHost or not batterySystemEnabled then
        return
    end

    -- Suppress while a context menu is open (mirrors vanilla guard)
    if ISContextMenu.instance and ISContextMenu.instance.visibleCheck then
        return
    end

    local fn, lh = getFont()

    -- Follow-mouse position
    local mx = getMouseX() + 24
    local my = getMouseY() + 24
    if not self.followMouse then
        mx = self:getX()
        my = self:getY()
        if self.anchorBottomLeft then
            mx = self.anchorBottomLeft.x
            my = self.anchorBottomLeft.y
        end
    end

    -- Measurement pass: let Java measure the normal tooltip dimensions
    self.tooltip:setX(mx)
    self.tooltip:setY(my)
    self.tooltip:setWidth(50)
    self.tooltip:setMeasureOnly(true)
    self.item:DoTooltip(self.tooltip)
    self.tooltip:setMeasureOnly(false)

    local tw = self.tooltip:getWidth()
    local th = self.tooltip:getHeight()

    -- Extra height: 1px separator + gap + single row (label + inline bar) + gap
    local extraH = 3 + LPAD + lh + LPAD
    local totalH = th + extraH

    -- Clamp tooltip position to screen bounds
    local sw = getCore():getScreenWidth()
    local sh = getCore():getScreenHeight()
    local tx = math.max(0, math.min(mx, sw - tw - 1))
    local ty
    if not self.followMouse and self.anchorBottomLeft then
        ty = math.max(0, math.min(my - totalH, sh - totalH - 1))
    else
        ty = math.max(0, math.min(my, sh - totalH - 1))
    end

    self.tooltip:setX(tx)
    self.tooltip:setY(ty)

    -- Position the panel wrapper (PADX=11 left strip for cosmetics)
    self:setX(tx - PADX)
    self:setY(ty)
    self:setWidth(tw + PADX)
    self:setHeight(totalH)

    if self.followMouse then
        self:adjustPositionToAvoidOverlap({ x = mx - 48, y = my - 48, width = 48, height = 48 })
    end

    -- Draw panel background and border
    self:drawRect(0, 0, self.width, self.height,
        self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
    self:drawRectBorder(0, 0, self.width, self.height,
        self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)

    -- Render normal item tooltip content via Java ObjectTooltip
    self.item:DoTooltip(self.tooltip)

    -- Battery section
    -- Panel local x: PADX aligns with tooltip left edge; add INNER_X for margin
    local cx   = PADX + INNER_X            -- content left in panel-local coords
    local barW = tw - INNER_X * 2          -- full bar width (tooltip width - margins)

    -- Separator line
    local sepY = th + 2
    self:drawRect(cx, sepY, barW, 1, 0.35, 0.5, 0.5, 0.5)

    local rowY  = sepY + LPAD + 1   -- top of the single battery row
    local charge = self.item:getModData()[MODDATA_K]

    if charge ~= nil then
        local pct   = math.max(0.0, math.min(1.0, charge))
        local label = getItemNameFromFullType("Base.Battery") .. ":"

        -- Draw label
        self:drawText(label, cx, rowY, 1, 1, 1, 0.85, fn)

        -- Bar starts right after label text, vertically centered in the row
        local labelW = getTextManager():MeasureStringX(fn, label)
        local bx     = cx + labelW + BAR_GAP
        local bw     = barW - labelW - BAR_GAP
        local by     = rowY + math.floor((lh - BAR_H) / 2) + 2

        if bw > 4 then
            -- Track
            self:drawRect(bx, by, bw, BAR_H, 0.8, 0.18, 0.18, 0.18)
            -- Fill
            local fillW = math.max(0, math.floor(bw * pct))
            if fillW > 0 then
                local r, g, b, a = barColor(pct)
                self:drawRect(bx, by, fillW, BAR_H, a, r, g, b)
            end
            -- Border
            self:drawRectBorder(bx, by, bw, BAR_H, 0.6, 0.5, 0.5, 0.5)
        end
    else
        -- No battery installed
        self:drawText(getItemNameFromFullType("Base.Battery") .. ": " .. getText("UI_Battery_NotInstalled"), cx, rowY, 0.55, 0.55, 0.55, 0.9, fn)
    end
end

function ISToolTipInv:NV_BatteryTooltip_render()
    return renderBatteryTooltip(self)
end

local function createRenderWrapper(previousRender)
    return function(self)
        local isBatteryHost = self.item and NV.IsNVBatteryHostItem and NV.IsNVBatteryHostItem(self.item)
        local batterySystemEnabled = not (NV.Battery and NV.Battery.IsSystemEnabled) or NV.Battery.IsSystemEnabled()
        if not isBatteryHost or not batterySystemEnabled then
            return previousRender(self)
        end

        return renderBatteryTooltip(self)
    end
end

local function installRenderWrapper(reason)
    if not ISToolTipInv or type(ISToolTipInv.render) ~= "function" then
        return false
    end

    local currentRender = ISToolTipInv.render
    if NV.Tooltip._activeRenderWrapper then
        return false
    end

    local wrapper = createRenderWrapper(currentRender)
    NV.Tooltip._activeRenderWrapper = wrapper
    NV.Tooltip._wrappedRender = currentRender
    ISToolTipInv.render = wrapper

    if reason and reason ~= "" then
        print("[NV] Tooltip guard installed (" .. tostring(reason) .. ")")
    else
        print("[NV] Tooltip guard installed")
    end

    return true
end

installRenderWrapper("module")

print("[NV] Tooltip module loaded")
