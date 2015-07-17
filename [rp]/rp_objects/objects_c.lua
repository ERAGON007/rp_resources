function reloadObjects()
	if not getElementData(localPlayer, "charInfo") then return end
	triggerServerEvent("recachePlayerObjects", localPlayer)
	local objects = getElementData(localPlayer, "objects:table")
	if objects == false then return end
	for i,v in ipairs(getElementsByType("object")) do
		destroyElement(v)
	end
	for i,v in ipairs(objects) do
		--local object = createObject(v.modelid, v.x, v.y, v.z, v.rx, v.ry, v.rz)
		if getElementData(localPlayer, "inProperty") > 0 then -- w budynku
			local object = createObject(v.modelid, v.x, v.y, v.z, v.rx, v.ry, v.rz)
			setElementDimension(object, getElementData(localPlayer, "inProperty") + 10000)
		end
	end
end
addEvent("reloadPlayerObjects", true)
addEventHandler("reloadPlayerObjects", root, reloadObjects)
addEventHandler("onClientResourceStart", resourceRoot, reloadObjects)