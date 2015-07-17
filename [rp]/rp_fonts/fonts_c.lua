function getFont(font, size, bold)
	if not font then font = "myriadproregular" end
	if not size then size = 9 end
	if not bold then bold = false end
	
	local font = dxCreateFont(font..".ttf", size, bold)
	return font
end