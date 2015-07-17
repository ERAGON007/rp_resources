local EQ = {} -- aktualnie "przetwarzany" ekwipunek

addEvent("EQUseItem", true)

function getPlayerItems(player)
	if not player then return false end
	local charInfo = getElementData(player, "charInfo")
	if not charInfo then
		return false
	end
	local items = exports.rp_db:pobierzTabeleWynikow("SELECT * FROM `rp_items` WHERE `ownertype`=1 AND `ownerid`=?", charInfo.UID)
	setElementData(player, "EQ", items)
	return items
end

addEvent("refreshPlayerItems", true)
addEventHandler("refreshPlayerItems", root, function()
	getPlayerItems(client)
end)

function hasPlayerItem(player, itemType, itemSubtype)
	if not player or not itemType or not itemSubtype then
		return false
	end
	for i, v in ipairs(getElementData(player, "EQ")) do
		if v.type == itemType then
			if v.subtype == itemSubtype then
				return v.amount
			end
		end
	end
	return false
end

function minusPlayerItemByType(player, itemType, itemSubtype, amount)
	if not amount then
		amount = 1
	end
	local changed = 0
	EQ = {}
	local playerEQ = getElementData(player, "EQ")
	if not playerEQ then
		return false
	end
	for i, v in ipairs(playerEQ) do
		EQ[i] = {}
		if changed == 0 then
			if v.type == itemType then
				if v.subtype == itemSubtype then
					v.amount = v.amount - amount
					changed = 1
				end
			end
		end
		EQ[i].UID = v.UID
		EQ[i].amount = v.amount
		EQ[i].type = v.type
		EQ[i].subtype = v.subtype
		EQ[i].ownertype = v.ownertype
		EQ[i].ownerid = v.ownerid
		--zapisywanie zmian do bazy danych
		if EQ[i].amount < 1 then
			exports.rp_db:zapytanie("DELETE FROM `rp_items` WHERE `UID`=?", EQ[i].UID)
		else
			exports.rp_db:zapytanie("UPDATE `rp_items` SET `amount`=? WHERE `UID`=?", EQ[i].amount, EQ[i].UID)
		end
	end
	setElementData(player, "EQ", EQ)
end
addEvent("minusPlayerItemByType", true)
addEventHandler("minusPlayerItemByType", root, minusPlayerItemByType)

addEventHandler("onElementDataChange", root, function(name, oldValue)
	if not source then return end
	if name ~= "EQ" then return end
	oldEQ = oldValue
	newEQ = getElementData(source, "EQ")
end)