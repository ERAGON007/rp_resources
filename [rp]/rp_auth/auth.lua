addEvent("onAuthRequest", true)
addEventHandler("onAuthRequest", root, function(login, password)
	if not login or not password then
		local result = {success=false, komunikat="Musisz podać login i hasło!"}
		triggerClientEvent(client, "onAuthResult", root, result) 
		return
	end
	
	local queryResult = exports.rp_db:pobierzWyniki("SELECT members_pass_salt FROM ipb_members WHERE name=? LIMIT 1;", login)
	--local queryResult = exports.rp_db:pobierzWyniki("SELECT `salt` FROM `mybb_users` WHERE username=? LIMIT 1;", login)
	if not queryResult then
		local result = {success=false, komunikat="Nie posiadasz konta!"}
		triggerClientEvent(client, "onAuthResult", root, result) 
		return
	end
	
	local globalInfo = exports.rp_db:pobierzWyniki("SELECT * FROM ipb_members WHERE name=? AND members_pass_hash=md5(CONCAT(md5(?),md5(?))) LIMIT 1;", login, queryResult.members_pass_salt, password)
	--local globalInfo = exports.rp_db:pobierzWyniki("SELECT * FROM `mybb_users` WHERE username=? AND password=md5(CONCAT(md5(?),md5(?))) LIMIT 1;", login, queryResult.salt, password)
	if not globalInfo then
		local result = {success=false, komunikat="Nie prawidłowe hasło!"}
		triggerClientEvent(client, "onAuthResult", root, result) 
		return
	end
	
	setElementData(client, "globalInfo", globalInfo)
	
	setElementData(client, "auth:logged", true)
	setElementData(client, "inProperty", 0)
	
	local result = {success=true, komunikat="Zalogowałeś się!"}
	triggerClientEvent(client, "onAuthResult", root, result)
	return
end)

addEvent("fetchPlayerCharacters", true)
addEventHandler("fetchPlayerCharacters", root, function(globalid)
	if not globalid then
		outputDebugString("not globalid")
		return
	end
	local chars = exports.rp_db:pobierzTabeleWynikow("SELECT * FROM rp_characters WHERE globalid=?", globalid)
	if not chars then
		return
	end
	triggerClientEvent(client, "onCharactersReceived", root, chars)
end)

function savePlayerData(player)
	local charInfo = getElementData(player, "charInfo")
	if not charInfo then return end
	local money = getPlayerMoney(player)
	exports.rp_db:zapytanie("UPDATE `rp_characters` SET `skin`=? AND `money`=? WHERE `UID`=?", charInfo.skin, money, charInfo.UID)
end

addEventHandler("onPlayerQuit", root, function()
	savePlayerData(source)
end)