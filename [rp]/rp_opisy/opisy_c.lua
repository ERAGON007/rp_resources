local font = exports.rp_fonts:getFont("myriadproregular", 12)

addEventHandler("onClientRender", root, function()
	local players = getElementsByType("player")
	local px, py, pz, tx, ty, tz
	px, py, pz = getCameraMatrix()
	for i, v in ipairs(players) do
		tx, ty, tz = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz)
		if dist < 30 then
			if isLineOfSightClear(px, py, pz, tx, ty, tz, true, false, false, true, false, false, false) then
				local bx, by, bz = getPedBonePosition(v, 8)
				local x, y = getScreenFromWorldPosition(bx, by, bz - 0.35)
				if x and y then
					if localPlayer == v then
					else
						charInfo = getElementData(v, "charInfo")
						if not charInfo.opis or charInfo.opis == nil then
						else
							local text = charInfo.opis
							dxDrawText(text, x, y, x, y, tocolor(186, 117, 255), 1, font, "center", "center")
						end
					end
				end
			end
		end
	end
end)