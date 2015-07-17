addEventHandler("EQUseItem", root, function(player, itemInfo)
	if not player or not itemInfo then return false end
	if itemInfo.type == 3 then
		vehicles = getElementsByType("vehicle")
		for i,v in ipairs(vehicles) do
			vehInfo = getElementData(v, "vehInfo")
			if vehInfo.UID == itemInfo.subtype then
				x, y, z = getElementPosition(player)
				x2, y2, z2 = getElementPosition(v)
				if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 4 then
					triggerEvent("openVehicleByPlayer", root, player, v)
				end
			end
		end
	end
end)