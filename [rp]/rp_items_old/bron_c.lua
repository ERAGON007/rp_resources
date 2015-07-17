addEventHandler("onClientPlayerWeaponFire", root, function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
	if localPlayer == source then
		triggerServerEvent("minusPlayerItemByType", resourceRoot, localPlayer, 2, weapon, 1)
	end
end)