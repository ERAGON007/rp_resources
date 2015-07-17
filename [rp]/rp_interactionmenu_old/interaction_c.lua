local font = exports.rp_fonts:getFont("myriadproregular", 12)
local usedFont = exports.rp_fonts:getFont("myriadproregular", 14)

local interaction = {}
interaction.key = "1"
interaction.active = false

local screen = {}
screen.w, screen.h = guiGetScreenSize()

local selectedElement = {}

local showOptions = {}
local selectedOption = {}

local maxOptions = 0

function showInteractionMenu()
	local i = 1
	if selectedElement.type == "vehicle" then
		if showOptions.unlockVehicle == true then
			if i == selectedOption.number then
				selectedOption.info = "unlockVehicle"
				dxDrawText("Otwórz pojazd", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, usedFont, "center", "center")
			else
				dxDrawText("Otwórz pojazd", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, font, "center", "center")
			end
			i = i + 1
		end
		if showOptions.lockVehicle == true then
			if i == selectedOption.number then
				selectedOption.info = "lockVehicle"
				dxDrawText("Zamknij pojazd", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, usedFont, "center", "center")
			else
				dxDrawText("Zamknij pojazd", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, font, "center", "center")
			end
			i = i + 1
		end
		if showOptions.enableEngine == true then
			if i == selectedOption.number then
				selectedOption.info = "enableEngine"
				dxDrawText("Uruchom silnik", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, usedFont, "center", "center")
			else
				dxDrawText("Uruchom silnik", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, font, "center", "center")
			end
			i = i + 1
		end
		if showOptions.disableEngine == true then
			if i == selectedOption.number then
				selectedOption.info = "disableEngine"
				dxDrawText("Zgaś silnik", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, usedFont, "center", "center")
			else
				dxDrawText("Zgaś silnik", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, font, "center", "center")
			end
			i = i + 1
		end
		if showOptions.disableLights == true then
			if i == selectedOption.number then
				selectedOption.info = "disableLights"
				dxDrawText("Wyłącz światła", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, usedFont, "center", "center")
			else
				dxDrawText("Wyłącz światła", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, font, "center", "center")
			end
			i = i + 1
		end
		if showOptions.enableLights == true then
			if i == selectedOption.number then
				selectedOption.info = "enableLights"
				dxDrawText("Włącz światła", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, usedFont, "center", "center")
			else
				dxDrawText("Włącz światła", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, font, "center", "center")
			end
			i = i + 1
		end
		if showOptions.closeHood == true then -- zamykamy maskę
			if i == selectedOption.number then
				selectedOption.info = "closeHood"
				dxDrawText("Zamknij maskę", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, usedFont, "center", "center")
			else
				dxDrawText("Zamknij maskę", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, font, "center", "center")
			end
			i = i + 1
		end
		if showOptions.openHood == true then -- otwieramy maskę
			if i == selectedOption.number then
				selectedOption.info = "openHood"
				dxDrawText("Otwórz maskę", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, usedFont, "center", "center")
			else
				dxDrawText("Otwórz maskę", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, font, "center", "center")
			end
			i = i + 1
		end
		if showOptions.openTrunk == true then -- otwieramy bagażnik
			if i == selectedOption.number then
				selectedOption.info = "openTrunk"
				dxDrawText("Otwórz bagażnik", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, usedFont, "center", "center")
			else
				dxDrawText("Otwórz bagażnik", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, font, "center", "center")
			end
			i = i + 1
		end
		if showOptions.closeTrunk == true then -- zamykamy bagażnik
			if i == selectedOption.number then
				selectedOption.info = "closeTrunk"
				dxDrawText("Zamknij bagażnik", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, usedFont, "center", "center")
			else
				dxDrawText("Zamknij bagażnik", 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, 0.5 * screen.w, (0.5 + (0.0333 * (i-1))) * screen.h, tocolor(255, 255, 255), 1, font, "center", "center")
			end
			i = i + 1
		end
	end
end

function interactionGetElement()
	if interaction.active then
		interaction.active = false
		unbindKey("mouse_wheel_up", "down", scrollOption)
		unbindKey("mouse_wheel_down", "down", scrollOption)
		unbindKey("mouse1", "down", useSelectedOption)
		unbindKey(interaction.key, "up", interactionEndGetElement)
		removeEventHandler("onClientRender", root, showInteractionMenu)
		toggleControl("fire", true)
		return
	end
	if exports.rp_playeritems:isActive() or isChatBoxInputActive() or isConsoleActive() then
		return
	else
		selectedElement = {}
		showOptions = {}
		selectedOption = {}
		maxOptions = 0
		interaction.active = false
		removeEventHandler("onClientRender", root, showInteractionMenu)
		addEventHandler("onClientRender", root, drawElementCircle)
		bindKey(interaction.key, "up", interactionEndGetElement)
	end
end

function interactionEndGetElement()
	if isEventHandlerAdded("onClientRender", root, showInteractionMenu) then
		return
	end
	if exports.rp_playeritems:isActive() or isChatBoxInputActive() or isConsoleActive() then
		return
	end
	getNearbyElementForInteraction()
	removeEventHandler("onClientRender", root, drawElementCircle)
	if isElement(selectedElement.element) then
		processInteraction()
		selectedOption.number = 1
		if maxOptions == 0 then
		else
			interaction.active = true
			bindKey("mouse_wheel_up", "down", scrollOption)
			bindKey("mouse_wheel_down", "down", scrollOption)
			bindKey("mouse1", "down", useSelectedOption)
			selectedOption.number = 1
			toggleControl("fire", false)
			addEventHandler("onClientRender", root, showInteractionMenu)
		end
	end
end

function useSelectedOption()
	interaction.active = false

	unbindKey("mouse_wheel_up", "down", scrollOption)
	unbindKey("mouse_wheel_down", "down", scrollOption)
	unbindKey("mouse1", "down", useSelectedOption)
	
	setTimer(function()
		toggleControl("fire", true)
	end, 1000, 1)
	
	selectedElement.x, selectedElement.y, selectedElement.z = getElementPosition(selectedElement.element)
	local x, y, z = getElementPosition(localPlayer)
	if getDistanceBetweenPoints3D(x, y, z, selectedElement.x, selectedElement.y, selectedElement.z) >= 10 then
		removeEventHandler("onClientRender", root, showInteractionMenu)
		return
	end

	if getElementDimension(localPlayer) ~= getElementDimension(selectedElement.element) then
		removeEventHandler("onClientRender", root, showInteractionMenu)
		return
	end
	
	removeEventHandler("onClientRender", root, showInteractionMenu)
	if selectedOption.info == "lockVehicle" or selectedOption.info == "unlockVehicle" then
		triggerServerEvent("openVehicleByPlayer", root, localPlayer, selectedElement.element)
	end
	if selectedOption.info == "enableEngine" or selectedOption.info == "disableEngine" then
		triggerServerEvent("turnVehicleEngineByPlayer", root, localPlayer, selectedElement.element)
	end
	if selectedOption.info == "enableLights" or selectedOption.info == "disableLights" then
		triggerServerEvent("turnVehicleLightsByPlayer", root, localPlayer, selectedElement.element)
	end
	if selectedOption.info == "openHood" or selectedOption.info == "closeHood" then
		triggerServerEvent("toggleVehicleHoodByPlayer", root, localPlayer, selectedElement.element)
	end
	if selectedOption.info == "openTrunk" or selectedOption.info == "closeTrunk" then
		triggerServerEvent("toggleVehicleTrunkByPlayer", root, localPlayer, selectedElement.element)
	end
end

function drawElementCircle()
	dxDrawCircle(screen.w/2, screen.h/2, 1, 3, 1, 0, 360, tocolor(255, 0, 0))
end

bindKey(interaction.key, "down", interactionGetElement)

function processInteraction()
	if not selectedElement.element then return end
	selectedElement.type = getElementType(selectedElement.element)
	local i = 0
	if selectedElement.type == "vehicle" then
		local vehicle = selectedElement.element
		if isVehicleLocked(vehicle) then
			showOptions.unlockVehicle = true
			i = i + 1
		else
			showOptions.lockVehicle = true
			i = i + 1
		end
		if isPedInVehicle(localPlayer) then
			if getVehicleOccupant(vehicle, 0) == localPlayer then
				if getVehicleEngineState(vehicle) == true then
					showOptions.disableEngine = true
					i = i + 1
				else
					showOptions.enableEngine = true
					i = i + 1
				end
				if getVehicleOverrideLights(vehicle) == 1 then
					showOptions.enableLights = true
					i = i + 1
				elseif getVehicleOverrideLights(vehicle) == 2 then
					showOptions.disableLights = true
					i = i + 1
				end
			end
		else
			if isVehicleLocked(vehicle) then
			else
				if getVehicleDoorOpenRatio(vehicle, 0) > 0 then
					showOptions.closeHood = true
					i = i + 1
				else
					showOptions.openHood = true
					i = i + 1
				end
				if getVehicleDoorOpenRatio(vehicle, 1) > 0 then
					showOptions.closeTrunk = true
					i = i + 1
				else
					showOptions.openTrunk = true
					i = i + 1
				end
			end
		end
	end
	maxOptions = i
end

function scrollOption(wheel)
	if wheel == false then -- do góry
		selectedOption.number = selectedOption.number - 1
		if selectedOption.number < 1 then
			selectedOption.number = maxOptions
		end
	else -- w dół
		selectedOption.number = selectedOption.number + 1
		if selectedOption.number > maxOptions then
			selectedOption.number = 1
		end
	end
end

--pobieramy najbliższy element do interakcji - gracza, pojazd, itd

function getNearbyElementForInteraction()
	local px, py, pz = getCameraMatrix()
	local tx, ty, tz = getWorldFromScreenPosition(screen.w/2, screen.h/2, 10)
	hit, x, y, z, elementHit = processLineOfSight(px, py, pz, tx, ty, tz, true, true, true, true, true, false, false, false, localPlayer)
	if hit then
		if elementHit then
			selectedElement.element = elementHit
		else
			return false
		end
	else
		return false
	end
end

--dodatkowa funkcja do rysowania "kółka"

function dxDrawCircle( posX, posY, radius, width, angleAmount, startAngle, stopAngle, color, postGUI )
	if ( type( posX ) ~= "number" ) or ( type( posY ) ~= "number" ) then
		return false
	end
 
	local function clamp( val, lower, upper )
		if ( lower > upper ) then lower, upper = upper, lower end
		return math.max( lower, math.min( upper, val ) )
	end
 
	radius = type( radius ) == "number" and radius or 50
	width = type( width ) == "number" and width or 5
	angleAmount = type( angleAmount ) == "number" and angleAmount or 1
	startAngle = clamp( type( startAngle ) == "number" and startAngle or 0, 0, 360 )
	stopAngle = clamp( type( stopAngle ) == "number" and stopAngle or 360, 0, 360 )
	color = color or tocolor( 255, 255, 255, 200 )
	postGUI = type( postGUI ) == "boolean" and postGUI or false
 
	if ( stopAngle < startAngle ) then
		local tempAngle = stopAngle
		stopAngle = startAngle
		startAngle = tempAngle
	end
 
	for i = startAngle, stopAngle, angleAmount do
		local startX = math.cos( math.rad( i ) ) * ( radius - width )
		local startY = math.sin( math.rad( i ) ) * ( radius - width )
		local endX = math.cos( math.rad( i ) ) * ( radius + width )
		local endY = math.sin( math.rad( i ) ) * ( radius + width )
 
		dxDrawLine( startX + posX, startY + posY, endX + posX, endY + posY, color, width, postGUI )
	end
 
	return true
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if 
		type( sEventName ) == 'string' and 
		isElement( pElementAttachedTo ) and 
		type( func ) == 'function' 
	then
		local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
		if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
			for i, v in ipairs( aAttachedFunctions ) do
				if v == func then
					return true
				end
			end
		end
	end
 
	return false
end

--wyłączamy stacje radiowe, bo psujo
setRadioChannel(0)
addEventHandler("onClientPlayerRadioSwitch", root, function(stationID)
	if stationID ~= 0 then
		cancelEvent()
	end
end)
