BritasArmorFixRegistries = BritasArmorFixRegistries or {}
BritasArmorFixRegistries.BodyLocations = BritasArmorFixRegistries.BodyLocations or {}

local ids = {
    ChestRig = "BritasArmorFix:ChestRig",
    BeltRig = "BritasArmorFix:BeltRig",
    ThighPouch = "BritasArmorFix:ThighPouch",
}

for key, id in pairs(ids) do
    if not BritasArmorFixRegistries.BodyLocations[key] then
        BritasArmorFixRegistries.BodyLocations[key] = ItemBodyLocation.register(id)
    end
end
