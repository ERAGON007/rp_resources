local function findFreeValue(tablica_id)
	table.sort(tablica_id)
	local wolne_id=0
	for i,v in ipairs(tablica_id) do
		if (v==wolne_id) then wolne_id=wolne_id+1 end
		if (v>wolne_id) then return wolne_id end
	end
	return wolne_id
end

function assignIDToPlayer(player)
	local players = getElementsByType("player")
	local playerIDs = {}
	for i, v in ipairs(players) do
		local ID = getElementData(v, "id")
		if ID then
			table.insert(playerIDs, tonumber(ID))
		end
	end
	local free_id = findFreeValue(playerIDs)
	setElementData(player, "id", free_id)
	return free_id
end

addEventHandler("onPlayerJoin", root, function()
	assignIDToPlayer(source)
end)


addEventHandler("onPlayerChangeNick", getRootElement(), function()
	cancelEvent()
end)