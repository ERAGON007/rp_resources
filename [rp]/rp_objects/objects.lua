addEvent("recachePlayerObjects", true)
addEventHandler("recachePlayerObjects", root, function(player)
	if not player and not source then return false end
	if not player then player = source end
	if getElementData(player, "inProperty") > 0 then -- jest w budynku - wczytujemy jego obiekty
		local objects = exports.rp_db:pobierzTabeleWynikow("SELECT * FROM `rp_objects` WHERE `zonetype`=1 AND `zoneid`=?", getElementData(player, "inProperty"))
		return setElementData(player, "objects:table", objects)
	end
end)

addEvent("reloadPlayerObjects", true)
addEventHandler("reloadPlayerObjects", root, function(player)
	triggerClientEvent(player, "reloadPlayerObjects")
end)