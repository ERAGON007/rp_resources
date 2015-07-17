--[[
	Przedmioty:
	Broń: Typ 1, podtyp: [0] typ broni, [1] amunicja
	Amunicja: Typ 2, podtyp [0] typ broni, [1] ilość
]]--

db = exports.rp_db

function createItem(name, type, subtypes)
	if not name or not type then
		return false
	end
	db:zapytanie("INSERT INTO `rp_items` SET `name`=?, `type`=?, `subtypes`=?", name, type, subtypes)
	local itemid = db:pobierzWyniki("SELECT `UID` FROM `rp_items` WHERE `name`=?, `type`=?, `subtypes`=? ORDER BY `UID` DESC LIMIT 1;", name, type, subtypes)
	return itemid.UID
end

function getItemInfo(itemUID)
	if not itemUID then return false end
	local itemInfo = db:pobierzWyniki("SELECT * FROM `rp_items` WHERE `UID`=? LIMIT 1;", itemUID)
	return itemInfo
end

function setItemInfo(itemUID, itemInfo)
	if not itemUID or not itemInfo then return false end
	db:zapytanie("UPDATE `rp_items` SET `name`=?, `type`=?, `subtypes`=?, `ownertype`=?, `ownerid`=?, `posX`=?, `posY`=?, `posZ`=? WHERE `UID`=?", itemInfo.name, itemInfo.type,
		itemInfo.subtypes,
		itemInfo.ownertype,
		itemInfo.ownerid,
		itemInfo.posX,
		itemInfo.posY,
		itemInfo.posZ,
		itemUID)
end

function setItemIsInUse(itemUID, using)
	if not itemUID then return false end
	db:zapytanie("UPDATE `rp_items` SET `inUse`=? WHERE `UID`=?", using, itemUID)
end

function getItemIsInUse(itemUID)
	if not itemUID then return false end
	itemInfo = getItemInfo(itemUID)
	return itemInfo.inUse
end

function subtypesToTable(subtypes)
	local subtypesTable = {}
	local i = 0
	for subtype in string.gmatch(subtypes, "%d+") do
		subtypesTable[i] = tonumber(subtype)
		i = i + 1
	end
	return subtypesTable
end

function tableToSubtypes(table)
	local subtypes = tostring(table[0])
	for i, v in ipairs(table) do
		subtypes = subtypes.."|"..tostring(v)
	end
	return subtypes
end

function getItemsOnGround()
	local items = db:pobierzTabeleWynikow("SELECT * FROM `rp_items` WHERE `ownertype`=0 AND `ownerid`=0")
	return items
end

function spawnItemOnGround(itemUID)
	local itemInfo = getItemInfo(itemUID)
	if itemInfo.ownertype == 0 and itemInfo.ownerid == 0 then
		local itemObject = createObject(1589, itemInfo.posX, itemInfo.posY, itemInfo.posZ)
		setElementFrozen(itemObject, true)
		setElementData(itemObject, "item", true)
		setElementData(itemObject, "itemUID", itemInfo.UID)
	end
end

function spawnItemsOnGround()
	local items = getItemsOnGround()
	for i,v in ipairs(items) do
		spawnItemOnGround(v.UID)
	end
end
spawnItemsOnGround()