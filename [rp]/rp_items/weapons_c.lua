addEventHandler("onClientPlayerWeaponFire", root, function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
	if localPlayer == source then
		triggerServerEvent("EQOnWeaponFired", source, localPlayer)
	end
end)