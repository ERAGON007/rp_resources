--[[local selectedObject = nil

addCommandHandler("mc", function(commandName, arg1)
	if checkPlayerPermissionsToBuilding() == true then
		if not arg1 then
			return outputChatBox("Użyj: /mc [id obiektu]")
		end
		local objectid = tonumber(arg1)
		local x, y, z = getElementPosition(localPlayer)
		x = x + 5
		y = y + 5
		rx, ry, rz = getElementRotation(localPlayer)
		if getElementData(localPlayer, "inProperty") > 0 then
			zonetype = 1
			zoneid = getElementData(localPlayer, "inProperty")
		end
		triggerServerEvent("createObject", localPlayer, objectid, x, y, z, rx, ry, rz, zonetype, zoneid)
	end
end)

addCommandHandler("msel", function(commandName)
	if checkPlayerPermissionsToBuilding() == true then
		outputChatBox("Kliknij na obiekt, by go wybrać(jeżeli masz już wybrany obiekt, zostanie on odznaczony!).")
		selectedObject = nil
		showCursor(true)
		triggerServerEvent("startSelectingObject", localPlayer)
		addEventHandler("onObjectSelected", localPlayer, selectObject)
	end
end)

addEvent("onObjectSelected", true)
function selectObject(object)
	selectedObject = object
	removeEventHandler("onObjectSelected", localPlayer, selectObject)
	showCursor(false)
	outputChatBox(getElementModel(object))
end

function checkPlayerPermissionsToBuilding()
	return true
end--]]