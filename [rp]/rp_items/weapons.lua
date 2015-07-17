addEventHandler("EQUseItem", root, function(player, itemUID)
	local itemInfo = getItemInfo(itemUID)
	if itemInfo.type == 1 then
		if getPedWeapon(player) ~= 0 then
			triggerEvent("meAction", root, player, "chowa ".. itemInfo.name.. ".")
			takeAllWeapons(player)
			setItemIsInUse(itemUID, false)
		else
			local subtypes = subtypesToTable(itemInfo.subtypes)
			local ammo = subtypes[1]
			if ammo < 1 then
				return
			end
			triggerEvent("meAction", root, player, "wyciąga ".. itemInfo.name ..  ".")
			giveWeapon(player, subtypes[0], ammo, true)
			setItemIsInUse(itemUID, true)
		end
	end
end)

addEvent("EQOnWeaponFired", true)
addEventHandler("EQOnWeaponFired", root, function(player)
	local charInfo = getElementData(player, "charInfo")
	local itemsInUse = getPlayerItemsInUse(charInfo.UID)
	local weaponInfo = nil
	for i,v in ipairs(itemsInUse) do
		if v.type == 1 then
			weaponInfo = v
		end
	end
	weaponInfo.subtypes = subtypesToTable(weaponInfo.subtypes)
	weaponInfo.subtypes[1] = weaponInfo.subtypes[1] - 1
	weaponInfo.subtypes = tableToSubtypes(weaponInfo.subtypes)
	setItemInfo(weaponInfo.UID, weaponInfo)
end)