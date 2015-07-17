addEventHandler("EQUseItem", root, function(player, itemInfo)
	if not player or not itemInfo then return false end
	if itemInfo.type == 1 then
		triggerEvent("EQGiveWeapon", root, player, itemInfo.subtype)
	end
end)

weaponName =
{
	[22] = "Glock",
	[23] = "Pistolet z tłumikiem",
	[24] = "Desert Eagle",
	[25] = "Shotgun",
	[26] = "Sawn-Off Shotgun",
	[27] = "SPAZ-12 Combat Shotgun",
	[28] = "Uzi",
	[29] = "MP5",
	[32] = "TEC-9",
	[30] = "AK-47",
	[31] = "M4",
	[34] = "Karabin Snajperski"
}

addEvent("EQGiveWeapon", true)
addEventHandler("EQGiveWeapon", root, function(player, weaponID)
	if getPedWeapon(player) ~= 0 then
		local usedWeapon = getPedWeapon(player)
		triggerEvent("meAction", root, player, "chowa ".. weaponName[usedWeapon].. ".")
		takeAllWeapons(player)
	else
		local ammo = hasPlayerItem(player, 2, weaponID)
		if ammo == false then
			return
		end
		local usedWeapon = weaponID
		triggerEvent("meAction", root, player, "wyciąga ".. weaponName[usedWeapon]..  ".")
		giveWeapon(player, weaponID, ammo, true)
	end
end)