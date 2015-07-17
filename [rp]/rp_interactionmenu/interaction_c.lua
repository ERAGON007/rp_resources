interaction = {}
interaction.key = "z"
interaction.active = false

screen = {}
screen.w, screen.h = guiGetScreenSize()

function interactionStart()
	interaction.active = true
	addEventHandler("onClientRender", root, drawCircle)
end

function interactionEnd()
	if not interaction.active then
		return
	end
	interaction.active = false
	removeEventHandler("onClientRender", root, drawCircle)

	x, y, z = getCameraMatrix()
	x2, y2, z2 = getWorldFromScreenPosition(screen.w/2, screen.h/2 - 50, 10)
	hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material, lighting, piece = processLineOfSight(x, y, z, x2, y2, z2, true, true, true, true, true, true, false, true, localPlayer, false, true)
	if hit then
		if isElement(hitElement) then
			if getElementType(hitElement) == "vehicle" then
				if isVehicleLocked(hitElement) then
				else
					if piece == 4 then -- bagażnik
						triggerServerEvent("toggleVehicleTrunkByPlayer", root, localPlayer, hitElement)
					elseif piece == 3 then -- maska
						triggerServerEvent("toggleVehicleHoodByPlayer", root, localPlayer, hitElement)
					end
				end 
			elseif getElementType(hitElement) == "player" then -- inny gracz
				if piece == 9 then -- głowa, całowanie? ;)
				elseif piece == 6 then -- prawa ręka, powitanie?
				elseif piece == 5 then -- lewa ręka, powitanie?
				end
			elseif getElementType(hitElement) == "object" then -- interakcja z obiektem
				if getElementData(hitElement, "item") == true then -- przedmiot, podnosimy. ;)
					triggerServerEvent("pickItem", root, localPlayer, getElementData(hitElement, "itemUID"))
				end
				if getElementModel(hitElement) == 2942 then -- bankomat
				end
			end
		end
	end
end

function drawCircle()
	dxDrawCircle(screen.w/2, screen.h/2 - 50, 1, 3, 1, 0, 360, tocolor(255, 0, 0))
end

bindKey(interaction.key, "down", interactionStart)
bindKey(interaction.key, "up", interactionEnd)

--funkcja do rysowania "kółek"

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