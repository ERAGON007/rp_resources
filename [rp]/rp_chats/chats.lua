local emoticons = {
	[1] = {emoticon=":)", text="uśmiecha się"},
	[2] = {emoticon=";)", text="puszcza oczko"}
}

addEventHandler("onPlayerChat", root, function(message, messageType)
	cancelEvent()
	if not message then
		return
	end
	if messageType == 0 then
		message = string.gsub(message, "^%l", string.upper)
		players = getElementsByType("player")
		x, y, z = getElementPosition(source)
		dimension = getElementDimension(source)
		local name = getPlayerName(source)
		name = string.gsub(name, "_", " ")
		local text = name .. " mówi: "..message
		for i, v in pairs(players) do
			local sended = 0
			x2, y2, z2 = getElementPosition(v)
			dimension2 = getElementDimension(v)
			if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 1 and dimension == dimension2 then
				if sended == 1 then
				else
					outputChatBox("#FFFFFF"..text, v, 255, 0, 0, true)
					sended = 1
				end
			end
			
			if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 1 and getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) >= 2 and dimension == dimension2 then
				if sended == 1 then
				else
					outputChatBox("#DEDEDE"..text, v, 255, 0, 0, true)
					sended = 1
				end
			end
			
			if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 4 and getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) >= 6 and dimension == dimension2 then
				if sended == 0 then
				else
					outputChatBox("#D7DADA"..text, v, 255, 0, 0, true)
					sended = 1
				end
			end
			
			if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 6 and getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) >= 8 and dimension == dimension2 then
				if sended == 1 then
				else
					outputChatBox("#BFBDBB"..text, v, 255, 0, 0, true)
					sended = 1
				end
			end
			
			if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 8 and getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) >= 9 and dimension == dimension2 then
				if sended == 1 then
				else
					outputChatBox("#979796"..text, v, 255, 0, 0, true)
					sended = 1
				end
			end
			
			if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 9 and dimension == dimension2 then
				if sended == 1 then
				else
					outputChatBox("#808280"..text, v, 255, 0, 0, true)
					sended = 1
				end
			end
		end
		return
	end
	if messageType == 1 then
		triggerEvent("meAction", root, source, message)
		return
	end
end)

addEvent("meAction", true)
addEventHandler("meAction", root, function(player, action)
	players = getElementsByType("player")
	x, y, z = getElementPosition(player)
	dimension = getElementDimension(player)
	name = getPlayerName(player)
	name = string.gsub(name, "_", " ")
	for i, v in pairs(players) do
		x2, y2, z2 = getElementPosition(v)
		dimension2 = getElementDimension(v)
		if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 15 and dimension == dimension2 then
			outputChatBox("#C2A2DA* "..name.." "..action, v, 255, 0, 0, true)
		else
		end
	end
end)

addEvent("doAction", true)
addEventHandler("doAction", root, function(player, action)
	players = getElementsByType("player")
	x, y, z = getElementPosition(player)
	dimension = getElementDimension(player)
	name = getPlayerName(player)
	name = string.gsub(name, "_", " ")
	for i, v in ipairs(players) do
		x2, y2, z2 = getElementPosition(v)
		dimension2 = getElementDimension(v)
		if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 15 and dimension == dimension2 then
			outputChatBox("#9A9CCD* "..action.. " (("..name.."))", v, 255, 0, 0, true)
		else
		end
	end
end)

addEvent("sendLocalOOC", true)
addEventHandler("sendLocalOOC", root, function(player, message)
	players = getElementsByType("player")
	x, y, z = getElementPosition(player)
	dimension = getElementDimension(player)
	name = getPlayerName(player)
	name = string.gsub(name, "_", " ")
	for i, v in pairs(players) do
		x2, y2, z2 = getElementPosition(v)
		dimension2 = getElementDimension(v)
		local sended = 0
		if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 1 and dimension == dimension2 then
			if sended == 1 then
			else
				outputChatBox("#FFFFFF((".. name .. ": ".. message .. "))", v, 255, 0, 0, true)
				sended = 1
			end
		end
			
		if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 1 and getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) >= 2 and dimension == dimension2 then
			if sended == 1 then
			else
				outputChatBox("#DEDEDE((".. name .. ": ".. message .. "))", v, 255, 0, 0, true)
				sended = 1
			end
		end
			
		if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 4 and getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) >= 6 and dimension == dimension2 then
			if sended == 0 then
			else
				outputChatBox("#D7DADA((".. name .. ": ".. message .. "))", v, 255, 0, 0, true)
				sended = 1
			end
		end
			
		if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 6 and getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) >= 8 and dimension == dimension2 then
			if sended == 1 then
			else
				outputChatBox("#BFBDBB((".. name .. ": ".. message .. "))", v, 255, 0, 0, true)
				sended = 1
			end
		end
			
		if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 8 and getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) >= 9 and dimension == dimension2 then
			if sended == 1 then
			else
				outputChatBox("#979796((".. name .. ": ".. message .. "))", v, 255, 0, 0, true)
				sended = 1
			end
		end
			
		if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 9 and dimension == dimension2 then
			if sended == 1 then
			else
				outputChatBox("#808280((".. name .. ": ".. message .. "))", v, 255, 0, 0, true)
				sended = 1
			end
		end
	end
	return
end)

addCommandHandler("do", function(thePlayer, commmandName, ...)
	local action = {...}
	action = table.concat(action, " ")
	if not action then
		return
	end
	triggerEvent("doAction", root, thePlayer, action)
end)

addCommandHandler("b", function(thePlayer, commmandName, ...)
	local message = {...}
	message = table.concat(message, " ")
	if not message then
		return
	end
	triggerEvent("sendLocalOOC", root, thePlayer, message)
end)

addCommandHandler("w", function(thePlayer, commandName, id, ...)
	if not id then return end
	id = tonumber(id)
	if id < 0 or id > 4096 then return end
	local wiadomosc = {...}
	wiadomosc = table.concat(wiadomosc, " ")
	local players = getElementsByType("player")
	local player = nil
	for i,v in ipairs(players) do
		local playerid = getElementData(v, "id")
		if playerid == id then
			player = v
		end
	end
	if not player then return end
	outputChatBox("#99FFAA(( << ".. getPlayerName(thePlayer) .."(".. getElementData(thePlayer, "id") .."): ".. wiadomosc .. "))", player, 255, 0, 0, true)
	outputChatBox("#78DEAA(( >> ".. getPlayerName(player) .."(".. getElementData(player, "id") .."): ".. wiadomosc .. "))", thePlayer, 255, 0, 0, true)
end)