require "Items/ProceduralDistributions"

--[[
    Личный порт Brita's Armor Pack на B42. Дистрибуция перенесена как есть,
    с двумя правками:
      * WardrobeWoman -> WardrobeGeneric (контейнер переименован в B42);
      * защита ниже — если TIS переименуют контейнер в следующем патче,
        мод не свалится с 3880 обращений к nil, а просто не заспавнит вещи
        в исчезнувшем контейнере и напишет об этом в консоль.
]]

local RR_missing = {}
local function RR_ensure(name)
    local list = ProceduralDistributions.list
    if not list[name] then
        list[name] = { items = {} }
        table.insert(RR_missing, name)
    elseif not list[name].items then
        list[name].items = {}
    end
end

for _, n in ipairs({
    "ArmyStorageOutfit",
    "ArmySurplusBackpacks",
    "ArmySurplusOutfit",
    "BedroomDresser",
    "CampingStoreBackpacks",
    "CampingStoreClothes",
    "ClothingStorageAllJackets",
    "ClothingStorageAllShirts",
    "ClothingStorageLegwear",
    "ClothingStoresBoots",
    "ClothingStoresDress",
    "ClothingStoresEyewear",
    "ClothingStoresGloves",
    "ClothingStoresHeadwear",
    "ClothingStoresJacketsFormal",
    "ClothingStoresJumpers",
    "ClothingStoresOvershirts",
    "ClothingStoresPants",
    "ClothingStoresPantsFormal",
    "ClothingStoresShirts",
    "ClothingStoresShirtsFormal",
    "ClothingStoresShoes",
    "ClothingStoresSocks",
    "ClothingStoresUnderwearMan",
    "ClothingStoresUnderwearWoman",
    "ClothingStoresWoman",
    "CrateClothesRandom",
    "DresserGeneric",
    "FireDeptLockers",
    "FireStorageOutfit",
    "HospitalLockers",
    "JewelryStorageAll",
    "LockerArmyBedroom",
    "MedicalStorageOutfit",
    "PoliceLockers",
    "PoliceStorageOutfit",
    "WardrobeGeneric",
}) do RR_ensure(n) end

if #RR_missing > 0 then
    print("[BritaArmor] контейнеров не найдено в этой версии игры: " .. tostring(#RR_missing)
          .. " (" .. table.concat(RR_missing, ", ") .. ")")
else
    print("[BritaArmor] distributions: все " .. tostring(0) .. " контейнеров на месте")
end


-----------------------
-- List of Places Memo --
-----------------------

----- Army -----

--ArmyStorageGuns--
--LockerArmyBedroom--
-- ArmyStorageOutfit --

----- Army Surplus -----

-- ArmySurplusOutfit --
-- ArmySurplusFootwear --
-- ArmySurplusBackpacks --
-- ArmySurplusTools --

----- Police -----

-- PoliceStorageGuns --
-- PoliceLockers --
-- PrisonGuardLockers --
-- PoliceStorageOutfit --

----- Camping Store -----

--CampingStoreGear--
--CampingStoreBackpacks--
--CampingStoreClothes--
--ClothingStorageWinter--
--CampingStoreClothes--
--HuntingLockers--

----- Gun Store -----

--GunStoreDisplayCase--
--GunStoreCounter--

----- Civil Place -----

--SchoolLockers--
--FireDeptLockers--
--FireStorageOutfit--
--GymLockers--
--HospitalLockers--
--MedicalStorageOutfit--

----- Clothing Store -----

-- ClothingStorageAllJackets --
-- ClothingStorageAllShirts --
-- ClothingStorageLegwear --
-- ClothingStoresDress --
-- ClothingStoresJacketsFormal --
-- ClothingStoresPantsFormal --
-- ClothingStoresShirtsFormal --
-- ClothingStoresJumpers --
-- ClothingStoresWoman --
-- ClothingStoresGloves --
-- ClothingStoresEyewear --
-- ClothingStoresHeadwear --
-- ClothingStoresSocks --
-- ClothingStoresUnderwearWoman --
-- ClothingStoresUnderwearMan --
-- ClothingStoresSport --
-- ClothingStoresPants --
-- ClothingStoresOvershirts --
-- ClothingStoresShirts --
-- ClothingStoresBoots --
-- ClothingStoresShoes --
-- JewelryStorageAll --

---- Bedroom ----

-- BedroomDresser --
-- CrateClothesRandom --
-- ClosetShelfGeneric --
-- WardrobeWoman --
-- DresserGeneric --
-- GymLockers --
-- SchoolLockers --

-----------------------
-- Military Police Hunting Jacket --
-----------------------

-- Wolf Jacket --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Wolf_Jacket");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Wolf_Jacket");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Wolf_Jacket");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Wolf_Jacket");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- BARS Hoodie --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.BARS_Hoodie");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.BARS_Hoodie");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.BARS_Hoodie");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.BARS_Hoodie");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Gorka6 Jacket --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Gorka6_Hoodie");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Gorka6_Hoodie");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Gorka6_Hoodie");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Gorka6_Hoodie");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Gorka5_Jacket --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Gorka5_Jacket");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Gorka5_Jacket");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Gorka5_Jacket");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Gorka5_Jacket");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- M65 Jacket --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.M65_Jacket");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.M65_Jacket");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.M65_Jacket");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.M65_Jacket");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- GEN Tactical Hoodie --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Tactical_Hood");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Tactical_Hood");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Tactical_Hood");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Tactical_Hood");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Coat Military Long --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Military_Coat_Long");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Military_Coat_Long");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Military_Coat_Long");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Military_Coat_Long");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Suit ARMY --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Suit_Army");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Suit_Army");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Suit_Army");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Suit_Army");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Sheriff Bomber --
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Jacket_Bomber");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Jacket_Bomber");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- Polizei Jumper --
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Jacket_Polizei");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Jacket_Polizei");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- ELA Bomber --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.ELA_Bomber");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.ELA_Bomber");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.ELA_Bomber");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.ELA_Bomber");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- ANA Shirts --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.ANA_Shirts");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.ANA_Shirts");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.ANA_Shirts");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.ANA_Shirts");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- ANA Hood --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.ANA_Hood");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.ANA_Hood");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.ANA_Hood");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.ANA_Hood");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- ANA Classic --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.ANA_Classic");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.ANA_Classic");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.ANA_Classic");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.ANA_Classic");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Officer Overcoat --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Officer_Overcoat");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Officer_Overcoat");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Officer_Overcoat");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Officer_Overcoat");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- USCM Jacket --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.USCM_Jacket");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.USCM_Jacket");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.USCM_Jacket");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.USCM_Jacket");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Winter Jacket Camo Heavy --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Winter_Jacket_Camo_Heavy");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Winter_Jacket_Camo_Heavy");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Winter_Jacket_Camo_Heavy");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Winter_Jacket_Camo_Heavy");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Coast Guard Jacket --
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Coast_Jacket");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Coast_Jacket");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- Police Waterproof Jacket --
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Police_Waterproof_Jacket");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Police_Waterproof_Jacket");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- Kelvin Jacket --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Kelvin_Jacket");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Kelvin_Jacket");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Kelvin_Jacket");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Kelvin_Jacket");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- EOD_Jacket --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.EOD_Jacket");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.08);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.EOD_Jacket");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.08);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.EOD_Jacket");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.08);

-- JUGG_Jacket --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.JUGG_Jacket");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.08);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.JUGG_Jacket");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.08);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.JUGG_Jacket");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.08);

-- Hunter_Jacket --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hunter_Jacket");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hunter_Jacket");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Hunter_Jacket");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hunter_Jacket");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Hunter_Jacket --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hunter_Jacket");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hunter_Jacket");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Hunter_Jacket");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hunter_Jacket");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Metro_Jacket --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Metro_Jacket");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Metro_Jacket");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Metro_Jacket");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Metro_Jacket");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Metro_Coat --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Metro_Coat");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Metro_Coat");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Metro_Coat");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Metro_Coat");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Chain_Coat --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Chain_Coat");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Chain_Coat");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Chain_Coat");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Chain_Coat");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- Man_Field_Shirts --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Man_Field_Shirts");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Man_Field_Shirts");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Man_Field_Shirts");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Man_Field_Shirts");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Man_Neck_Shirts --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Man_Neck_Shirts");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Man_Neck_Shirts");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Man_Neck_Shirts");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Man_Neck_Shirts");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Man_Neck_Shirts");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Man_Neck_Shirts");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- Man_Neck_Hoodie --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Man_Neck_Hoodie");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Man_Neck_Hoodie");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Man_Neck_Hoodie");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Man_Neck_Hoodie");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Man_Neck_Hoodie");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Man_Neck_Hoodie");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- Huntrite_Jacket --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Huntrite_Jacket");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Huntrite_Jacket");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Huntrite_Jacket");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Huntrite_Jacket");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- TEC_Jacket --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.TEC_Jacket");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.TEC_Jacket");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.TEC_Jacket");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.TEC_Jacket");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);



-----------------------
-- Other Casual Jacket --
-----------------------

-- Susie Hoodie --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Susie_Hood");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Susie_Hood");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Susie_Hood");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Susie_Hood");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Susie_Hood");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Susie_Hood");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Susie_Hood");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Susie_Hood");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Susie_Hood");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Susie_Hood");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Susie_Hood");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);


-- Kawaii Hoodie --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Kawaii_Hood");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Kawaii_Hood");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Kawaii_Hood");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Kawaii_Hood");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Kawaii_Hood");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Kawaii_Hood");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Kawaii_Hood");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Kawaii_Hood");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Kawaii_Hood");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Kawaii_Hood");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Kawaii_Hood");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Suit Wick --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Suit_Wick");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Suit_Wick");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Suit_Wick");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Suit_Wick");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Suit_Wick");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Suit_Wick");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Suit_Wick");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Suit_Wick");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Suit_Wick");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Suit_Wick");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Suit_Wick");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Suit Stew --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Suit_Stew");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Suit_Stew");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Suit_Stew");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Suit_Stew");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Suit_Stew");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Suit_Stew");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Suit_Stew");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Suit_Stew");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Suit_Stew");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Suit_Stew");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Suit_Stew");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Coat Long --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Coat_Long");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Coat_Long");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Coat_Long");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Coat_Long");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Coat_Long");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Coat_Long");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Coat_Long");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Coat_Long");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Coat_Long");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Coat_Long");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Coat_Long");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Ashe Jacket --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Ashe_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Ashe_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Ashe_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Ashe_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Ashe_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Ashe_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Ashe_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);

-- Heather Bomber --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Heather_Bomber");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Heather_Bomber");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Heather_Bomber");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Heather_Bomber");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Heather_Bomber");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Heather_Bomber");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Heather_Bomber");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Heather_Bomber");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Heather_Bomber");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Heather_Bomber");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Heather_Bomber");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- School Cardigan --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.School_Cardigan");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.School_Cardigan");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.School_Cardigan");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.School_Cardigan");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.School_Cardigan");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.School_Cardigan");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.School_Cardigan");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.School_Cardigan");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.School_Cardigan");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.School_Cardigan");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.School_Cardigan");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- School_Cardigan_Long --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.School_Cardigan_Long");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.School_Cardigan_Long");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.School_Cardigan_Long");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.School_Cardigan_Long");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.School_Cardigan_Long");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.School_Cardigan_Long");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.School_Cardigan_Long");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.School_Cardigan_Long");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.School_Cardigan_Long");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.School_Cardigan_Long");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.School_Cardigan_Long");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Dress_Cardigan --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Dress_Cardigan");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Dress_Cardigan");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Dress_Cardigan");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Dress_Cardigan");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Dress_Cardigan");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Dress_Cardigan");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Dress_Cardigan");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Dress_Cardigan");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Dress_Cardigan");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Dress_Cardigan");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Dress_Cardigan");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Cardigan_Short --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Cardigan_Short");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Cardigan_Short");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Cardigan_Short");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Cardigan_Short");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Cardigan_Short");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Cardigan_Short");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Cardigan_Short");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Cardigan_Short");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Cardigan_Short");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Cardigan_Short");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Cardigan_Short");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Winter_Jacket_Heavy --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Winter_Jacket_Heavy");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Winter_Jacket_Heavy");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Winter_Jacket_Heavy");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Winter_Jacket_Heavy");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Winter_Jacket_Heavy");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Winter_Jacket_Heavy");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Winter_Jacket_Heavy");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Winter_Jacket_Heavy");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Winter_Jacket_Heavy");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Winter_Jacket_Heavy");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Winter_Jacket_Heavy");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Wattson_Jacket --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Wattson_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Wattson_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Wattson_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Wattson_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Wattson_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Wattson_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Wattson_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Wattson_Jacket");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Wattson_Jacket");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Wattson_Jacket");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Wattson_Jacket");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Fur_Jacket --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Fur_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Fur_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Fur_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Fur_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Fur_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Fur_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Fur_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Fur_Jacket");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Fur_Jacket");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Fur_Jacket");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Fur_Jacket");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Paramedic_Jacket --
table.insert(ProceduralDistributions.list["HospitalLockers"].items, "Base.Paramedic_Jacket");
table.insert(ProceduralDistributions.list["HospitalLockers"].items, 0.8);
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Base.Paramedic_Jacket");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 0.8);

-- Nurse_Dress --
table.insert(ProceduralDistributions.list["HospitalLockers"].items, "Base.Nurse_Dress");
table.insert(ProceduralDistributions.list["HospitalLockers"].items, 0.8);
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Base.Nurse_Dress");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 0.8);

-- Kawasaki_Jacket --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Kawasaki_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Kawasaki_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Kawasaki_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Kawasaki_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Kawasaki_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Kawasaki_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Kawasaki_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Kawasaki_Jacket");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Kawasaki_Jacket");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Kawasaki_Jacket");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Kawasaki_Jacket");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Check_Shirts --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Check_Shirts");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Check_Shirts");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Check_Shirts");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Check_Shirts");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Tac_Check_Shirts --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Tac_Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Tac_Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Tac_Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Tac_Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Tac_Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Tac_Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Tac_Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Tac_Check_Shirts");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Tac_Check_Shirts");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Tac_Check_Shirts");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Tac_Check_Shirts");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Gunsmith_Jacket --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Gunsmith_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Gunsmith_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Gunsmith_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Gunsmith_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Gunsmith_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Gunsmith_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Gunsmith_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Gunsmith_Jacket");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Gunsmith_Jacket");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Gunsmith_Jacket");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Gunsmith_Jacket");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Adidas_Pad_Jacket --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Adidas_Pad_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Adidas_Pad_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Adidas_Pad_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Adidas_Pad_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Adidas_Pad_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Adidas_Pad_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Adidas_Pad_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Adidas_Pad_Jacket");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Adidas_Pad_Jacket");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Adidas_Pad_Jacket");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Adidas_Pad_Jacket");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Viking_Fire_Jacket --
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, "Base.Viking_Fire_Jacket");
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, 0.8);
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, "Base.Viking_Fire_Jacket");
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, 0.8);

-- Rose_Jacket --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Rose_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Rose_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Rose_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Rose_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Rose_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Rose_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Rose_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Rose_Jacket");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Rose_Jacket");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Rose_Jacket");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Rose_Jacket");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Man_Check_Shirts --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Man_Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Man_Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Man_Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Man_Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Man_Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Man_Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Man_Check_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Man_Check_Shirts");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Man_Check_Shirts");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Man_Check_Shirts");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Man_Check_Shirts");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Man_Adidas_Shirts --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Man_Adidas_Shirts --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Man_Adidas_Shirts");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Bandit_Coat --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Bandit_Coat");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Bandit_Coat");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Bandit_Coat");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Bandit_Coat");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Bandit_Coat");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Bandit_Coat");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Bandit_Coat");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Bandit_Coat");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Bandit_Coat");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Bandit_Coat");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Bandit_Coat");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Bandit_Jacket --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Bandit_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Bandit_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Bandit_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Bandit_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Bandit_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Bandit_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Bandit_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Bandit_Jacket");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Bandit_Jacket");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Bandit_Jacket");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Bandit_Jacket");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Knit_Dress --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Knit_Dress");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Knit_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Knit_Dress");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Knit_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Knit_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Knit_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Knit_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Knit_Dress");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Knit_Dress");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Knit_Dress");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Knit_Dress");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Off_Dress --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Off_Dress");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Off_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Off_Dress");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Off_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Off_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Off_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Off_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Off_Dress");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Off_Dress");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Off_Dress");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Off_Dress");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Cut_Dress --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Cut_Dress --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Cut_Dress");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Chara_Jacket --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Chara_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Chara_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Chara_Jacket");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Chara_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Chara_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Chara_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Chara_Jacket");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Chara_Jacket");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Chara_Jacket");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Chara_Jacket");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Chara_Jacket");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);




-----------------------
-- Other Casual Sweater & Shirts --
-----------------------

-- Turtleneck --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Turtleneck");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Turtleneck");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Turtleneck");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Turtleneck");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Turtleneck");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Turtleneck");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Turtleneck");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Turtleneck");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Turtleneck");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Turtleneck");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Turtleneck");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Belly_Turtleneck --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Belly_Turtleneck");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Belly_Turtleneck");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Belly_Turtleneck");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Belly_Turtleneck");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Belly_Turtleneck");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Belly_Turtleneck");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Belly_Turtleneck");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Belly_Turtleneck");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Belly_Turtleneck");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Belly_Turtleneck");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Belly_Turtleneck");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- S_Tank_Top --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.S_Tank_Top");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.S_Tank_Top");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.S_Tank_Top");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.S_Tank_Top");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.S_Tank_Top");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.S_Tank_Top");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.S_Tank_Top");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.S_Tank_Top");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.S_Tank_Top");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.S_Tank_Top");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.S_Tank_Top");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Y_Shirts --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Y_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Y_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Y_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Y_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Y_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Y_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Y_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Y_Shirts");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Y_Shirts");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Y_Shirts");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Y_Shirts");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Y_Shirts_Long --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Y_Shirts_Long");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Y_Shirts_Long");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Y_Shirts_Long");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Y_Shirts_Long");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Y_Shirts_Long");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Y_Shirts_Long");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Y_Shirts_Long");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Y_Shirts_Long");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Y_Shirts_Long");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Y_Shirts_Long");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Y_Shirts_Long");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Office_Sweater --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Office_Sweater");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Office_Sweater");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Office_Sweater");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Office_Sweater");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Office_Sweater");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Office_Sweater");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Office_Sweater");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Office_Sweater");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Office_Sweater");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Office_Sweater");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Office_Sweater");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Office_Sweater_Long --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Office_Sweater_Long");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Office_Sweater_Long");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Office_Sweater_Long");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Office_Sweater_Long");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Office_Sweater_Long");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Office_Sweater_Long");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Office_Sweater_Long");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Office_Sweater_Long");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Office_Sweater_Long");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Office_Sweater_Long");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Office_Sweater_Long");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Sweater_Lisa --
table.insert(ProceduralDistributions.list["HospitalLockers"].items, "Base.Sweater_Lisa");
table.insert(ProceduralDistributions.list["HospitalLockers"].items, 0.8);
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Base.Sweater_Lisa");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 0.8);

-- Shirts_Bennett --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Shirts_Bennett");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Shirts_Bennett");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Shirts_Bennett");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Shirts_Bennett");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Shirts_Bennett");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Shirts_Bennett");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Shirts_Bennett");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Shirts_Bennett");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Shirts_Bennett");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Shirts_Bennett");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Shirts_Bennett");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Shirts_James --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Shirts_James");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Shirts_James");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Shirts_James");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Shirts_James");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Shirts_James");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Shirts_James");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Shirts_James");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Shirts_James");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Shirts_James");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Shirts_James");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Shirts_James");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Leather_Vest_Harry --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Leather_Vest_Harry");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Leather_Vest_Harry");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Leather_Vest_Harry");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Leather_Vest_Harry");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Leather_Vest_Harry");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Leather_Vest_Harry");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Leather_Vest_Harry");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Leather_Vest_Harry");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Leather_Vest_Harry");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Leather_Vest_Harry");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Leather_Vest_Harry");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Shirts_Maria --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Shirts_Maria");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Shirts_Maria");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Shirts_Maria");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Shirts_Maria");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Shirts_Maria");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Shirts_Maria");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Shirts_Maria");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Shirts_Maria");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Shirts_Maria");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Shirts_Maria");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Shirts_Maria");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Shirts_Sebastian --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Shirts_Sebastian");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Shirts_Sebastian");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Shirts_Sebastian");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Shirts_Sebastian");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Shirts_Sebastian");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Shirts_Sebastian");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Shirts_Sebastian");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Shirts_Sebastian");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Shirts_Sebastian");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Shirts_Sebastian");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Shirts_Sebastian");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Shirts_Kidman --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Shirts_Kidman");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Shirts_Kidman");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Shirts_Kidman");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Shirts_Kidman");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Shirts_Kidman");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Shirts_Kidman");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Shirts_Kidman");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Shirts_Kidman");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Shirts_Kidman");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Shirts_Kidman");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Shirts_Kidman");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Cropped_Sweater --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Cropped_Sweater");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Cropped_Sweater");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Cropped_Sweater");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Cropped_Sweater");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Cropped_Sweater");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Cropped_Sweater");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Cropped_Sweater");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Cropped_Sweater");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Cropped_Sweater");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Cropped_Sweater");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Cropped_Sweater");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Formal_Shirts --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Formal_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Formal_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Formal_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Formal_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Formal_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Formal_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Formal_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Formal_Shirts");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Formal_Shirts");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Formal_Shirts");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Formal_Shirts");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Brig_Shirts --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Brig_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Brig_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Brig_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Brig_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Brig_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Brig_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Brig_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Brig_Shirts");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Brig_Shirts");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Brig_Shirts");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Brig_Shirts");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Shooting_Shirts --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Shooting_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Shooting_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Shooting_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Shooting_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Shooting_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Shooting_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Shooting_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Shooting_Shirts");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Shooting_Shirts");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Shooting_Shirts");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Shooting_Shirts");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Black_Long_Shirts --
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Black_Long_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, "Base.Black_Long_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJacketsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, "Base.Black_Long_Shirts");
table.insert(ProceduralDistributions.list["ClothingStorageAllShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, "Base.Black_Long_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirtsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, "Base.Black_Long_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresJumpers"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, "Base.Black_Long_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresOvershirts"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, "Base.Black_Long_Shirts");
table.insert(ProceduralDistributions.list["ClothingStoresShirts"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Black_Long_Shirts");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Black_Long_Shirts");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Black_Long_Shirts");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Black_Long_Shirts");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);




-----------------------
-- Military Police Hunting PANTS --
-----------------------

-- Ela_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Ela_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Ela_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Ela_Pants");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Ela_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Anorak_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Anorak_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Anorak_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Anorak_Pants");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Anorak_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- M42_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.M42_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.M42_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.M42_Pants");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.M42_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- GEN2_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.GEN2_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.GEN2_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.GEN2_Pants");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.GEN2_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- G3_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.G3_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.G3_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.G3_Pants");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.G3_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- 511_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.511_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.511_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.511_Pants");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.511_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Fast_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Fast_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Fast_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Fast_Pants");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Fast_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);


-- USCM_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.USCM_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.USCM_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.USCM_Pants");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.USCM_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Kelvin_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Kelvin_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Kelvin_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Kelvin_Pants");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Kelvin_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- EOD_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.EOD_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.08);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.EOD_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.08);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.EOD_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.08);

-- JUGG_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.JUGG_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.08);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.JUGG_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.08);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.JUGG_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.08);

-- Hunter_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hunter_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hunter_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Hunter_Pants");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hunter_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Chain_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Chain_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Chain_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Chain_Pants");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Chain_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- Metro_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Metro_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Metro_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Metro_Pants");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Metro_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- MIL_Pants --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.MIL_Pants");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.MIL_Pants");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.MIL_Pants");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.MIL_Pants");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);







-----------------------
-- Other Casual PANTS --
-----------------------

-- TPants_Yoga --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Pants_Yoga");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Pants_Yoga");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Pants_Yoga");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Pants_Yoga");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Pants_Yoga");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Pants_Yoga");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Leather_Pants_Bennett --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Leather_Pants_Bennett");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Leather_Pants_Bennett");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Leather_Pants_Bennett");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Leather_Pants_Bennett");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Leather_Pants_Bennett");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Leather_Pants_Bennett");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Jeans_James --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Jeans_James");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Jeans_James");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Jeans_James");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Jeans_James");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Jeans_James");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Jeans_James");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Jeans_Sebastian --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Jeans_Sebastian");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Jeans_Sebastian");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Jeans_Sebastian");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Jeans_Sebastian");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Jeans_Sebastian");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Jeans_Sebastian");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Jeans_Kidman --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Jeans_Kidman");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Jeans_Kidman");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Jeans_Kidman");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Jeans_Kidman");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Jeans_Kidman");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Jeans_Kidman");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Suit_Fisher --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Suit_Fisher");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Suit_Fisher");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Suit_Fisher");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Suit_Fisher");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Suit_Fisher");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Suit_Fisher");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Adidas_Track_Pants --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Adidas_Track_Pants");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Adidas_Track_Pants");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Adidas_Track_Pants");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Adidas_Track_Pants");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Adidas_Track_Pants");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Adidas_Track_Pants");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Ashe_Jeans --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Ashe_Jeans");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Ashe_Jeans");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Ashe_Jeans");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Ashe_Jeans");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Ashe_Jeans");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Ashe_Jeans");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Hot_Pants --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Hot_Pants");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Hot_Pants");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Hot_Pants");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Hot_Pants");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Hot_Pants");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Hot_Pants");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Hot_Pants_Long --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Hot_Pants_Long");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Hot_Pants_Long");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Hot_Pants_Long");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Hot_Pants_Long");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Hot_Pants_Long");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Hot_Pants_Long");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Hot_Pants_High --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Hot_Pants_High");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Hot_Pants_High");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Hot_Pants_High");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Hot_Pants_High");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Hot_Pants_High");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Hot_Pants_High");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Hot_Pants_Fold --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Hot_Pants_Fold");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Hot_Pants_Fold");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Hot_Pants_Fold");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Hot_Pants_Fold");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Hot_Pants_Fold");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Hot_Pants_Fold");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Jeans_Slim --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Jeans_Slim");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Jeans_Slim");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Jeans_Slim");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Jeans_Slim");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Jeans_Slim");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Jeans_Slim");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Pants_Adidas --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Pants_Adidas");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Pants_Adidas");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Pants_Adidas");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Pants_Adidas");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Pants_Adidas");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Pants_Adidas");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Rose_Jeans --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Rose_Jeans");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Rose_Jeans");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Rose_Jeans");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Rose_Jeans");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Rose_Jeans");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Rose_Jeans");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Flex_Pants --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Flex_Pants");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Flex_Pants");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Flex_Pants");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Flex_Pants");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Flex_Pants");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Flex_Pants");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Check_Pants --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Check_Pants");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Check_Pants");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Check_Pants");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Check_Pants");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Check_Pants");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Check_Pants");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Cargo_Pants --
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, "Base.Cargo_Pants");
table.insert(ProceduralDistributions.list["ClothingStoresPantsFormal"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, "Base.Cargo_Pants");
table.insert(ProceduralDistributions.list["ClothingStoresPants"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Cargo_Pants");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Cargo_Pants");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Cargo_Pants");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Cargo_Pants");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);




-----------------------
-- Other Casual Skirts --
-----------------------

-- Skirt_Nurse --
table.insert(ProceduralDistributions.list["HospitalLockers"].items, "Base.Skirt_Nurse");
table.insert(ProceduralDistributions.list["HospitalLockers"].items, 0.8);
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Base.Skirt_Nurse");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 0.8);

-- Skirt_Office --
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, "Base.Skirt_Office");
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, "Base.Skirt_Office");
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Skirt_Office");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Skirt_Office");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Skirt_Office");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Skirt_Office");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Skirt_Office_Long --
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, "Base.Skirt_Office_Long");
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, "Base.Skirt_Office_Long");
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Skirt_Office_Long");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Skirt_Office_Long");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Skirt_Office_Long");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Skirt_Office_Long");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Skirt_Heather --
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, "Base.Skirt_Heather");
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, "Base.Skirt_Heather");
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Skirt_Heather");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Skirt_Heather");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Skirt_Heather");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Skirt_Heather");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Skirt_Lisa --
table.insert(ProceduralDistributions.list["HospitalLockers"].items, "Base.Skirt_Lisa");
table.insert(ProceduralDistributions.list["HospitalLockers"].items, 0.8);
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Base.Skirt_Lisa");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 0.8);

-- Skirt_Maria --
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, "Base.Skirt_Maria");
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, "Base.Skirt_Maria");
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Skirt_Maria");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Skirt_Maria");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Skirt_Maria");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Skirt_Maria");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Skirt_Check --
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, "Base.Skirt_Check");
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, "Base.Skirt_Check");
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Skirt_Check");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Skirt_Check");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Skirt_Check");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Skirt_Check");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- BR_Skirts --
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, "Base.BR_Skirts");
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, "Base.BR_Skirts");
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.BR_Skirts");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.BR_Skirts");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.BR_Skirts");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.BR_Skirts");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- BR_Skirts_Long --
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, "Base.BR_Skirts_Long");
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, "Base.BR_Skirts_Long");
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.BR_Skirts_Long");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.BR_Skirts_Long");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.BR_Skirts_Long");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.BR_Skirts_Long");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Pencil_Skirts --
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, "Base.Pencil_Skirts");
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, "Base.Pencil_Skirts");
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Pencil_Skirts");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Pencil_Skirts");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Pencil_Skirts");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Pencil_Skirts");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Pencil_Skirts_Long --
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, "Base.Pencil_Skirts_Long");
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, "Base.Pencil_Skirts_Long");
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Pencil_Skirts_Long");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Pencil_Skirts_Long");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Pencil_Skirts_Long");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Pencil_Skirts_Long");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Skirts_SC --
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, "Base.Skirts_SC");
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, "Base.Skirts_SC");
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Skirts_SC");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Skirts_SC");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Skirts_SC");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Skirts_SC");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Skirts_SC_Long --
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, "Base.Skirts_SC_Long");
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, "Base.Skirts_SC_Long");
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Skirts_SC_Long");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Skirts_SC_Long");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Skirts_SC_Long");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Skirts_SC_Long");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Skirts_Side --
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, "Base.Skirts_Side");
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, "Base.Skirts_Side");
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Skirts_Side");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Skirts_Side");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Skirts_Side");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Skirts_Side");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Skirts_Side_Long --
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, "Base.Skirts_Side_Long");
table.insert(ProceduralDistributions.list["ClothingStoresDress"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, "Base.Skirts_Side_Long");
table.insert(ProceduralDistributions.list["ClothingStoresWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Skirts_Side_Long");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Skirts_Side_Long");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Skirts_Side_Long");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Skirts_Side_Long");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);






-----------------------
-- Hazmat & CBRN SUIT --
-----------------------

-- Chempak_Blauer --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Chempak_Blauer");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Chempak_Blauer");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Chempak_Blauer");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- Chempak_BRN --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Chempak_BRN");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Chempak_BRN");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Chempak_BRN");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- Chempak_Tychem --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Chempak_Tychem");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Chempak_Tychem");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Chempak_Tychem");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- Chempak_Level --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Chempak_Level");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Chempak_Level");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Chempak_Level");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- Antibelok --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Antibelok");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Antibelok");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Antibelok");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);


-----------------------
-- Gloves & ETC --
-----------------------

-- Glove_3M --
table.insert(ProceduralDistributions.list["ClothingStoresGloves"].items, "Base.Glove_3M");
table.insert(ProceduralDistributions.list["ClothingStoresGloves"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Glove_3M");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Glove_3M");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Glove_3M");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);


-- Glove_Mechanix --
table.insert(ProceduralDistributions.list["ClothingStoresGloves"].items, "Base.Glove_Mechanix");
table.insert(ProceduralDistributions.list["ClothingStoresGloves"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Glove_Mechanix");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Glove_Mechanix");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Glove_Mechanix");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Glove_Mechanix");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Glove_Mechanix_Pact --
table.insert(ProceduralDistributions.list["ClothingStoresGloves"].items, "Base.Glove_Mechanix_Pact");
table.insert(ProceduralDistributions.list["ClothingStoresGloves"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Glove_Mechanix_Pact");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Glove_Mechanix_Pact");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Glove_Mechanix_Pact");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Glove_Mechanix_Pact");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Arm_Warmer --
table.insert(ProceduralDistributions.list["ClothingStoresGloves"].items, "Base.Arm_Warmer");
table.insert(ProceduralDistributions.list["ClothingStoresGloves"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Arm_Warmer");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Arm_Warmer");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Arm_Warmer");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Glove_Fisher --
table.insert(ProceduralDistributions.list["ClothingStoresGloves"].items, "Base.Glove_Fisher");
table.insert(ProceduralDistributions.list["ClothingStoresGloves"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Glove_Fisher");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Glove_Fisher");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Glove_Fisher");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Glove_Leather --
table.insert(ProceduralDistributions.list["ClothingStoresGloves"].items, "Base.Glove_Leather");
table.insert(ProceduralDistributions.list["ClothingStoresGloves"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Glove_Leather");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Glove_Leather");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Glove_Leather");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Glove_Mustang --
table.insert(ProceduralDistributions.list["ClothingStoresGloves"].items, "Base.Glove_Mustang");
table.insert(ProceduralDistributions.list["ClothingStoresGloves"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Glove_Mustang");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Glove_Mustang");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Glove_Mustang");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);





-----------------------
-- Other Casual Stockings Underwear --
-----------------------

-- Susie_Stocking --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Susie_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Susie_Stocking");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Susie_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Susie_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Susie_Stocking");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Susie_Stocking");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Susie_Stocking");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Susie_Stocking");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Wool_Stocking --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Wool_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Wool_Stocking");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Wool_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Wool_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Wool_Stocking");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Wool_Stocking");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Wool_Stocking");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Wool_Stocking");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Wool_Stocking_Below --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Wool_Stocking_Below");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Wool_Stocking_Below");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Wool_Stocking_Below");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Wool_Stocking_Below");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);

-- Wool_Stocking_Mismatch --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Wool_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Wool_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Wool_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Wool_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);

-- Wool_Stocking_Half --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Wool_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Wool_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Wool_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Wool_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);

-- Lace_Stocking --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Lace_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Lace_Stocking");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Lace_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Lace_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Lace_Stocking");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Lace_Stocking");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Lace_Stocking");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Lace_Stocking");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Lace_Stocking_Mismatch --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Lace_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Lace_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Lace_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Lace_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);

-- Lace_Stocking_Half --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Lace_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Lace_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Lace_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Lace_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);

-- Casual_Stocking --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Casual_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Casual_Stocking");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Casual_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Casual_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Casual_Stocking");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Casual_Stocking");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Casual_Stocking");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Casual_Stocking");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Casual_Stocking_Below --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Casual_Stocking_Below");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Casual_Stocking_Below");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Casual_Stocking_Below");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Casual_Stocking_Below");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);

-- Casual_Stocking_Mismatch --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Casual_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Casual_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Casual_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Casual_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);

-- Casual_Stocking_Half --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Casual_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Casual_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Casual_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Casual_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);

-- Sweater_Stocking --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Sweater_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Sweater_Stocking");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Sweater_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Sweater_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Sweater_Stocking");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Sweater_Stocking");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Sweater_Stocking");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Sweater_Stocking");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Sweater_Stocking_Below --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Sweater_Stocking_Below");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Sweater_Stocking_Below");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Sweater_Stocking_Below");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Sweater_Stocking_Below");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);

-- Sweater_Stocking_Half --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Sweater_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Sweater_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Sweater_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Sweater_Stocking_Half");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);

-- Sweater_Stocking_Mismatch --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Sweater_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Sweater_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Sweater_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Sweater_Stocking_Mismatch");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);

-- Sweater_Stocking_Ripped --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Sweater_Stocking_Ripped");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Sweater_Stocking_Ripped");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Sweater_Stocking_Ripped");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Sweater_Stocking_Ripped");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);

-- Stocking_Belt --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Stocking_Belt");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Stocking_Belt");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Stocking_Belt");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Stocking_Belt");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Stocking_Belt");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Stocking_Belt");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Stocking_Belt");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Stocking_Belt");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Stocking_String --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Stocking_String");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Stocking_String");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Stocking_String");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Stocking_String");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Stocking_String");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Stocking_String");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Stocking_String");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Stocking_String");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Nylon_Stocking --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Nylon_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Nylon_Stocking");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Nylon_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Nylon_Stocking");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Nylon_Stocking");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Nylon_Stocking");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Nylon_Stocking");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Nylon_Stocking");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Lined_Tights --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Lined_Tights");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Lined_Tights");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Lined_Tights");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Lined_Tights");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Lined_Tights");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Lined_Tights");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Lined_Tights");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Lined_Tights");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Sweater_Tights --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Sweater_Tights");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Sweater_Tights");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Sweater_Tights");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Sweater_Tights");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Sweater_Tights");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Sweater_Tights");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Sweater_Tights");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Sweater_Tights");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Ripped_Tights --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Ripped_Tights");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Ripped_Tights");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Ripped_Tights");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Ripped_Tights");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Ripped_Tights");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Ripped_Tights");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Ripped_Tights");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Ripped_Tights");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Sports_Bra --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Sports_Bra");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Sports_Bra");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Sports_Bra");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Sports_Bra");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Sports_Bra");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Sports_Bra");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Sports_Bra");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Sports_Bra");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Calvin_Bra --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Calvin_Bra");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Calvin_Bra");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Calvin_Bra");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Calvin_Bra");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Calvin_Bra");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Calvin_Bra");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Calvin_Bra");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Calvin_Bra");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Calvin_Panties --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Calvin_Panties");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Calvin_Panties");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Calvin_Panties");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Calvin_Panties");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Calvin_Panties");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Calvin_Panties");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Calvin_Panties");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Calvin_Panties");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Ring_Bra --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Ring_Bra");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Ring_Bra");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Ring_Bra");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Ring_Bra");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Ring_Bra");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Ring_Bra");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Ring_Bra");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Ring_Bra");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- BR_Bunny_Suit --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.BR_Bunny_Suit");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.BR_Bunny_Suit");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.BR_Bunny_Suit");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.BR_Bunny_Suit");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.BR_Bunny_Suit");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.BR_Bunny_Suit");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.BR_Bunny_Suit");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.BR_Bunny_Suit");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);

-- Nylon_Stocking_Ripped --
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, "Base.Nylon_Stocking_Ripped");
table.insert(ProceduralDistributions.list["ClothingStoresSocks"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Nylon_Stocking_Ripped");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, "Base.Nylon_Stocking_Ripped");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearWoman"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, "Base.Nylon_Stocking_Ripped");
table.insert(ProceduralDistributions.list["ClothingStoresUnderwearMan"].items, 0.8);
table.insert(ProceduralDistributions.list["BedroomDresser"].items, "Base.Nylon_Stocking_Ripped");
table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.3);
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, "Base.Nylon_Stocking_Ripped");
table.insert(ProceduralDistributions.list["CrateClothesRandom"].items, 0.3);
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "Base.Nylon_Stocking_Ripped");
table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.3);
table.insert(ProceduralDistributions.list["DresserGeneric"].items, "Base.Nylon_Stocking_Ripped");
table.insert(ProceduralDistributions.list["DresserGeneric"].items, 0.3);




-----------------------
-- Military Police Hunting BOOTS --
-----------------------

-- Tac_Boots --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Tac_Boots");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Tac_Boots");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Tac_Boots");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Tac_Boots");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Tac_Boots");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Tac_Boots");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- Boots_Trackstar --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Boots_Trackstar");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Boots_Trackstar");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Boots_Trackstar");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Boots_Trackstar");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Boots_Trackstar");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Boots_Trackstar");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- USCM_Boots --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.USCM_Boots");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.USCM_Boots");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.USCM_Boots");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.USCM_Boots");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- SET_Boots --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.SET_Boots");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.SET_Boots");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.SET_Boots");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.SET_Boots");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Military_Gaiter --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Military_Gaiter");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Military_Gaiter");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Military_Gaiter");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Military_Gaiter");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- OZK_Gaiter --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.OZK_Gaiter");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.OZK_Gaiter");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.OZK_Gaiter");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.OZK_Gaiter");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Metro_Boots --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Metro_Boots");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Metro_Boots");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Metro_Boots");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Metro_Boots");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);





-----------------------
-- Casual BOOTS --
-----------------------

-- Boots_Heather --
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, "Base.Boots_Heather");
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, "Base.Boots_Heather");
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, 0.8);

-- Boots_Bennett --
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, "Base.Boots_Bennett");
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, "Base.Boots_Bennett");
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, 0.8);

-- Boots_James --
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, "Base.Boots_James");
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, "Base.Boots_James");
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, 0.8);

-- Shoes_Lisa --
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Base.Shoes_Lisa");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["HospitalLockers"].items, "Base.Shoes_Lisa");
table.insert(ProceduralDistributions.list["HospitalLockers"].items, 0.8);

-- Boots_Maria --
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, "Base.Boots_Maria");
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, "Base.Boots_Maria");
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, 0.8);

-- Susie_Boots --
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, "Base.Susie_Boots");
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, "Base.Susie_Boots");
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, 0.8);

-- Ashe_Boots --
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, "Base.Ashe_Boots");
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, "Base.Ashe_Boots");
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, 0.8);

-- Mechanic_Boots --
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, "Base.Mechanic_Boots");
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, "Base.Mechanic_Boots");
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, 0.8);

-- Nurse_Shoes --
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Base.Nurse_Shoes");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["HospitalLockers"].items, "Base.Nurse_Shoes");
table.insert(ProceduralDistributions.list["HospitalLockers"].items, 0.8);

-- Rose_Shoes --
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, "Base.Rose_Shoes");
table.insert(ProceduralDistributions.list["ClothingStoresBoots"].items, 0.8);
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, "Base.Rose_Shoes");
table.insert(ProceduralDistributions.list["ClothingStoresShoes"].items, 0.8);




-----------------------
-- Casual Accessories --
-----------------------

-- Hand_Band_Heather --
table.insert(ProceduralDistributions.list["JewelryStorageAll"].items, "Base.Hand_Band_Heather");
table.insert(ProceduralDistributions.list["JewelryStorageAll"].items, 0.8);

-- Choker_Maria --
table.insert(ProceduralDistributions.list["JewelryStorageAll"].items, "Base.Choker_Maria");
table.insert(ProceduralDistributions.list["JewelryStorageAll"].items, 0.8);

-- Earing_Lisa --
table.insert(ProceduralDistributions.list["HospitalLockers"].items, "Base.Earing_Lisa");
table.insert(ProceduralDistributions.list["HospitalLockers"].items, 0.8);
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Base.Earing_Lisa");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 0.8);

-- Ashe_Necktie --
table.insert(ProceduralDistributions.list["JewelryStorageAll"].items, "Base.Ashe_Necktie");
table.insert(ProceduralDistributions.list["JewelryStorageAll"].items, 0.8);




-----------------------
-- Military Police Hunting BAGS --
-----------------------

-- Bag_Sniper_Pack --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_Sniper_Pack");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bag_Sniper_Pack");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bag_Sniper_Pack");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bag_Sniper_Pack");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Bag_ARVN_Rucksack --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_ARVN_Rucksack");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bag_ARVN_Rucksack");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bag_ARVN_Rucksack");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bag_ARVN_Rucksack");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Bag_ST53_Set --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_ST53_Set");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bag_ST53_Set");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bag_ST53_Set");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bag_ST53_Set");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Bag_SSO --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_SSO");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bag_SSO");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bag_SSO");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bag_SSO");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Bag_Radio_Pack --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_Radio_Pack");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bag_Radio_Pack");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bag_Radio_Pack");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bag_Radio_Pack");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Bag_SCBA --
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, "Base.Bag_SCBA");
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, "Base.Bag_SCBA");
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, 0.3);

-- Bag_Tactical_Alice --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_Tactical_Alice");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bag_Tactical_Alice");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bag_Tactical_Alice");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bag_Tactical_Alice");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Bag_Hazard_Cross --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_Hazard_Cross");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bag_Hazard_Cross");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bag_Hazard_Cross");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bag_Hazard_Cross");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- ELA_Bag --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.ELA_Bag");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.ELA_Bag");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.ELA_Bag");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.ELA_Bag");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- KIP5 --
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, "Base.KIP5");
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, "Base.KIP5");
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, 0.3);

-- AP3 --
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, "Base.AP3");
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, 0.3);
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, "Base.AP3");
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, 0.3);

-- IP46 --
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, "Base.IP46");
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, "Base.IP46");
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, 0.3);

-- Sheriff_Bag --
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Sheriff_Bag");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Sheriff_Bag");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.3);

-- Army_Duffle_Bag --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Army_Duffle_Bag");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Army_Duffle_Bag");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Army_Duffle_Bag");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Army_Duffle_Bag");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Trench_Tornister --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Trench_Tornister");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Trench_Tornister");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Trench_Tornister");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Trench_Tornister");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Hunter_Backpack --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Hunter_Backpack");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hunter_Backpack");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Hunter_Backpack");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hunter_Backpack");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Metro_Bag --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Metro_Bag");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Metro_Bag");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Metro_Bag");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Metro_Bag");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Ham_Radio --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Ham_Radio");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Ham_Radio");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Ham_Radio");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Ham_Radio");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);




-----------------------
-- Casual BAGS --
-----------------------

-- Bag_ZIP --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_ZIP");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Bag_ZIP");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Bag_Savotta --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_Savotta");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Bag_Savotta");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Bag_Savotta --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_Savotta");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Bag_Savotta");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Bag_Bush --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_Bush");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Bag_Bush");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Bag_Hunting --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_Hunting");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Bag_Hunting");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Bag_Cat_Pack --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_Cat_Pack");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Bag_Cat_Pack");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Bag_Robbie_Pack --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_Robbie_Pack");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Bag_Robbie_Pack");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- OMNI_Bag --
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Base.OMNI_Bag");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["HospitalLockers"].items, "Base.OMNI_Bag");
table.insert(ProceduralDistributions.list["HospitalLockers"].items, 0.5);

-- Trauma_Bag --
table.insert(ProceduralDistributions.list["HospitalLockers"].items, "Base.Trauma_Bag");
table.insert(ProceduralDistributions.list["HospitalLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Base.Trauma_Bag");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 0.5);

-- Casual_Bag --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Casual_Bag");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Casual_Bag");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Bushcraft_Bag --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bushcraft_Bag");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Bushcraft_Bag");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Bread_Bag --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bread_Bag");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Bread_Bag");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Bread_Sack --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bread_Sack");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Bread_Sack");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Baker_Tent --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Baker_Tent");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Baker_Tent");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Baker_Tent_2 --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Baker_Tent_2");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Baker_Tent_2");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Baker_Tent_3 --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Baker_Tent_3");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Baker_Tent_3");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Baker_Tent_4 --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Baker_Tent_4");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Baker_Tent_4");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Baker_Tent_5 --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Baker_Tent_5");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Baker_Tent_5");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Baker_Tent_6 --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Baker_Tent_6");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Baker_Tent_6");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Messkit --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Messkit");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Messkit");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Messkit_B --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Messkit_B");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Messkit_B");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Fisher_Rope --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Fisher_Rope");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Fisher_Rope");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- Self_Rope --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Self_Rope");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Self_Rope");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);


-----------------------
-- Military Police Hunting SIDE BAGS --
-----------------------

-- Bag_X_Vest --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_X_Vest");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bag_X_Vest");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bag_X_Vest");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bag_X_Vest");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Bag_SKS_Vest --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_SKS_Vest");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bag_SKS_Vest");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bag_SKS_Vest");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bag_SKS_Vest");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Bag_AK_Vest --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bag_AK_Vest");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bag_AK_Vest");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bag_AK_Vest");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bag_AK_Vest");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Rig_Smersh --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Rig_Smersh");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Rig_Smersh");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Rig_Smersh");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Rig_Smersh");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Rig_Smersh_A --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Rig_Smersh_A");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Rig_Smersh_A");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Rig_Smersh_A");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Rig_Smersh_A");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Rig_Smersh_B --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Rig_Smersh_B");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Rig_Smersh_B");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Rig_Smersh_B");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Rig_Smersh_B");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Rig_Smersh_C --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Rig_Smersh_C");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Rig_Smersh_C");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Rig_Smersh_C");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Rig_Smersh_C");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Rig_ELA --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Rig_ELA");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Rig_ELA");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Rig_ELA");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Rig_ELA");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- K1_Bag --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.K1_Bag");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.K1_Bag");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.K1_Bag");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.K1_Bag");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Radio_Rig --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Radio_Rig");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Radio_Rig");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Radio_Rig");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Radio_Rig");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- C420_PAPR --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.C420_PAPR");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.C420_PAPR");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.C420_PAPR");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.C420_PAPR");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Shotgun_Rig --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Shotgun_Rig");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Shotgun_Rig");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Shotgun_Rig");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Shotgun_Rig");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Belt_Pack_AR --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Belt_Pack_AR");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Belt_Pack_AR");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Belt_Pack_AR");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Belt_Pack_AR");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Belt_Pack_Gas --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Belt_Pack_Gas");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Belt_Pack_Gas");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Belt_Pack_Gas");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Belt_Pack_Gas");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Belt_Pack_Gas");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Belt_Pack_Gas");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.3);

-- Belt_Pack_Pouch --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Belt_Pack_Pouch");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Belt_Pack_Pouch");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Belt_Pack_Pouch");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Belt_Pack_Pouch");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Belt_Pack_Pouch");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Belt_Pack_Pouch");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.3);

-- Belt_Pack_Duty --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Belt_Pack_Duty");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Belt_Pack_Duty");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Belt_Pack_Duty");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Belt_Pack_Duty");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Belt_Pack_Duty");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Belt_Pack_Duty");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.3);

-- Belt_Pack_War --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Belt_Pack_War");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Belt_Pack_War");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Belt_Pack_War");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Belt_Pack_War");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- D3CR --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.D3CR");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.D3CR");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.D3CR");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.D3CR");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Trench_Ammo_Pack --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Trench_Ammo_Pack");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Trench_Ammo_Pack");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Trench_Ammo_Pack");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Trench_Ammo_Pack");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Trench_Grenade_Pack --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Trench_Grenade_Pack");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Trench_Grenade_Pack");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Trench_Grenade_Pack");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Trench_Grenade_Pack");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- GM15_Canister --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.GM15_Canister");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.GM15_Canister");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.GM15_Canister");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.GM15_Canister");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);



-----------------------
-- Casual SIDEBAGS --
-----------------------

-- Bottle_Bag --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Bottle_Bag");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Bottle_Bag");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);

-- OMNI_Pouch --
table.insert(ProceduralDistributions.list["HospitalLockers"].items, "Base.OMNI_Pouch");
table.insert(ProceduralDistributions.list["HospitalLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Base.OMNI_Pouch");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 0.5);


-- Ashe_Gear --
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, "Base.Ashe_Gear");
table.insert(ProceduralDistributions.list["ArmySurplusBackpacks"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, "Base.Ashe_Gear");
table.insert(ProceduralDistributions.list["CampingStoreBackpacks"].items, 0.5);



-----------------------
-- Military Police Hunting HATS --
-----------------------

-- Hat_Tactical_Boonie --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hat_Tactical_Boonie");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hat_Tactical_Boonie");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Hat_Tactical_Boonie");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hat_Tactical_Boonie");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Hat_Tactical_Boonie_Fold --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hat_Tactical_Boonie_Fold");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hat_Tactical_Boonie_Fold");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Hat_Tactical_Boonie_Fold");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hat_Tactical_Boonie_Fold");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Hat_Tactical_Cap --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hat_Tactical_Cap");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hat_Tactical_Cap");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Hat_Tactical_Cap");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Hat_Tactical_Cap");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hat_Tactical_Cap");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Hat_Tactical_Cap");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- Hat_Tactical_Cap_Camo --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hat_Tactical_Cap_Camo");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hat_Tactical_Cap_Camo");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Hat_Tactical_Cap_Camo");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Hat_Tactical_Cap_Camo");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hat_Tactical_Cap_Camo");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Hat_Tactical_Cap_Camo");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- Hat_Patrol_Cap --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hat_Patrol_Cap");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hat_Patrol_Cap");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Hat_Patrol_Cap");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Hat_Patrol_Cap");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hat_Patrol_Cap");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Hat_Patrol_Cap");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- Hat_Tactical_Beret --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hat_Tactical_Beret");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hat_Tactical_Beret");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Hat_Tactical_Beret");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Hat_Tactical_Beret");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hat_Tactical_Beret");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Hat_Tactical_Beret");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- Officer_Hat --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Officer_Hat");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Officer_Hat");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Officer_Hat");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Officer_Hat");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Officer_Hat");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Officer_Hat");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- Police_Officer_Hat --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Police_Officer_Hat");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Police_Officer_Hat");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Police_Officer_Hat");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Police_Officer_Hat");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Police_Officer_Hat");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Police_Officer_Hat");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- ELA_Cap --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.ELA_Cap");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.ELA_Cap");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.ELA_Cap");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.ELA_Cap");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Round_Cap_Police --
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Round_Cap_Police");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Round_Cap_Police");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);

-- Sniper_Veil --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Sniper_Veil");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Sniper_Veil");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Sniper_Veil");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Sniper_Veil");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);

-- Round_Cap_Casual --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Round_Cap_Casual");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Round_Cap_Casual");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Round_Cap_Casual");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Round_Cap_Casual");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.8);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Round_Cap_Casual");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.8);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Round_Cap_Casual");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.8);




-----------------------
-- CASUAL HATS --
-----------------------

-- Bear_Mask --
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Bear_Mask");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bear_Mask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);

-- Hat_Tactical_Boonie --
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Hat_Tactical_Boonie");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.8);

-- Hat_Tactical_Boonie_Fold --
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Hat_Tactical_Boonie_Fold");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.8);

-- Hat_Lisa_Cap --
table.insert(ProceduralDistributions.list["HospitalLockers"].items, "Base.Hat_Lisa_Cap");
table.insert(ProceduralDistributions.list["HospitalLockers"].items, 0.8);
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Base.Hat_Lisa_Cap");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 0.8);

-- Hat_Tactical_Cap --
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Hat_Tactical_Cap");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.8);

-- Hat_Tactical_Cap_Camo --
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Hat_Tactical_Cap_Camo");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.8);

-- Hat_Patrol_Cap --
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Hat_Patrol_Cap");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.8);

-- Ashe_Hat --
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Ashe_Hat");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.8);

-- Worn_Beanie --
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Worn_Beanie");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.8);

-- Round_Cap_Fisher --
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Round_Cap_Fisher");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.8);

-- Rose_Cap --
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Rose_Cap");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.8);



-----------------------
-- Military Police Hunting HELMETS --
-----------------------

-- Hat_FAST_Opscore --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hat_FAST_Opscore");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hat_FAST_Opscore");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hat_FAST_Opscore");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Hat_Gentex_Helmet --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hat_Gentex_Helmet");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hat_Gentex_Helmet");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hat_Gentex_Helmet");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Hat_HGU56 --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hat_HGU56");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hat_HGU56");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hat_HGU56");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Hat_PSGT_Helmet --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hat_PSGT_Helmet");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hat_PSGT_Helmet");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hat_PSGT_Helmet");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Hat_PSGT_Helmet_Camo --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hat_PSGT_Helmet_Camo");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hat_PSGT_Helmet_Camo");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hat_PSGT_Helmet_Camo");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Wolf_Helmet --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Wolf_Helmet");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Wolf_Helmet");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Wolf_Helmet");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- USCM_Helmet --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.USCM_Helmet");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.USCM_Helmet");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.USCM_Helmet");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Viper_Helmet --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Viper_Helmet");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Viper_Helmet");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Viper_Helmet");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.05);

-- Maska_1_Helmet --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Maska_1_Helmet");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Maska_1_Helmet");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Maska_1_Helmet");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- 6B6_Helmet --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.6B6_Helmet");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.6B6_Helmet");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.6B6_Helmet");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- 1916_Helmet --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.1916_Helmet");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.1916_Helmet");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.1916_Helmet");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- 1916_Helmet_ON --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.1916_Helmet_ON");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.1916_Helmet_ON");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.1916_Helmet_ON");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- EOD_Helmet --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.EOD_Helmet");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.EOD_Helmet");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.EOD_Helmet");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.05);



-----------------------
-- CASUAL HELMETS --
-----------------------

-- Hat_MX_Helmet_Glass --
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Hat_MX_Helmet_Glass");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Hat_MX_Helmet_Glass");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);

-- Vader_Mask --
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Vader_Mask");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Vader_Mask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);

-- Vader_MASK --
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Vader_Helmet");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Vader_Helmet");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);

-- Fire_Helmet --
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, "Base.Fire_Helmet");
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, 0.8);
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, "Base.Fire_Helmet");
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, 0.8);



-----------------------
-- Military Police Hunting HELMET ATTACHMENTS --
-----------------------

-- Hat_PSGT_Visor --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hat_PSGT_Visor");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hat_PSGT_Visor");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hat_PSGT_Visor");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Hat_Riot_Visor --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hat_Riot_Visor");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hat_Riot_Visor");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hat_Riot_Visor");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Maska_1_Visor --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Maska_1_Visor");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Maska_1_Visor");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Maska_1_Visor");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- 6B6_Visor --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.6B6_Visor");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.6B6_Visor");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.6B6_Visor");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Vityaz_Visor --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Vityaz_Visor");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Vityaz_Visor");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Vityaz_Visor");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- ZSH_Visor --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.ZSH_Visor");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.ZSH_Visor");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.ZSH_Visor");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Fire_Visor --
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, "Base.Fire_Visor");
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, "Base.Fire_Visor");
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, 0.3);

-- Viper_Helmet_Shield --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Viper_Helmet_Shield");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Viper_Helmet_Shield");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Viper_Helmet_Shield");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.05);

-- 1916_Helmet_Visor --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.1916_Helmet_Visor");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.1916_Helmet_Visor");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.1916_Helmet_Visor");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- 1916_Helmet_Visor_2 --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.1916_Helmet_Visor_2");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.1916_Helmet_Visor_2");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.1916_Helmet_Visor_2");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- EOD_Visor --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.EOD_Visor");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.EOD_Visor");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.EOD_Visor");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.05);

-- EOD_Shield --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.EOD_Shield");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.EOD_Shield");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.EOD_Shield");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.05);

-- JUGG_Visor --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.JUGG_Visor");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.JUGG_Visor");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.JUGG_Visor");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.05);







-----------------------
-- Military Police Hunting ARMOR --
-----------------------

-- Armor_Defender --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Armor_Defender");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Armor_Defender");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Armor_Defender");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- Armor_Defender_Set --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Armor_Defender_Set");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Armor_Defender_Set");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Armor_Defender_Set");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- Bag_Plate_Carrier --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Bag_Plate_Carrier");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bag_Plate_Carrier");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bag_Plate_Carrier");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- Armor_6B13 --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Armor_6B13");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Armor_6B13");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Armor_6B13");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- Sheriff_Vest --
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Sheriff_Vest");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Sheriff_Vest");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.3);

-- Sheriff_Vest_Full --
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Sheriff_Vest_Full");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Sheriff_Vest_Full");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.3);

-- Wolf_Plate_Carrier --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Wolf_Plate_Carrier");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Wolf_Plate_Carrier");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Wolf_Plate_Carrier");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- Wolf_Plate_Carrier_B --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Wolf_Plate_Carrier_B");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Wolf_Plate_Carrier_B");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Wolf_Plate_Carrier_B");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- EXO_Suit --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.EXO_Suit");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.01);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.EXO_Suit");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.01);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.EXO_Suit");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.01);

-- SET_Armor --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.SET_Armor");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.SET_Armor");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.SET_Armor");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- SET_Armor_FULL --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.SET_Armor_FULL");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.SET_Armor_FULL");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.SET_Armor_FULL");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- USCM_Armor --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.USCM_Armor");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.USCM_Armor");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.USCM_Armor");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

-- EOD_Armor --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.EOD_Armor");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.EOD_Armor");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.EOD_Armor");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.05);

-- JUGG_Armor --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.JUGG_Armor");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.JUGG_Armor");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.05);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.JUGG_Armor");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.05);

-- Hunter_Armor --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hunter_Armor");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hunter_Armor");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hunter_Armor");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);



-----------------------
-- ARM & LEG ATTACHMENTS --
-----------------------


-- Wolf_Knee_Pad --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Wolf_Knee_Pad");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Wolf_Knee_Pad");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Wolf_Knee_Pad");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);


-- SET_PAD --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.SET_PAD");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.SET_PAD");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.SET_PAD");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- SET_ARM_PAD --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.SET_ARM_PAD");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.SET_ARM_PAD");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.SET_ARM_PAD");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Armband --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Armband");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Armband");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Armband");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Armband_Long --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Armband_Long");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Armband_Long");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Armband_Long");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Armband_Short --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Armband_Short");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Armband_Short");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Armband_Short");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Shell_Chest_Bandolier --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Shell_Chest_Bandolier");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Shell_Chest_Bandolier");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Shell_Chest_Bandolier");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Shell_Chest_Bandolier");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Shell_Chest_Bandolier");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.3);

-- Shell_Arm_Bandolier --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Shell_Arm_Bandolier");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Shell_Arm_Bandolier");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Shell_Arm_Bandolier");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Shell_Arm_Bandolier");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Shell_Arm_Bandolier");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.3);

-- Shell_Thigh_Bandolier --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Shell_Thigh_Bandolier");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Shell_Thigh_Bandolier");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Shell_Thigh_Bandolier");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Shell_Thigh_Bandolier");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Shell_Thigh_Bandolier");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.3);

-- Mechanic_Boots_Armor --
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Mechanic_Boots_Armor");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.8);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Mechanic_Boots_Armor");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.8);

-- Hunter_Arm --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hunter_Arm");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hunter_Arm");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hunter_Arm");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Hunter_Leg --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hunter_Leg");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hunter_Leg");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hunter_Leg");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Hunter_Knee --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hunter_Knee");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hunter_Knee");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hunter_Knee");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Hunter_Knife --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hunter_Knife");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hunter_Knife");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hunter_Knife");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Metro_Knee --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Metro_Knee");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Metro_Knee");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Metro_Knee");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Metro_Bandolier --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Metro_Bandolier");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Metro_Bandolier");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Metro_Bandolier");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Metro_IDA --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Metro_IDA");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Metro_IDA");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Metro_IDA");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);


-----------------------
--GLASSES & GOGGLES --
-----------------------

-- Glasses_X1000 --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Glasses_X1000");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Glasses_X1000");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Glasses_X1000");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Glasses_X1000");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresEyewear"].items, "Base.Glasses_X1000");
table.insert(ProceduralDistributions.list["ClothingStoresEyewear"].items, 0.5);

-- Glasses_Napier --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Glasses_Napier");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Glasses_Napier");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Glasses_Napier");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Glasses_Napier");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Glasses_Napier");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Glasses_Napier");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresEyewear"].items, "Base.Glasses_Napier");
table.insert(ProceduralDistributions.list["ClothingStoresEyewear"].items, 0.5);

-- Glasses_Crewman_Goggles --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Glasses_Crewman_Goggles");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Glasses_Crewman_Goggles");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Glasses_Crewman_Goggles");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Glasses_Crewman_Goggles");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresEyewear"].items, "Base.Glasses_Crewman_Goggles");
table.insert(ProceduralDistributions.list["ClothingStoresEyewear"].items, 0.5);

-- SET_Goggles --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.SET_Goggles");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.SET_Goggles");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.SET_Goggles");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.SET_Goggles");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresEyewear"].items, "Base.SET_Goggles");
table.insert(ProceduralDistributions.list["ClothingStoresEyewear"].items, 0.5);

-- ELA_Goggles --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.ELA_Goggles");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.ELA_Goggles");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.ELA_Goggles");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.ELA_Goggles");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresEyewear"].items, "Base.ELA_Goggles");
table.insert(ProceduralDistributions.list["ClothingStoresEyewear"].items, 0.5);

-- Pilot_Sunglass --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Pilot_Sunglass");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Pilot_Sunglass");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Pilot_Sunglass");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Pilot_Sunglass");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Pilot_Sunglass");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Pilot_Sunglass");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresEyewear"].items, "Base.Pilot_Sunglass");
table.insert(ProceduralDistributions.list["ClothingStoresEyewear"].items, 0.5);




-----------------------
-- HEADSETS --
-----------------------

-- Aviation_Headsets --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Aviation_Headsets");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Aviation_Headsets");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Aviation_Headsets");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Aviation_Headsets");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Aviation_Headsets");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Aviation_Headsets");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);

-- Comtac_Headsets --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Comtac_Headsets");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Comtac_Headsets");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Comtac_Headsets");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Comtac_Headsets");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);

-- Comtac4_Headsets --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Comtac4_Headsets");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Comtac4_Headsets");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Comtac4_Headsets");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Comtac4_Headsets");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);

-- Comtac4_Headsets --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Bowman_Headsets");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bowman_Headsets");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bowman_Headsets");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bowman_Headsets");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);



-----------------------
-- NIGHT VISIONS --
-----------------------

-- B42 reads saved SandboxVars during OnPreDistributionMerge.  Defer the NV
-- entries to that event so the documented spawn multiplier actually works.
-- Only the OFF/raised state is spawned; ON copies already present in saves
-- remain fully compatible through BritaArmor_NVCompat.
local RR_NV_TARGET_LISTS = {
    "ArmySurplusOutfit",
    "ArmyStorageOutfit",
    "LockerArmyBedroom",
}

local RR_NV_STATE_PAIRS = {
    { "Base.Hat_Sam_NV_ON",          "Base.Hat_Sam_NV_OFF" },
    { "Base.Hat_PVS15_ON",           "Base.Hat_PVS15_OFF" },
    { "Base.Hat_PVS15_Harness_ON",   "Base.Hat_PVS15_Harness_OFF" },
    { "Base.Hat_NV18_ON",            "Base.Hat_NV18_OFF" },
    { "Base.Hat_NV18_Harness_ON",    "Base.Hat_NV18_Harness_OFF" },
    { "Base.NV_PVS5_ON",             "Base.NV_PVS5_OFF" },
    { "Base.NV_PNV_57_ON",           "Base.NV_PNV_57_OFF" },
    { "Base.NV_PVS7_ON",             "Base.NV_PVS7_OFF" },
    { "Base.NV_PVS21_ON",            "Base.NV_PVS21_OFF" },
    { "Base.NV_GPNVG_18_ON",         "Base.NV_GPNVG_18_OFF" },
}

local RR_NV_BASE_WEIGHT = 0.05

local function RR_getNVSpawnMultiplier()
    if NV and NV.Sandbox and NV.Sandbox.GetItemSpawnMultiplier then
        local ok, value = pcall(NV.Sandbox.GetItemSpawnMultiplier)
        value = ok and tonumber(value) or nil
        if value then
            return math.max(0.0, math.min(100.0, value))
        end
    end

    local sandboxVars = rawget(_G, "SandboxVars")
    local moduleVars = sandboxVars and sandboxVars.NVFramework or nil
    local value = moduleVars and tonumber(moduleVars.ItemSpawnMultiplier) or 1.0
    return math.max(0.0, math.min(100.0, value or 1.0))
end

local function RR_removeNVEntries(items, stateLookup)
    local removed = 0
    local index = 1
    while index <= #items do
        if stateLookup[items[index]] then
            table.remove(items, index)
            if index <= #items then
                table.remove(items, index)
            end
            removed = removed + 1
        else
            index = index + 2
        end
    end
    return removed
end

local function RR_injectNightVisionLoot()
    if not ProceduralDistributions or not ProceduralDistributions.list then
        print("[BritaArmor] NV distribution unavailable; skipping night-vision loot.")
        return
    end

    local stateLookup = {}
    for _, pair in ipairs(RR_NV_STATE_PAIRS) do
        stateLookup[pair[1]] = true
        stateLookup[pair[2]] = true
    end

    local multiplier = RR_getNVSpawnMultiplier()
    local weight = RR_NV_BASE_WEIGHT * multiplier
    local removed = 0
    local injected = 0
    local missingLists = {}
    local missingItems = {}

    for _, listName in ipairs(RR_NV_TARGET_LISTS) do
        local distribution = ProceduralDistributions.list[listName]
        if not distribution or not distribution.items then
            missingLists[#missingLists + 1] = listName
        else
            removed = removed + RR_removeNVEntries(distribution.items, stateLookup)
            if weight > 0 then
                for _, pair in ipairs(RR_NV_STATE_PAIRS) do
                    local fullType = pair[2]
                    local scriptItem = ScriptManager and ScriptManager.instance
                        and ScriptManager.instance:getItem(fullType) or nil
                    if scriptItem then
                        table.insert(distribution.items, fullType)
                        table.insert(distribution.items, weight)
                        injected = injected + 1
                    else
                        missingItems[fullType] = true
                    end
                end
            end
        end
    end

    local missingItemCount = 0
    for _ in pairs(missingItems) do
        missingItemCount = missingItemCount + 1
    end

    print(string.format(
        "[BritaArmor] NV loot: injected=%d, removedDuplicates=%d, multiplier=%.2f, weight=%.4f, missingLists=%d, missingItems=%d.",
        injected, removed, multiplier, weight, #missingLists, missingItemCount
    ))

    if #missingLists > 0 then
        print("[BritaArmor] NV loot missing lists: " .. table.concat(missingLists, ", "))
    end
    if missingItemCount > 0 then
        local names = {}
        for fullType in pairs(missingItems) do
            names[#names + 1] = fullType
        end
        table.sort(names)
        print("[BritaArmor] NV loot missing items: " .. table.concat(names, ", "))
    end
end

-- Keep one stable event wrapper across Lua reloads.  The implementation can
-- be replaced by a reloaded file without stacking another callback.
BritaArmorNVSpawn = BritaArmorNVSpawn or {}
BritaArmorNVSpawn.Inject = RR_injectNightVisionLoot

if not BritaArmorNVSpawn.HookRegistered then
    BritaArmorNVSpawn.Hook = function()
        if BritaArmorNVSpawn and BritaArmorNVSpawn.Inject then
            BritaArmorNVSpawn.Inject()
        end
    end
    Events.OnPreDistributionMerge.Add(BritaArmorNVSpawn.Hook)
    BritaArmorNVSpawn.HookRegistered = true
end



-----------------------
-- PONCHOS & CLOAK --
-----------------------

-- Bag_Sniper_Hood --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Bag_Sniper_Hood");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bag_Sniper_Hood");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bag_Sniper_Hood");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bag_Sniper_Hood");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);

-- Bag_Sniper_Suit --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Bag_Sniper_Suit");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bag_Sniper_Suit");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bag_Sniper_Suit");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bag_Sniper_Suit");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);

-- Military_Cloak --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Military_Cloak");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Military_Cloak");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Military_Cloak");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);

-- Military_Ghillie --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Military_Ghillie");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Military_Ghillie");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Military_Ghillie");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Military_Ghillie");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);

-- Military_Ghillie_Hat_Mask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Military_Ghillie_Hat_Mask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Military_Ghillie_Hat_Mask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Military_Ghillie_Hat_Mask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Military_Ghillie_Hat_Mask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);

-- Ashe_Cloak --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Ashe_Cloak");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Ashe_Cloak");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Ashe_Cloak");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Ashe_Cloak");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.5);

-- Apron_Side --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Apron_Side");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Apron_Side");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Apron_Side");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Apron_Side");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.5);

-- Star_Cape --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Star_Cape");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Star_Cape");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Star_Cape");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Star_Cape");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.5);

-- Vader_Cape --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Vader_Cape");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Vader_Cape");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Vader_Cape");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Vader_Cape");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.5);

-- Kenobi_Cape --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Kenobi_Cape");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Kenobi_Cape");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, "Base.Kenobi_Cape");
table.insert(ProceduralDistributions.list["ClothingStorageLegwear"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, "Base.Kenobi_Cape");
table.insert(ProceduralDistributions.list["ClothingStorageAllJackets"].items, 0.5);



-----------------------
-- MASK & BALACLAVA MASK --
-----------------------

-- Bandana_Mask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Bandana_Mask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bandana_Mask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bandana_Mask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Bandana_Mask");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bandana_Mask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Bandana_Mask");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Bandana_Mask");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.5);

-- Bandana_Mask_Camo --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Bandana_Mask_Camo");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bandana_Mask_Camo");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bandana_Mask_Camo");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Bandana_Mask_Camo");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bandana_Mask_Camo");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Bandana_Mask_Camo");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Bandana_Mask_Camo");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.5);

-- Bandana_Mask_Other --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Bandana_Mask_Other");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Bandana_Mask_Other");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Bandana_Mask_Other");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Bandana_Mask_Other");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Bandana_Mask_Other");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Bandana_Mask_Other");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Bandana_Mask_Other");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.5);

-- Balaclava_Mask_1 --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Balaclava_Mask_1");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Balaclava_Mask_1");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Balaclava_Mask_1");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Balaclava_Mask_1");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Balaclava_Mask_1");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Balaclava_Mask_1");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Balaclava_Mask_1");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.5);

-- Balaclava_Mask_2 --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Balaclava_Mask_2");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Balaclava_Mask_2");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Balaclava_Mask_2");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Balaclava_Mask_2");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Balaclava_Mask_2");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Balaclava_Mask_2");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Balaclava_Mask_2");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.5);

-- Balaclava_Mask_3 --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Balaclava_Mask_3");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Balaclava_Mask_3");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Balaclava_Mask_3");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Balaclava_Mask_3");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Balaclava_Mask_3");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Balaclava_Mask_3");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Balaclava_Mask_3");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.5);

-- Balaclava_Mask_4 --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Balaclava_Mask_4");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Balaclava_Mask_4");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Balaclava_Mask_4");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Balaclava_Mask_4");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Balaclava_Mask_4");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Balaclava_Mask_4");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Balaclava_Mask_4");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.5);

-- Balaclava_Mask_5 --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Balaclava_Mask_5");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Balaclava_Mask_5");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Balaclava_Mask_5");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Balaclava_Mask_5");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Balaclava_Mask_5");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Balaclava_Mask_5");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Balaclava_Mask_5");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.5);

-- Balaclava_Mask_6 --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Balaclava_Mask_6");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Balaclava_Mask_6");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Balaclava_Mask_6");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Balaclava_Mask_6");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Balaclava_Mask_6");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Balaclava_Mask_6");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Balaclava_Mask_6");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.5);

-- Scarf_Mask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Scarf_Mask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Scarf_Mask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Scarf_Mask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Scarf_Mask");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Scarf_Mask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Scarf_Mask");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Scarf_Mask");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.5);

-- Scarf_Mask_Camo --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Scarf_Mask_Camo");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Scarf_Mask_Camo");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Scarf_Mask_Camo");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Scarf_Mask_Camo");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Scarf_Mask_Camo");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Scarf_Mask_Camo");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Scarf_Mask_Camo");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.5);

-- Scarf_Mask_Hunting --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Scarf_Mask_Hunting");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Scarf_Mask_Hunting");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Scarf_Mask_Hunting");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Scarf_Mask_Hunting");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Scarf_Mask_Hunting");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Scarf_Mask_Hunting");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Scarf_Mask_Hunting");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.5);

-- Scarf_Mask_Casual --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Scarf_Mask_Casual");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Scarf_Mask_Casual");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Scarf_Mask_Casual");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Scarf_Mask_Casual");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Scarf_Mask_Casual");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Scarf_Mask_Casual");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Scarf_Mask_Casual");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.5);

-- Scarf_Mask_Ashe --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Scarf_Mask_Ashe");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Scarf_Mask_Ashe");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Scarf_Mask_Ashe");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Scarf_Mask_Ashe");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Scarf_Mask_Ashe");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.5);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Scarf_Mask_Ashe");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, "Base.Scarf_Mask_Ashe");
table.insert(ProceduralDistributions.list["ClothingStoresHeadwear"].items, 0.5);



-----------------------
-- GAS MASKS --
-----------------------

-- Hat_MSA_Gas_Mask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hat_MSA_Gas_Mask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hat_MSA_Gas_Mask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Hat_MSA_Gas_Mask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Base.Hat_MSA_Gas_Mask");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hat_MSA_Gas_Mask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.Hat_MSA_Gas_Mask");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.3);

-- K1_Gasmask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.K1_Gasmask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.K1_Gasmask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.K1_Gasmask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- K1_Hood --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.K1_Hood");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.K1_Hood");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.K1_Hood");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- K1_Half --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.K1_Half");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.K1_Half");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.K1_Half");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.K1_Half");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- PMK1_Gasmask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.PMK1_Gasmask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.PMK1_Gasmask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.PMK1_Gasmask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.PMK1_Gasmask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- PMK1_Half --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.PMK1_Half");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.PMK1_Half");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.PMK1_Half");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.PMK1_Half");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- PMK2_Gasmask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.PMK2_Gasmask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.PMK2_Gasmask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.PMK2_Gasmask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.PMK2_Gasmask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- PMK2_Half --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.PMK2_Half");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.PMK2_Half");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.PMK2_Half");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.PMK2_Half");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- S10_Gasmask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.S10_Gasmask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.S10_Gasmask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.S10_Gasmask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.S10_Gasmask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- S10_Gasmask_Set --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.S10_Gasmask_Set");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.S10_Gasmask_Set");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.S10_Gasmask_Set");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.S10_Gasmask_Set");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- GP4U_Gasmask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.GP4U_Gasmask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.GP4U_Gasmask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.GP4U_Gasmask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.GP4U_Gasmask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- MM1_Gasmask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.MM1_Gasmask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.MM1_Gasmask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.MM1_Gasmask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.MM1_Gasmask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- SHMS_Gasmask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.SHMS_Gasmask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.SHMS_Gasmask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.SHMS_Gasmask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.SHMS_Gasmask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- SHMS_Gasmask_Set --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.SHMS_Gasmask_Set");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.SHMS_Gasmask_Set");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.SHMS_Gasmask_Set");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.SHMS_Gasmask_Set");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- GP5M_Gasmask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.GP5M_Gasmask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.GP5M_Gasmask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.GP5M_Gasmask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.GP5M_Gasmask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- PMG_Gasmask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.PMG_Gasmask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.PMG_Gasmask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.PMG_Gasmask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.PMG_Gasmask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- GM15_Gasmask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.GM15_Gasmask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.GM15_Gasmask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.GM15_Gasmask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.GM15_Gasmask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- GM17_Gasmask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.GM17_Gasmask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.GM17_Gasmask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.GM17_Gasmask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.GM17_Gasmask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Metro_Gasmask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Metro_Gasmask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Metro_Gasmask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Metro_Gasmask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Metro_Gasmask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Chain_Mask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Chain_Mask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Chain_Mask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Chain_Mask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Chain_Mask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);

-- Hunter_Mask --
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Base.Hunter_Mask");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Base.Hunter_Mask");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 0.3);
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, "Base.Hunter_Mask");
table.insert(ProceduralDistributions.list["CampingStoreClothes"].items, 0.3);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.Hunter_Mask");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.3);



-----------------------
-- COSTUME --
-----------------------






