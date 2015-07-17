infoBox = {}
infoBox.showTime = 1000
infoBox.time = 2500
infoBox.hideTime = 1000
infoBox.startTick = nil
infoBox.text = nil
infoBox.font = exports.rp_fonts:getFont("myriadprocondensed", 12, false)
infoBox.background = dxCreateTexture("img/info.png", "argb", true, "clamp")
infoBox.state = nil
infoBox.startY = -550
infoBox.stopY = 0
--550 x 185
sWidth, sHeight = guiGetScreenSize()

function drawInfo()
	tickCount = getTickCount()
	if infoBox.state == "starting" then
		progress = (tickCount - infoBox.startTick)/infoBox.showTime
		currentX, currentY, currentZ = interpolateBetween(0, infoBox.startY, 0, 0, infoBox.stopY, 0, progress, "Linear")
		if progress >= 1 then
			infoBox.state = "showing"
			infoBox.startTick = getTickCount()
		end
	elseif infoBox.state == "showing" then
		currentY = infoBox.stopY
		if (tickCount - infoBox.startTick) > infoBox.time then
			infoBox.state = "hiding"
			infoBox.startTick = getTickCount()
		end
	elseif infoBox.state == "hiding" then
		progress = (tickCount - infoBox.startTick)/infoBox.hideTime
		currentX, currentY, currentZ = interpolateBetween(0, infoBox.stopY, 0, 0, infoBox.startY, 0, progress, "Linear")
		if progress >= 1 then
			infoBox.state = nil
			infoBox.text = nil
			infoBox.startTick = nil
			removeEventHandler("onClientRender", root, drawInfo)
			return
		end
	end
	dxDrawImage(sWidth/2 - 275, currentY, 550, 185, infoBox.background)
	dxDrawText(infoBox.text, sWidth/2 - 250, currentY + 40, sWidth/2 + 250, currentY + 155, tocolor(255, 255, 255), 1, infoBox.font, "center", "top", false, true)
end

addEvent("showBox", true)
addEventHandler("showBox", root, function(text)
	if not text then return end
	infoBox.startTick = getTickCount()
	infoBox.text = text
	infoBox.state = "starting"
	addEventHandler("onClientRender", root, drawInfo)
end)

function showBox(text)
	triggerEvent("showBox", localPlayer, text)
end