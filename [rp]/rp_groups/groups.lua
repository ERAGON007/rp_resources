db = exports.rp_db

function createGroup(name, leaderUID)
	db:zapytanie("INSERT INTO `rp_groups` SET `name`=?, `leaderUID`=?", name, leaderUID)
	local group = db:pobierzWyniki("SELECT * FROM `rp_groups` WHERE `name`=? AND `leaderUID`=?", name, leaderUID)
	db:zapytanie("INSERT INTO `rp_groups_members` SET `groupUID`=?, `charUID`=?", group.UID, leaderUID)
end

function getGroupInfo(groupUID)
	return db:pobierzWyniki("SELECT * FROM `rp_groups` WHERE `UID`=?", groupUID)
end

function getPlayerGroups(charUID)
	return db:pobierzTabeleWynikow("SELECT * FROM `rp_groups_members` WHERE `charUID`=?", charUID)
end

function addPlayerDutyTimeInGroup(charUID, groupUID, time)
	--czas w minutach!
	local dutyTime = db:pobierzWyniki("SELECT `dutyTime` FROM `rp_groups_members` WHERE `charUID`=? AND `groupUID`=?", charUID, groupUID)
	if not dutyTime then
		return false
	end
	dutyTime = dutyTime.dutyTime
	dutyTime = dutyTime + time
	db:zapytanie("UPDATE `rp_groups_members` SET `dutyTime`=? WHERE `charUID`=? AND `groupUID`=?", dutyTime, charUID, groupUID)
end

--[[
	Uprawnienia:
	pojazdy - 1
	podawanie - 2
	Zapraszanie - 4
	Wyrzucanie - 8
	Zamawianie przedmiotów - 16
	Magazyn - 32
	Wpłata na konto - 64
	Wypłata z konta - 128
]]--

function hasPlayerPermissionInGroup(charUID, groupUID, permission)
	local playerPermissions = db:pobierzWyniki("SELECT `permissions` FROM `rp_groups_members` WHERE `charUID`=? AND `groupUID`=?", charUID, groupUID)
	playerPermissions = playerPermissions.permissions

	if bitTest(playerPermissions, permission) then
		return true
	end

	return false
end

--[[
	Typy grup:
	0 - brak
	1 - Rządowa
	2 - porządkowa(LSPD, FBI, itd.)
	4 - ochrona
	8 - gang
	16 - mafia
	32 - ściganci
	64 - firma budowlana
	128 - warsztat
	256 - siłownia
	512 - restauracja
	1024 - klub
]]--

function isGroupType(groupUID, type)
	local groupInfo = getGroupInfo(groupUID)
	if bitTest(groupInfo.types, type) then
		return true
	end
	return false
end

function groupCommand(player, command, arg1, arg2)
	--arg1 slot grupy, arg2 parametr
	arg1 = tonumber(arg1)
	local charInfo = getElementData(player, "charInfo")
	local playerGroups = getPlayerGroups(charInfo.UID)
	local playerGroupsInfo = {}
	for i,v in ipairs(playerGroups) do
		playerGroupsInfo[v.groupUID] = getGroupInfo(v.groupUID)
	end
	if not playerGroups[arg1] then
		return
	end
	if arg2 == "duty" then
		if not getElementData(player, "onGroupDuty") then
			setElementData(player, "onGroupDuty", true)
			setElementData(player, "groupDutyUID", playerGroups[arg1].groupUID)
			setElementData(player, "groupDutyStart", getTickCount())
			exports.rp_notifications:showBox(player, "Rozpocząłeś pracę w grupie "..playerGroupsInfo[playerGroups[arg1].groupUID].name..".")
		else
			if getElementData(player, "groupDutyUID") ~= playerGroups[arg1].groupUID then
				return
			end
			local dutyTime = getTickCount() - getElementData(player, "groupDutyStart")
			setElementData(player, "onGroupDuty", false)
			setElementData(player, "groupDutyUID", nil)
			setElementData(player, "groupDutyStart", nil)
			addPlayerDutyTimeInGroup(charInfo.UID, playerGroups[arg1].groupUID, math.floor(dutyTime / 60000))
			exports.rp_notifications:showBox(player, "Skończyłeś pracę w grupie "..playerGroupsInfo[playerGroups[arg1].groupUID].name..".\nPrzepracowałeś "..math.floor(dutyTime / 60000).." minut.")
		end
	elseif arg2 == "przebierz" then
		if not playerGroups[arg1].skin then
			return
		end
		if not getElementData(player, "groupSkinUsing") then
			setElementData(player, "groupSkinUsing", true)
			setElementModel(player, playerGroups[arg1].skin)
			exports.rp_notifications:showBox(player, "Przebrałeś się w ubranie służbowe.")
		else
			setElementData(player, "groupSkinUsing", false)
			setElementModel(player, charInfo.skin)
			exports.rp_notifications:showBox(player, "Przebrałeś się w ubranie codzienne.")
		end
	end
end
addCommandHandler("g", groupCommand)
addCommandHandler("group", groupCommand)