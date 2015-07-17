sWidth, sHeight = guiGetScreenSize()
local shader = dxCreateShader("bw.fx", 0.1, 0, false, "other")

addEventHandler("onClientRender", root, function()
	dxDrawImage(0, 0, sWidth, sHeight, shader)
end)