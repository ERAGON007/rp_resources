vehList = {} -- będzie przechowywać listę pojazdów po wywołaniu komendy

--[[addEventHandler("onResourceStart", resourceRoot, function()
	result = exports.rp_db:pobierzTabeleWynikow("SELECT * FROM rp_vehicles")
	for i,v in pairs(result) do
		local vehicle = createVehicle(v.model, v.parkX, v.parkY, v.parkZ)
		setElementData(vehicle, "vehInfo", v)
		setVehicleLocked(vehicle, true)
		setVehicleEngineState(vehicle, false)
		setElementData(vehicle, "engine", false)
		setVehicleColor ( vehicle, math.floor(v.color1/65536), math.floor(v.color1/256%256), v.color1%256, math.floor(v.color2/65536), math.floor(v.color2/256%256), v.color2%256, math.floor(v.color3/65536), math.floor(v.color3/256%256), v.color3%256, math.floor(v.color4/65536), math.floor(v.color4/256%256), v.color4%256)
		setVehicleOverrideLights(vehicle, 1)
		setElementHealth(vehicle, v.health)
		local panelState = string.explode(v.panelState, ",")
		for i,v in ipairs(panelState) do
			setVehiclePanelState(vehicle, i-1, v)
		end
		local doorState = string.explode(v.doorState, ",")
		for i,v in ipairs(doorState) do
			setVehicleDoorState(vehicle, i-1, v)
		end
	end
end)--]]

addEventHandler("onResourceStart", resourceRoot, function()
	result = exports.rp_db:pobierzTabeleWynikow("SELECT * FROM rp_vehicles")
	for i,v in pairs(result) do
		veh_create(v)
	end
end)

addEventHandler("onResourceStop", resourceRoot, function()
	local vehicles = getElementsByType("vehicle")
	for i,v in ipairs(vehicles) do
		veh_save(v)
	end
end)

function veh_create(v)
	local vehicle = createVehicle(v.model, v.parkX, v.parkY, v.parkZ)
	setElementData(vehicle, "vehInfo", v)
	setVehicleLocked(vehicle, true)
	setVehicleEngineState(vehicle, false)
	setElementData(vehicle, "engine", false)
	setVehicleColor ( vehicle, math.floor(v.color1/65536), math.floor(v.color1/256%256), v.color1%256, math.floor(v.color2/65536), math.floor(v.color2/256%256), v.color2%256, math.floor(v.color3/65536), math.floor(v.color3/256%256), v.color3%256, math.floor(v.color4/65536), math.floor(v.color4/256%256), v.color4%256)
	setVehicleOverrideLights(vehicle, 1)
	setElementHealth(vehicle, v.health)
	local panelState = string.explode(v.panelState, ",")
	for i,v in ipairs(panelState) do
		setVehiclePanelState(vehicle, i-1, v)
	end
	local doorState = string.explode(v.doorState, ",")
	for i,v in ipairs(doorState) do
		setVehicleDoorState(vehicle, i-1, v)
	end
end

function veh_save(v)
	vehInfo = getElementData(v, "vehInfo")
	if not vehInfo then return end
	local vi = {}
	vi.UID = vehInfo.UID
	vi.health = getElementHealth(v)
	vi.doorState = {}
	for i=0,5 do
		table.insert(vi.doorState, getVehicleDoorState(v, i))
	end
	vi.doorState = table.concat(vi.doorState, ",")
	vi.panelState = {}
	for i=0,6 do
		table.insert(vi.panelState, getVehiclePanelState(v, i))
	end
	vi.panelState = table.concat(vi.panelState, ",")

	exports.rp_db:zapytanie("UPDATE `rp_vehicles` SET `health`=?, `doorState`=?, `panelState`=?, `fuel`=? WHERE `UID`=?", vi.health, vi.doorState, vi.panelState, vi.fuel, vi.UID)
end

addCommandHandler("v", function(player, commandName, arg1)
	if not arg1 then
		outputChatBox("Użyj: /v [lista]", player)
	end
	local charInfo = getElementData(player, "charInfo")
	if arg1 == "lista" then
		local vehicles = getElementsByType("vehicle")
		for i,v in pairs(vehicles) do
			local vehInfo = getElementData(v, "vehInfo")
			if vehInfo.ownertype == 1 and vehInfo.ownerid == charInfo.UID then
				vehList[i] = vehInfo
			end
		end
		for i, v in pairs(vehList) do
			outputChatBox("UID: "..v.UID..", model: ".. v.model .. "", player)
		end
	end
end)

function openVehicleByPlayer(player, vehicle)
	if not player or not vehicle then return false end
	if hasPlayerVehicleKeys(player, vehicle) == true then
		if isVehicleLocked(vehicle) then
			--triggerEvent("meAction", root, player, "włożył kluczyk do zamka, następnie przekręcił otwierając pojazd.")
			setVehicleLocked(vehicle, false)
			setVehicleOverrideLights(vehicle, 1)
			setTimer(function()
				setVehicleOverrideLights(vehicle, 2)
				end, 150, 1)
			setTimer(function()
				setVehicleOverrideLights(vehicle, 1)
				end, 800, 1)
			return
		else
			--triggerEvent("meAction", root, player, "włożył kluczyk do zamka, następnie przekręcił zamykając pojazd.")
			setVehicleLocked(vehicle, true)
			setVehicleOverrideLights(vehicle, 1)
			setTimer(function()
				setVehicleOverrideLights(vehicle, 2)
				end, 150, 1)
			setTimer(function()
				setVehicleOverrideLights(vehicle, 1)
				end, 1500, 1)
			return
		end
	else
		if isVehicleLocked(vehicle) then
			--triggerEvent("meAction", root, player, "szarpie za klamke.")
		end
		return false
	end
end
addEvent("openVehicleByPlayer", true)
addEventHandler("openVehicleByPlayer", root, openVehicleByPlayer)

function turnVehicleEngineByPlayer(player, vehicle)
	local vehHP = getElementHealth(vehicle)
	if vehHP <= 350 then
		return
	end
	vehInfo = getElementData(vehicle, "vehInfo")
	if vehInfo.fuel <= 0 then
		return
	end
	toggleVehicleEngine(vehicle)
end
addEvent("turnVehicleEngineByPlayer", true)
addEventHandler("turnVehicleEngineByPlayer", root, turnVehicleEngineByPlayer)

function turnVehicleLightsByPlayer(player, vehicle)
	if getVehicleOverrideLights(vehicle) == 1 then -- wyłączone
		--triggerEvent("meAction", root, player, "przekręcił pokrętło, włączając światła.")
		setVehicleOverrideLights(vehicle, 2)
	elseif getVehicleOverrideLights(vehicle) == 2 then -- włączone
		--triggerEvent("meAction", root, player, "przekręcił pokrętło, wyłączając światła.")
		setVehicleOverrideLights(vehicle, 1)
	end
end
addEvent("turnVehicleLightsByPlayer", true)
addEventHandler("turnVehicleLightsByPlayer", root, turnVehicleLightsByPlayer)

function toggleVehicleHoodByPlayer(player, vehicle)
	if getVehicleDoorOpenRatio(vehicle, 0) > 0 then -- zamykamy
		--triggerEvent("meAction", root, player, "zatrzasnął maskę.")
		setVehicleDoorOpenRatio(vehicle, 0, 0, 700)
	else -- otwieramy
		--triggerEvent("meAction", root, player, "pociągnął za dźwignię, otwierając maskę.")
		setVehicleDoorOpenRatio(vehicle, 0, 1, 2000)
	end
end
addEvent("toggleVehicleHoodByPlayer", true)
addEventHandler("toggleVehicleHoodByPlayer", root, toggleVehicleHoodByPlayer)

function toggleVehicleTrunkByPlayer(player, vehicle)
	if getVehicleDoorOpenRatio(vehicle, 1) > 0 then -- zamykamy
		--triggerEvent("meAction", root, player, "zatrzasnął bagażnik.")
		setVehicleDoorOpenRatio(vehicle, 1, 0, 700)
	else -- otwieramy
		--triggerEvent("meAction", root, player, "nacisnął przycisk, a następnie otworzył bagażnik.")
		setVehicleDoorOpenRatio(vehicle, 1, 1, 2000)
	end
end
addEvent("toggleVehicleTrunkByPlayer", true)
addEventHandler("toggleVehicleTrunkByPlayer", root, toggleVehicleTrunkByPlayer)

function hasPlayerVehicleKeys(player, vehicle)
	local vehInfo = getElementData(vehicle, "vehInfo")
	if not vehInfo then return false end
	if exports.rp_playeritems:hasPlayerItem(player, 3, vehInfo.UID) == 1 then return true end
	return false
end

addEventHandler("onVehicleDamage", root, function(loss) -- przeciwko wybuchaniu
	local vHP = getElementHealth(source)
	if vHP < 300 or vHP - loss < 300 then
		setElementHealth(source, 300)
		if getVehicleEngineState(source) then
			setVehicleEngineState(source, false)
			local player = getVehicleOccupant(source)
			if player then
				--triggerEvent("doAction", root, player, "Silnik w pojeździe zgasł z powodu uszkodzeń.")
			end
		end
	end
end)

addEventHandler("onPlayerVehicleEnter", root, function(vehicle, seat, jacked)
	if seat ~= 0 then return end
	setVehicleEngineState(vehicle, getElementData(vehicle, "engine"))
end)

function toggleVehicleEngine(vehicle)
	if getElementData(vehicle, "engine") == false then
		setElementData(vehicle, "engine", true)
		setVehicleEngineState(vehicle, true)
	else
		setElementData(vehicle, "engine", false)
		setVehicleEngineState(vehicle, false)
	end
end

function getEngineState(vehicle)
	local engineState = getElementData(vehicle, "engine")
	setVehicleEngineState(vehicle, engineState)
	return engineState
end

--kilka funkcji
function Check(funcname, ...)
    local arg = {...}
 
    if (type(funcname) ~= "string") then
        error("Argument type mismatch at 'Check' ('funcname'). Expected 'string', got '"..type(funcname).."'.", 2)
    end
    if (#arg % 3 > 0) then
        error("Argument number mismatch at 'Check'. Expected #arg % 3 to be 0, but it is "..(#arg % 3)..".", 2)
    end
 
    for i=1, #arg-2, 3 do
        if (type(arg[i]) ~= "string" and type(arg[i]) ~= "table") then
            error("Argument type mismatch at 'Check' (arg #"..i.."). Expected 'string' or 'table', got '"..type(arg[i]).."'.", 2)
        elseif (type(arg[i+2]) ~= "string") then
            error("Argument type mismatch at 'Check' (arg #"..(i+2).."). Expected 'string', got '"..type(arg[i+2]).."'.", 2)
        end
 
        if (type(arg[i]) == "table") then
            local aType = type(arg[i+1])
            for _, pType in next, arg[i] do
                if (aType == pType) then
                    aType = nil
                    break
                end
            end
            if (aType) then
                error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..table.concat(arg[i], "' or '").."', got '"..aType.."'.", 3)
            end
        elseif (type(arg[i+1]) ~= arg[i]) then
            error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..arg[i].."', got '"..type(arg[i+1]).."'.", 3)
        end
    end
end

function string.explode(self, separator)
    Check("string.explode", "string", self, "ensemble", "string", separator, "separator")
 
    if (#self == 0) then return {} end
    if (#separator == 0) then return { self } end
 
    return loadstring("return {\""..self:gsub(separator, "\",\"").."\"}")()
end