PERM_SKIN = 1
PERM_INVITE = 2
PERM_KICK = 4
PERM_MAN = 8

TYPE_WORKSHOP = 1

local groups = {} -- aktualnie przetwarzane dane

function fetchPlayerGroups()
	groups = {}
	player = client
	charInfo = getElementData(player, "charInfo")
	if not charInfo then
		return
	end
	local result = exports.rp_db:pobierzTabeleWynikow("SELECT * FROM `rp_groups_members` WHERE `charid`=?", charInfo.UID)
	if not result then return false end
	for i, v in ipairs(result) do
		groups[i] = {}
		groups[i].groupMember = {}
		groups[i].groupMember = v
		res = exports.rp_db:pobierzWyniki("SELECT * FROM `rp_groups` WHERE `UID`=?", v.groupid)
		groups[i].groupInfo = {}
		groups[i].groupInfo = res
	end
	setElementData(player, "groups", groups)
	return
end
addEvent("fetchPlayerGroups", true)
addEventHandler("fetchPlayerGroups", root, fetchPlayerGroups)

function havePlayerPerms(player, group, perm)
	if not player or not groupMember or not perm then
		return false
	end
	if perm == "PERM_SKIN" then
		if bitTest(groupMember.perms, PERM_SKIN) then
			return true
		else
			return false
		end
	end
	if perm == "PERM_INVITE" then
		if bitTest(groupMember.perms, PERM_INVITE) then
			return true
		else
			return false
		end
	end
	if perm == "PERM_KICK" then
		if bitTest(groupMember.perms, PERM_KICK) then
			return true
		else
			return false
		end
	end
	if perm == "PERM_MAN" then
		if bitTest(groupMember.perms, PERM_MAN) then
			return true
		else
			return false
		end
	end
end