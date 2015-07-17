addEvent("createObject", true)
addEventHandler("createObject", root, function(modelid, x, y, z, rx, ry, rz, zonetype, zoneid)
	if not rx then rx = 0 end
	if not ry then ry = 0 end
	if not rz then rz = 0 end
	if not zonetype then return end
	if not zoneid then return end
	exports.rp_db:zapytanie("INSERT INTO `rp_objects` SET `modelid` = ?, `x` = ?, `y` = ?, `z` = ?, `rx` = ?, `ry` = ?, `rz` = ?, `zonetype` = ?, `zoneid` = ?", modelid, x, y, z, rx, ry, rz, zonetype, zoneid)
end)

addEvent("startSelectingObject", true)
addEventHandler("startSelectingObject", root, function()
	addEventHandler("onPlayerClick", source, selectObject)
end)

function selectObject(mouseButton, buttonState, clickedElement)
	--if getElementType(clickedElement) ~= "object" then return end
	if not isElement(clickedElement) or getElementType(clickedElement) ~= "object" then object = nil else object = clickedElement end
	triggerClientEvent(source, "onObjectSelected", source, object)
end