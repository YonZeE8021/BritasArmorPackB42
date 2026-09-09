require("NPCs/BodyLocations")

local group = BodyLocations.getGroup("Human")
local locations = BritasArmorFixRegistries and BritasArmorFixRegistries.BodyLocations

if locations then
    group:getOrCreateLocation(locations.ChestRig)
    group:getOrCreateLocation(locations.BeltRig)
    group:getOrCreateLocation(locations.ThighPouch)
    group:getOrCreateLocation(locations.Gaiters)
    -- Keep cloak/raincoat meshes last so jackets and vests cannot render over
    -- or hide models that were formerly misclassified as long necklaces.
    group:getOrCreateLocation(locations.OuterCloak)
end
