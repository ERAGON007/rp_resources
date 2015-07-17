--[[
	Podtypy rozdzielone są poprzez znak "|"
	Przedmioty:
	Bronie: Typ 1, Podtyp: [1] typ broni, [2] naboje
	Amunicja: Typ 2, Podtyp: [1] typ broni, [2] naboje
	Kluczyki do auta: Typ 3, Podtyp: [1] uid auta
--]]
local font = exports.rp_fonts:getFont("myriadprocondensed", 12, false)
local circleFont = exports.rp_fonts:getFont("myriadprocondensed", 10, false)

local EQ = nil
local EQCount = 0

local EQActive = 0
local EQPage = 1
local usedItem = nil
local usedItemUID = nil

local lastEQUpdate = getTickCount()

local slot = 0

local scale = 1

local sWidth, sHeight = guiGetScreenSize()
local backgroundTexture = dxCreateTexture("img/eq_bg.png", "argb", true, "clamp")
--270 x 310

animation = {}
animation.time = 500
animation.state = nil
animation.startTick = nil

function drawEQ()
	tickCount = getTickCount()
	progress = (tickCount - animation.startTick) / animation.time
	if (tickCount - lastEQUpdate) > 500 then
		triggerServerEvent("updatePlayerItems", localPlayer)
		EQ = getElementData(localPlayer, "EQ")
		lastEQUpdate = tickCount
	end
	if animation.state == "start" then
		startX = sWidth
		startY = sHeight/2 - 155
		startZ = 0
		stopX = sWidth - 270
		stopY = sHeight/2 - 155
		stopZ = 0
		currentX, currentY, currentZ = interpolateBetween(startX, startY, startZ, stopX, stopY, stopZ, progress, "Linear")
		if progress >= 1 then
			currentX = sWidth - 270
			currentY = sHeight/2 - 155 
		end
	elseif animation.state == "hide" then
		startX = sWidth - 270
		startY = sHeight/2 - 155
		startZ = 0
		stopX = sWidth
		stopY = sHeight/2 - 155
		stopZ = 0
		currentX, currentY, currentZ = interpolateBetween(startX, startY, startZ, stopX, stopY, stopZ, progress, "Linear")
		if progress > 1 then
			removeEventHandler("onClientRender", root, drawEQ)
		end
	end
	dxDrawImage(currentX, currentY, 270, 310, backgroundTexture)
	if progress >= 1 and animation.state ~= "hide" then
	EQCount = 0
	slot = 0
	for i, v in pairs(EQ) do
		EQCount = EQCount + 1
		slot = slot + 1
		if slot > 8 then
			slot = 0
		end
		if i > 8 * EQPage or i <= (8 * EQPage) - 8 then
		else
			text = slot .. ". " .. v.name
			if slot == tonumber(usedItem) then
				usedItemUID = v.UID
				dxDrawText(text, sWidth - 270 + 50, (sHeight/2 - 155 + 60) + ((slot-1) * 22.5), sWidth - 270 + 50, (sHeight/2 - 155 + 60) + ((slot-1) * 22.5), tocolor(127, 127, 127), scale, font)
			elseif v.inUse == 1 then
				dxDrawText(text, sWidth - 270 + 50, (sHeight/2 - 155 + 60) + ((slot-1) * 22.5), sWidth - 270 + 50, (sHeight/2 - 155 + 60) + ((slot-1) * 22.5), tocolor(127, 127, 127), scale, font)
			else
				dxDrawText(text, sWidth - 270 + 50, (sHeight/2 - 155 + 60) + ((slot-1) * 22.5), sWidth - 270 + 50, (sHeight/2 - 155 + 60) + ((slot-1) * 22.5), tocolor(255, 255, 255), scale, font)
			end
		end
	end
	if usedItem then
		dxDrawImage(sWidth - 270 + 37.5, sHeight/2 + 155 - 12 - 14 - 22, 25, 25, "img/eq_circle.png")
		dxDrawText("1", sWidth - 270 + 50, sHeight/2 + 155 - 12 - 14 - 22 + 12.5, sWidth - 270 + 50, sHeight/2 + 155 - 12 - 14 - 22 + 12.5, tocolor(255, 255, 255), scale, circleFont, "center", "center")
		dxDrawText("Użyj", sWidth - 270 + 62.5 + 5, sHeight/2 + 155 - 12 - 14 - 22 + 11, sWidth - 270 + 62.5, sHeight/2 + 155 - 12 - 14 - 22 + 11, tocolor(255, 255, 255), scale, circleFont, "left", "center")
	
		dxDrawImage(sWidth - 270 + 107.5, sHeight/2 + 155 - 12 - 14 - 22, 25, 25, "img/eq_circle.png")
		dxDrawText("2", sWidth - 270 + 120, sHeight/2 + 155 - 12 - 14 - 22 + 12.5, sWidth - 270 + 120, sHeight/2 + 155 - 12 - 14 - 22 + 12.5, tocolor(255, 255, 255), scale, circleFont, "center", "center")
		dxDrawText("Odłóż", sWidth - 270 + 132.5 + 5, sHeight/2 + 155 - 12 - 14 - 22 + 11, sWidth - 270 + 132.5, sHeight/2 + 155 - 12 - 14 - 22 + 11, tocolor(255, 255, 255), scale, circleFont, "left", "center")
	
		dxDrawImage(sWidth - 270 + 187.5, sHeight/2 + 155 - 12 - 14 - 22, 25, 25, "img/eq_circle.png")
		dxDrawText("3", sWidth - 270 + 200, sHeight/2 + 155 - 12 - 14 - 22 + 12.5, sWidth - 270 + 200, sHeight/2 + 155 - 12 - 14 - 22 + 12.5, tocolor(255, 255, 255), scale, circleFont, "center", "center")
		dxDrawText("Powrót", sWidth - 270 + 212 + 5, sHeight/2 + 155 - 12 - 14 - 22 + 11, sWidth - 270 + 212, sHeight/2 + 155 - 12 - 14 - 22 + 11, tocolor(255, 255, 255), scale, circleFont, "left", "center")
	else
		dxDrawImage(sWidth - 270 + 37.5, sHeight/2 + 155 - 12 - 14 - 22, 25, 25, "img/eq_circle.png")
		dxDrawText("[", sWidth - 270 + 50, sHeight/2 + 155 - 12 - 14 - 22 + 11, sWidth - 270 + 50, sHeight/2 + 155 - 12 - 14 - 22 + 11, tocolor(255, 255, 255), scale, circleFont, "center", "center")
		dxDrawText("Wstecz", sWidth - 270 + 62.5 + 5, sHeight/2 + 155 - 12 - 14 - 22 + 11, sWidth - 270 + 62.5, sHeight/2 + 155 - 12 - 14 - 22 + 11, tocolor(255, 255, 255), scale, circleFont, "left", "center")
	
		dxDrawImage(sWidth - 270 + 127.5, sHeight/2 + 155 - 12 - 14 - 22, 25, 25, "img/eq_circle.png")
		dxDrawText("]", sWidth - 270 + 140, sHeight/2 + 155 - 12 - 14 - 22 + 11, sWidth - 270 + 140, sHeight/2 + 155 - 12 - 14 - 22 + 11, tocolor(255, 255, 255), scale, circleFont, "center", "center")
		dxDrawText("Dalej", sWidth - 270 + 152.5 + 5, sHeight/2 + 155 - 12 - 14 - 22 + 11, sWidth - 270 + 62.5, sHeight/2 + 155 - 12 - 14 - 22 + 11, tocolor(255, 255, 255), scale, circleFont, "left", "center")
	end
end
end

function useEQ()
	if EQActive == 0 then
		showEQ()
	else
		hideEQ()
	end
end
bindKey("p", "down", useEQ)

function showEQ()
	--bindujemy klawisze
	if isEventHandlerAdded("onClientRender", root, drawEQ) then
		return
	end
	triggerServerEvent("updatePlayerItems", localPlayer)
	EQ = getElementData(localPlayer, "EQ")
	if not EQ then -- nie ma ekwipunku, może jakaś wiadomość? :)
		return
	end
	bindKey("[", "down", previousPage)
	bindKey("]", "down", nextPage)

	bindKey("1", "down", selectItem, 1)
	bindKey("2", "down", selectItem, 2)
	bindKey("3", "down", selectItem, 3)
	bindKey("4", "down", selectItem, 4)
	bindKey("5", "down", selectItem, 5)
	bindKey("6", "down", selectItem, 6)
	bindKey("7", "down", selectItem, 7)
	bindKey("8", "down", selectItem, 8)

	--
	animation.startTick = getTickCount()
	animation.state = "start"
	EQActive = 1
	addEventHandler("onClientRender", root, drawEQ)
end

function hideEQ()
	EQActive = 0
	EQPage = 1
	usedItem = nil
	usedItemDetails = nil
	--removeEventHandler("onClientRender", root, drawEQ)
	unbindKeys()
	animation.startTick = getTickCount()
	animation.state = "hide"
end

function selectItem(key, keyState, slot)
	if EQActive == 0 then
		return
	end
	unbindKey("1", "down", selectItem)
	unbindKey("2", "down", selectItem)
	unbindKey("3", "down", selectItem)
	unbindKey("4", "down", selectItem)
	unbindKey("5", "down", selectItem)
	unbindKey("6", "down", selectItem)
	unbindKey("7", "down", selectItem)
	unbindKey("8", "down", selectItem)
	bindKey("1", "down", useSelectedItem)
	bindKey("2", "down", dropSelectedItem)
	bindKey("3", "down", unselectItem)
	usedItem = slot
end

function unselectItem()
	usedItem = nil
	usedItemUID = nil
	unbindKey("1", "down", useSelectedItem)
	unbindKey("2", "down", dropSelectedItem)
	unbindKey("3", "down", unselectItem)
	bindKey("[", "down", previousPage)
	bindKey("]", "down", nextPage)

	bindKey("1", "down", selectItem, 1)
	bindKey("2", "down", selectItem, 2)
	bindKey("3", "down", selectItem, 3)
	bindKey("4", "down", selectItem, 4)
	bindKey("5", "down", selectItem, 5)
	bindKey("6", "down", selectItem, 6)
	bindKey("7", "down", selectItem, 7)
	bindKey("8", "down", selectItem, 8)
end

function nextPage()
	if (EQPage * 10) > EQCount then
		return
	end
	usedItem = nil
	EQPage = EQPage + 1
end

function previousPage()
	if EQPage == 1 then
		return
	end
	usedItem = nil
	EQPage = EQPage - 1
end

function useSelectedItem()
	if not usedItem or not usedItemUID then
	else
		useItem(usedItemUID)
		hideEQ()
	end
end

function useItem(itemUID)
	if not itemUID then
		return false
	end
	triggerServerEvent("EQUseItemCheck", root, localPlayer, itemUID)
end

function dropSelectedItem()
	if not usedItem or not usedItemUID then
	else
		dropItem(usedItemUID)
		hideEQ()
	end
end

function dropItem(itemUID)
	if not itemUID then
		return false
	end
	triggerServerEvent("dropItem", root, localPlayer, itemUID)
end

function unbindKeys()
	unbindKey("[", "down", previousPage)
	unbindKey("]", "down", nextPage)
	unbindKey("1", "down", useSelectedItem)
	unbindKey("2", "down", dropSelectedItem)
	unbindKey("3", "down", selectItem)

	unbindKey("1", "down", selectItem)
	unbindKey("2", "down", selectItem)
	unbindKey("3", "down", selectItem)
	unbindKey("4", "down", selectItem)
	unbindKey("5", "down", selectItem)
	unbindKey("6", "down", selectItem)
	unbindKey("7", "down", selectItem)
	unbindKey("8", "down", selectItem)
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