local occupiedVehicle = nil

local screen = {}
screen.w, screen.h = guiGetScreenSize()

local speedFont = exports.rp_fonts:getFont("myriadproregular", 15, false)
local fuelFont = exports.rp_fonts:getFont("myriadproregular", 13, false)

function drawSpeedometer()
	if occupiedVehicle == nil then
	else
		dxDrawText(math.floor(getElementSpeed(occupiedVehicle)).. "kph", 0.9375 * screen.w, 0.888 * screen.h, 0.9375 * screen.w, 0.888 * screen.h, tocolor(255, 0, 0), 1, speedFont)
		local vInfo = getElementData(occupiedVehicle, "vehInfo")
		dxDrawText(math.floor(vInfo.fuel).. "l", 0.9375 * screen.w, 0.916 * screen.h, 0.9375 * screen.w, 0.916 * screen.h, tocolor(255, 0, 0), 1, fuelFont)
	end
end

addEventHandler("onClientVehicleEnter", root, function(thePlayer, seat)
	if thePlayer == localPlayer then
		occupiedVehicle = source
		addEventHandler("onClientRender", root, drawSpeedometer)
	end
end)

addEventHandler("onClientVehicleExit", root, function(thePlayer, seat)
	if thePlayer == localPlayer then
		removeEventHandler("onClientRender", root, drawSpeedometer)
		occupiedVehicle = nil
	end
end)

bindKey("k", "down", function()
	vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle then
		driver = getVehicleOccupant(vehicle, 0)
		if driver == localPlayer then
			triggerServerEvent("turnVehicleEngineByPlayer", root, localPlayer, vehicle)
		end
	end
end)

bindKey("l", "down", function()
	vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle then
		driver = getVehicleOccupant(vehicle, 0)
		if driver == localPlayer then
			triggerServerEvent("turnVehicleLightsByPlayer", root, localPlayer, vehicle)
		end
	end
end)

--przydatna funkcja
function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.8 * 100
		end
	else
		outputDebugString("Not an element. Can't get speed")
		return false
	end
end