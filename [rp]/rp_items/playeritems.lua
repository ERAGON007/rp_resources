db = exports.rp_db

addEvent("EQUseItemCheck", true)
addEvent("EQUseItem", true)
addEventHandler("EQUseItemCheck", root, function(player, itemUID)
	local charInfo = getElementData(player, "charInfo")
	local itemInfo = getItemInfo(itemUID)
	if itemInfo.ownertype ~= 1 or itemInfo.ownerid ~= charInfo.UID then
		return false
	end
	triggerEvent("EQUseItem", root, player, itemUID)
end)

function getPlayerItems(playeruid)
	local items = db:pobierzTabeleWynikow("SELECT * FROM `rp_items` WHERE `ownertype`=1 AND `ownerid`=?", playeruid)
	return items
end

function updatePlayerItems(player)
	local charInfo = getElementData(player, "charInfo")
	local items = getPlayerItems(charInfo.UID)
	setElementData(player, "EQ", items)
end

function getPlayerItemsInUse(playeruid)
	local itemsInUse = db:pobierzTabeleWynikow("SELECT * FROM `rp_items` WHERE `ownertype`=1 AND `ownerid`=? AND `inUse`=1", playeruid)
	return itemsInUse
end

function dropItem(player, itemUID)
	local x, y, z = getElementPosition(player)
	local charInfo = getElementData(player, "charInfo")
	local itemInfo = getItemInfo(itemUID)
	if itemInfo.inUse == 1 or itemInfo.ownertype ~= 1 or itemInfo.ownerid ~= charInfo.UID then
		return
	end
	itemInfo.ownertype = 0
	itemInfo.ownerid = 0
	itemInfo.posX = x
	itemInfo.posY = y
	itemInfo.posZ = z
	setItemInfo(itemUID, itemInfo)
	spawnItemOnGround(itemUID)
	triggerEvent("meAction", root, player, "odkłada ".. itemInfo.name.. " na ziemię.")
end
addEvent("dropItem", true)
addEventHandler("dropItem", root, function(player, itemUID)
	dropItem(player, itemUID)
end)

function pickItem(player, itemUID)
	local x, y, z = getElementPosition(player)
	local charInfo = getElementData(player, "charInfo")
	local itemInfo = getItemInfo(itemUID)
	if itemInfo.ownertype == 0 and itemInfo.ownerid == 0 then
		if getDistanceBetweenPoints3D(x, y, z, itemInfo.posX, itemInfo.posY, itemInfo.posZ) then
			itemInfo.ownertype = 1
			itemInfo.ownerid = charInfo.UID
			setItemInfo(itemUID, itemInfo)
			triggerEvent("meAction", root, player, "podnosi ".. itemInfo.name.. " z ziemi.")
			local objects = getElementsByType("object")
			for i,v in ipairs(objects) do
				if getElementData(v, "item") == true then
					if getElementData(v, "itemUID") == itemUID then
						destroyElement(v)
						break
					end
				end
			end
		end
	end
end
addEvent("pickItem", true)
addEventHandler("pickItem", root, pickItem)

addEvent("updatePlayerItems", true)
addEventHandler("updatePlayerItems", root, function()
	updatePlayerItems(client)
end)