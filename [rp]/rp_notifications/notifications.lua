function showBox(player, text)
	if not player or not text then return end
	triggerClientEvent(player, "showBox", player, text)
end