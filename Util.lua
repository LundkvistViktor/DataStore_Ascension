local VANITY_ITEMS = VANITY_ITEMS

local slotsTypes_modules = {
	INVTYPE_HEAD = MogIt.base.AddSlot("Head",...),
	INVTYPE_SHOULDER = MogIt.base.AddSlot("Shoulder",...),
	INVTYPE_CLOAK = MogIt.base.AddSlot("Back",...),
	INVTYPE_CHEST = MogIt.base.AddSlot("Chest",...),
	INVTYPE_ROBE = MogIt.base.AddSlot("Chest",...),
	INVTYPE_BODY = MogIt.base.AddSlot("Shirt",...),
    INVTYPE_TABARD = MogIt.base.AddSlot("Tabard",...),
    INVTYPE_WRIST = MogIt.base.AddSlot("Wrist",...),
    INVTYPE_HAND = MogIt.base.AddSlot("Hands",...),
    INVTYPE_WAIST = MogIt.base.AddSlot("Waist",...),
    INVTYPE_LEGS = MogIt.base.AddSlot("Legs",...),
    INVTYPE_FEET = MogIt.base.AddSlot("Feet",...),
    INVTYPE_WEAPON = MogIt.base.AddSlot("MainHand",...),
    INVTYPE_2HWEAPON = MogIt.base.AddSlot("MainHand",...),
    INVTYPE_SHIELD = MogIt.base.AddSlot("Shield",...),
    INVTYPE_HOLDABLE = MogIt.base.AddSlot("OffHand",...),
    INVTYPE_RANGED = MogIt.base.AddSlot("Ranged",...),
    INVTYPE_RANGEDRIGHT = MogIt.base.AddSlot("Ranged",...),
    INVTYPE_THROWN = MogIt.base.AddSlot("MainHand",...),
}

-- local function refresh_vanity()
--     local jsonData = LoadAscensionContentJSON("VanityCollectionData")
--     jsonData = jsonData and C_Serialize:FromJSON(jsonData)

--     assert(jsonData, "Data\\VanityItems: Failed to deserialize Data\\Content\\VanityCollectionData.json")

--     for _, data in ipairs(jsonData) do
--         VANITY_ITEMS[data.itemid] = tcopy(data)

--         if data.learnedSpell and data.learnedSpell > 0 then
--             VANITY_SPELL_REFERENCE[data.learnedSpell] = data.itemid
--         end

--         if data.contentsPreview and data.contentsPreview ~= "" then 
--             local items = string.SplitToTable(data.contentsPreview, " ", tonumber)
--             for _, itemId in ipairs(items) do
--                 VANITY_CONTENT_REFERENCE[itemId] = data.itemid
--             end
--         end
--     end
-- end

local function addByItemID(itemID, storeID)
    TryCacheItem(itemID) -- wierdly, this is needed to get the item's name
    local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType,
    itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemID)
    if slotsTypes_modules[itemEquipLoc] then
        slotsTypes_modules[itemEquipLoc](itemID,itemID,itemName,itemLevel,itemRarity,itemMinLevel,nil,nil,nil,itemSubType,nil,nil,nil,nil,nil, storeID)
    end
end

-- refresh_vanity()

for k,v in pairs(VANITY_ITEMS) do
    local itemID = v.itemid
    local contentsPreview = v.contentsPreview
    if contentsPreview then
        local storeID = itemID
        for i,v in pairs(contentsPreview) do
            local itemID = tonumber(v)
            if itemID then
                addByItemID(itemID, storeID)
            end
        end
    else
        addByItemID(itemID, itemID)
    end
end