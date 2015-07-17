local font = exports.rp_fonts:getFont("myriadproregular", 15)

addEventHandler("onClientRender", root, function()
	local players = getElementsByType("player")
	local px, py, pz, tx, ty, tz, pDimension, tDimension
	px, py, pz = getCameraMatrix()
	pDimension = getElementDimension(localPlayer)
	for i, v in ipairs(players) do
		tx, ty, tz = getElementPosition(v)
		tDimension = getElementDimension(v)
		if pDimension == tDimension then
			local dist = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz)
			if dist < 15 then
				--if isLineOfSightClear(px, py, pz, tx, ty, tz, true, false, false, true, false, false, false) then
					local bx, by, bz = getPedBonePosition(v, 8)
					local x, y = getScreenFromWorldPosition(bx, by, bz + 0.25)
					if x and y then
						if localPlayer == v then
						else
							local text = getPlayerName(v)
							text = string.gsub(text, "_", " ")
							text = text .. " (" .. getElementData(v, "id") .. ")"
							--dxDrawText(text, x, y, x, y, tocolor(186, 117, 255), 0.85 + (15 - dist) * 0.08, font, "center", "center")
							dxDrawText(text, x, y, x, y, tocolor(186, 117, 255), 1, font, "center", "center")
						end
					end
				--end
			end
		end
	end
end)