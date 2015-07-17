selectedGroup = nil

List = {}
addEventHandler("onClientResourceStart", resourceRoot, function()
        	List.Window = guiCreateWindow(0.38, 0.28, 0.25, 0.50, "Twoje grupy", true)
        	guiWindowSetMovable(List.Window, false)
        	guiWindowSetSizable(List.Window, false)

        	List.Gridlist = guiCreateGridList(0.04, 0.07, 0.94, 0.80, true, List.Window)
        	guiGridListAddColumn(List.Gridlist, "UID", 0.5)
        	guiGridListAddColumn(List.Gridlist, "Nazwa", 0.5)
        	List.ChooseButton = guiCreateButton(0.04, 0.88, 0.44, 0.10, "Wybierz", true, List.Window)
	List.CloseButton = guiCreateButton(0.50, 0.88, 0.45, 0.09, "Anuluj", true, List.Window) 

	addEventHandler("onClientGUIClick", List.CloseButton, hideListWindow)   
	addEventHandler("onClientGUIClick", List.ChooseButton, chooseSelectedGroup)

	guiSetVisible(List.Window, false)
end)


addCommandHandler("g", function(command, arg1)
	if guiGetVisible(GroupMan.Window) then
		guiSetVisible(GroupMan.Window, false)
		showCursor(false, false)
	end
	if not guiGetVisible(List.Window) then
		triggerServerEvent("fetchPlayerGroups", localPlayer)
		local playerGroups = getElementData(localPlayer, "groups")
		selectedGroup = nil
		guiGridListClear(List.Gridlist)
		for i,v in ipairs(playerGroups) do
			local row = guiGridListAddRow(List.Gridlist)

			guiGridListSetItemText(List.Gridlist, row, 1, tostring(v.groupInfo.UID), false, false)

			guiGridListSetItemText(List.Gridlist, row, 2, tostring(v.groupInfo.name), false, false)

			guiGridListSetItemData(List.Gridlist, row, 1, v.groupInfo.UID)
		end
		guiSetVisible(List.Window, true)
		showCursor(true, true)
	end
end)

function hideListWindow()
	guiSetVisible(List.Window, false)
	showCursor(false, false)
end

function chooseSelectedGroup()
	local row,col = guiGridListGetSelectedItem(List.Gridlist)

	if row and col and row ~= -1 and col ~= -1 then
		selectedGroup = guiGridListGetItemData(List.Gridlist, row, col)
	end
	guiSetVisible(List.Window, false)
	showCursor(false, false)

	if selectedGroup >= 1 then
		local playerGroups = getElementData(localPlayer, "groups")
		for i,v in ipairs(playerGroups) do
			if v.groupInfo.UID == selectedGroup then
				guiSetText(GroupMan.Window, v.groupInfo.name)
			end
		end

		guiSetVisible(GroupMan.Window, true)
		showCursor(true, true)
	end
end


GroupManOnline = {}
GuiManInfo = {
	tab = {}
}
GroupMan = {}
addEventHandler("onClientResourceStart", resourceRoot, function()
     	GroupMan.Window = guiCreateWindow(575, 225, 450, 450, "Nazwa Grupy", false)
        	guiWindowSetSizable(GroupMan.Window, false)

        	GroupMan.InfoTab = guiCreateTabPanel(19, 26, 410, 396, false, GroupMan.Window)
        	GuiManInfo.tab[1] = guiCreateTab("Info", GroupMan.InfoTab)
        	GuiManInfo.DutyButton = guiCreateButton(163, 250, 125, 80, "Służba", false, GuiManInfo.tab[1])
        	GroupMan.OnlineTab = guiCreateTab("Online", GroupMan.InfoTab)
       		GroupManOnline.Gridlist = guiCreateGridList(2, 2, 408, 370, false, GroupMan.OnlineTab)

        	guiGridListAddColumn(GroupManOnline.Gridlist, "ID", 0.5)
        	guiGridListAddColumn(GroupManOnline.Gridlist, "Nazwa", 0.5)    

        	addEventHandler("onClientGUIClick", GuiManInfo.DutyButton, onDutyButton)   

        	guiSetVisible(GroupMan.Window, false)
end)

function onDutyButton()
	if not getElementData(localPlayer, "groups:duty") then -- wchodzimy na służbę
		setElementData(localPlayer, "groups:duty", selectedGroup)
		outputChatBox("Zacząłeś pracę w grupie.")
	else -- schodzimy ze służby
		setElementData(localPlayer, "groups:duty", false)
		outputChatBox("Skończyłeś pracę w grupie.")
	end 
end