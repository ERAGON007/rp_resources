addCommandHandler("opis", function(player, command, ...)
	arg = {...}
	arg1 = table.concat(arg, " ")
	charInfo = getElementData(player, "charInfo")
	if arg1 == "usun" then
		exports.rp_notifications:showBox(player, "Usunąłeś aktualny opis!")
		charInfo.opis = nil
		setElementData(player, "charInfo", charInfo)
		return
	end
	if string.len(arg1) < 5 then
		exports.rp_notifications:showBox(player, "Użyj: /opis [usun/tresc]")
		charInfo.opis = nil
		setElementData(player, "charInfo", charInfo)
		return
	end
	exports.rp_notifications:showBox(player, "Ustawiłeś opis: \n"..arg1)
	charInfo.opis = arg1
	setElementData(player, "charInfo", charInfo)
	return
end)