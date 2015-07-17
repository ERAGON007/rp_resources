--[[addCommandHandler("zaloguj", function(commandName, login, password)
	if(getElementData(localPlayer, "auth:logged") == true) then
		return
	end
	triggerServerEvent("onAuthRequest", localPlayer, login, password)
end)--]]

local screen = {}
screen.w, screen.h = guiGetScreenSize()

local loginPed = nil
local selectedChar = 1
local selectedCharInfo = nil

local font = exports.rp_fonts:getFont("myriadproregular", 22)

Login = {}
addEventHandler("onClientResourceStart", resourceRoot, function()
        	Login.window = guiCreateWindow(0.41, 0.19, 0.19, 0.39, "Zaloguj się", true)
        	guiWindowSetMovable(Login.window, false)
        	guiWindowSetSizable(Login.window, false)

        	Login.Button = guiCreateButton(0.35, 0.81, 0.33, 0.16, "Zaloguj", true, Login.window)
        	Login.LoginLabel = guiCreateEdit(0.07, 0.18, 0.87, 0.14, "", true, Login.window)
        	Login.PasswordLabel = guiCreateEdit(0.07, 0.51, 0.87, 0.14, "", true, Login.window)
   	guiEditSetMasked(Login.PasswordLabel, true)
    Login.PasswordInfo = guiCreateLabel(0.06, 0.39, 0.62, 0.09, "Hasło:", true, Login.window)
	Login.LoginInfo = guiCreateLabel(0.07, 0.05, 0.61, 0.10, "Login:", true, Login.window)    
	addEventHandler("onClientGUIClick", Login.Button, requestAuth)

	setPlayerHudComponentVisible("all", false)
	fadeCamera(true, 5)
	setCameraMatrix(1481.8495, -1687.1045, 55.0469, 1470.8495, -1780.1045, 30.0469)
	guiSetInputEnabled(true)
end)

function requestAuth()
	local login = guiGetText(Login.LoginLabel)
	local password = guiGetText(Login.PasswordLabel)
	triggerServerEvent("onAuthRequest", localPlayer, login, password)
end

addEvent("onAuthResult", true)
addEventHandler("onAuthResult", root, function(result)
	exports.rp_notifications:showBox(result.komunikat)
	if result.success == true then
		guiSetInputEnabled(false)
		guiSetVisible(Login.window, false)
		local gInfo = getElementData(localPlayer, "globalInfo")
		triggerServerEvent("fetchPlayerCharacters", localPlayer, gInfo.member_id)
	end
end)

addEvent("onCharactersReceived", true)
addEventHandler("onCharactersReceived", root, function(chars)
	setElementData(localPlayer, "chars", chars)
	charscount = 0
	for i, v in pairs(getElementData(localPlayer, "chars")) do
		if i == 1 then
			loginPed = createPed(v.skin, 1484.8495, -1694.1045, 15.0469)
			setElementDimension(loginPed, getElementData(localPlayer, "id") + 50000)
			selectedCharInfo = v
		end
		charscount = charscount + 1
	end
	setElementDimension(localPlayer, getElementData(localPlayer, "id") + 50000)
	setCameraMatrix(1485.8495, -1687.1045, 13.0469, 1484.8495, -1694.1045, 15.0469, 0, 40)
	addEventHandler("onClientRender", root, viewSelectedCharacterInfo)
	bindKey("arrow_l", "down", previousChar)
	bindKey("arrow_r", "down", nextChar)
	bindKey("enter", "down", selectChar)
end)

function viewSelectedCharacterInfo()
	if not selectedCharInfo then return end

	local text = selectedCharInfo.name
	text = string.gsub(text, "_", " ")

	dxDrawText(text, 0.5 * screen.w, 0.1111 * screen.h, 0.5 * screen.w, 0.1111 * screen.h, tocolor(200, 50, 40), 1, font, "center", "center")
end

function nextChar()
	selectedChar = selectedChar + 1
	if selectedChar > charscount then selectedChar = 1 end
	for i, v in ipairs(getElementData(localPlayer, "chars")) do
		if i == selectedChar then
			selectedCharInfo = v
			setElementModel(loginPed, v.skin)
		end
	end
end

function previousChar()
	selectedChar = selectedChar - 1
	if selectedChar < 1 then selectedChar = 1 end
	for i, v in ipairs(getElementData(localPlayer, "chars")) do
		if i == selectedChar then
			selectedCharInfo = v
			setElementModel(loginPed, v.skin)
		end
	end
end

function selectChar()
	local chars = getElementData(localPlayer, "chars")
	for i, v in ipairs(chars) do
		if i == selectedChar then
			--if v ~= selectedCharInfo then return end
			setElementData(localPlayer, "charInfo", v)
			setElementData(localPlayer, "groups", nil)
			--removeElement(loginPed)
			unbindKey("arrow_l", "down", previousChar)
			unbindKey("arrow_r", "down", nextChar)
			unbindKey("enter", "down", selectChar)
			removeEventHandler("onClientRender", root, viewSelectedCharacterInfo)
			setPlayerHudComponentVisible("all", true)
			triggerServerEvent("spawn", localPlayer)
		end
	end
end