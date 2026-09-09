-- Items:
-- Legacy NVITEM tags are auto-registered by the script loader when older item definitions still use "Tags = NVITEM".

-- Dedicated B42 equipment slots used by the integrated layer/container fixes.
BritasArmorFixRegistries = BritasArmorFixRegistries or {}
BritasArmorFixRegistries.BodyLocations = BritasArmorFixRegistries.BodyLocations or {}

local bodyLocationIds = {
    ChestRig = "BritasArmorFix:ChestRig",
    BeltRig = "BritasArmorFix:BeltRig",
    ThighPouch = "BritasArmorFix:ThighPouch",
    Gaiters = "BritasArmorFix:Gaiters",
    OuterCloak = "BritasArmorFix:OuterCloak",
}

for key, id in pairs(bodyLocationIds) do
    if not BritasArmorFixRegistries.BodyLocations[key] then
        BritasArmorFixRegistries.BodyLocations[key] = ItemBodyLocation.register(id)
    end
end
