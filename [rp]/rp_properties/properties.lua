--VW budynku: UID+10000

local playerHittedMarker = {}

function createMarkersForPlayer(thePlayer)
	if not thePlayer then return false end
	local markers = exports.rp_db:pobierzTabeleWynikow("SELECT * FROM `rp_properties` WHERE `enterInterior`=?", getElementInterior(thePlayer))
	for i,v in ipairs(markers) do
		local marker = createMarker(v.enterX, v.enterY, v.enterZ, "arrow", 1.0, 0, 0, 255, 0, thePlayer)
		setElementData(marker, "property", 1)
		setElementData(marker, "propInfo", v)
		setElementDimension(marker, getElementDimension(thePlayer))
	end
	local inProperty = getElementData(thePlayer, "inProperty")
	if inProperty == 0 then
	else
		local markers = exports.rp_db:pobierzTabeleWynikow("SELECT * FROM `rp_properties` WHERE `UID` = ?", inProperty)
		for i,v in ipairs(markers) do
			local marker = createMarker(v.exitX, v.exitY, v.exitZ, "arrow", 1.0, 0, 0, 255, 0, thePlayer)
			setElementData(marker, "property", 1)
			setElementData(marker, "propInfo", v)
			setElementDimension(marker, getElementDimension(thePlayer))
		end
	end
end

function getPropertyInfo(UID)
	local propInfo = exports.rp_db:pobierzWyniki("SELECT * FROM `rp_properties` WHERE `UID`=?", UID)
	return propInfo
end


addEventHandler("onResourceStart", resourceRoot, function()
	local players = getElementsByType("player")
	for i,v in ipairs(players) do
		createMarkersForPlayer(v)
		setElementData(v, "inProperty", 0) -- kod tymczasowy
		bindKey(v, "e", "up", useDoors)
	end
end)

addEventHandler("onMarkerHit", root, function(hitElement, matchingDimension)
	if getElementType(hitElement) ~= "player" then return end
	if getElementData(source, "property") == 1 then
		playerHittedMarker[hitElement] = source
		--[[local propInfo = getElementData(source, "propInfo")
		local inProperty = getElementData(hitElement, "inProperty")
		if inProperty ~= propInfo.UID then -- nie w tym budynku
			setElementDimension(hitElement, propInfo.UID+10000)
			setElementPosition(hitElement, Vector3(propInfo.exitX, propInfo.exitY, propInfo.exitZ))
			setElementData(hitElement, "inProperty", propInfo.UID)
			setTimer(createMarkersForPlayer, 1000 * 4, 1, hitElement)
			--createMarkersForPlayer(hitElement)
		else -- w tym budynku
			setElementDimension(hitElement, propInfo.enterInterior)
			setElementPosition(hitElement, Vector3(propInfo.enterX, propInfo.enterY, propInfo.enterZ))
			setElementData(hitElement, "inProperty", 0)
			setTimer(createMarkersForPlayer, 1000 * 4, 1, hitElement)
			--createMarkersForPlayer(hitElement)
		end--]]
	end
end)

addEventHandler("onMarkerLeave", root, function(leaveElement, matchingDimension)
	if getElementType(leaveElement) ~= "player" then return end
	if getElementData(source, "property") == 1 then
		playerHittedMarker[leaveElement] = nil
	end
end)

function useDoors(player, key, keyState)
	if not playerHittedMarker[player] then return end
	local propInfo = getElementData(playerHittedMarker[player], "propInfo")
	local inProperty = getElementData(player, "inProperty")
	if inProperty ~= propInfo.UID then -- nie w tym budynku
		setElementDimension(player, propInfo.UID+10000)
		setElementPosition(player, Vector3(propInfo.exitX, propInfo.exitY, propInfo.exitZ))
		setElementData(player, "inProperty", propInfo.UID)
		createMarkersForPlayer(player)
	else -- w tym budynku
		setElementDimension(player, propInfo.enterInterior)
		setElementPosition(player, Vector3(propInfo.enterX, propInfo.enterY, propInfo.enterZ))
		setElementData(player, "inProperty", 0)
		createMarkersForPlayer(player)
	end
	triggerClientEvent(player, "reloadPlayerObjects", player)
end

addEventHandler("onPlayerSpawn", root, function()
	createMarkersForPlayer(source)
	bindKey(source, "e", "up", useDoors)
end)

addCommandHandler("drzwi", function(thePlayer, commandName, arg)
	if not arg then
		return
	end
	local selectedProperty = playerHittedMarker[thePlayer]
	if not selectedProperty then return end
end)

function hasPlayerPermissionForDoors(thePlayer, uid)
	if not thePlayer or not uid then return false end
	local result = exports.rp_db:pobierzWyniki("SELECT * FROM `rp_properties` WHERE `UID`=?", tonumber(uid))
	local charInfo = getElementData(thePlayer, "charInfo")
	if result.ownertype == 1 and result.ownerid == charInfo.UID then return true end

	return false
end