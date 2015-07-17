addEventHandler("EQUseItem", root, function(player, itemUID)
	local itemInfo = getItemInfo(itemUID)
	if itemInfo.type == 3 then
		local vehicles = getElementsByType("vehicle")
		for i,v in ipairs(vehicles) do
			local vehInfo = getElementData(v, "vehInfo")
			local subtypes = subtypesToTable(itemInfo.subtypes)
			if vehInfo.UID == subtypes[0] then
				local x, y, z = getElementPosition(player)
				local x2, y2, z2 = getElementPosition(v)
				if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 4 then
					triggerEvent("openVehicleByPlayer", root, player, v)
				end
			end
		end
	end
end)