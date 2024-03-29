local component = require("component")


if not component.isAvailable("internet") then
	io.stderr:write("This application requires an internet card")
	return
end

local inter2 = component.internet
if not inter2.isHttpEnabled() then
	io.stderr:write("Internet connections are currently disabled in game config")
	return
end

local internet = require("internet")


local FileList = {
	{FileName = "GUI.lua", Url = "https://raw.githubusercontent.com/IgorTimofeev/GUI/master/GUI.lua"},
	{FileName = "AdvancedLua.lua", Url = "https://raw.githubusercontent.com/IgorTimofeev/AdvancedLua/master/AdvancedLua.lua"},
	{FileName = "Color.lua", Url = "https://raw.githubusercontent.com/IgorTimofeev/Color/master/Color.lua"},
	{FileName = "DoubleBuffering.lua", Url = "https://raw.githubusercontent.com/IgorTimofeev/DoubleBuffering/master/DoubleBuffering.lua"},
	{FileName = "Image.lua", Url = "https://raw.githubusercontent.com/IgorTimofeev/Image/master/Image.lua"},
	{FileName = "OCIF.lua", Url = "https://raw.githubusercontent.com/IgorTimofeev/Image/master/OCIF.lua"},
	--{FileName = "", Url = ""}
}

local FileList1 = {
	{FileName = "OCIF.lua", Url = "https://raw.githubusercontent.com/IgorTimofeev/Image/master/OCIF.lua"},
	--{FileName = "", Url = ""}
}

local FileList2 = {
	{FileName = "GeneratorControl.lua", Url = "https://github.com/Acquity2/GTNHOCSctipts/raw/main/GeneratorControl.lua"},
	--{FileName = "", Url = ""}
}



function download(FileName,Location,Url)

	local arpmUrl = Url
	local additionalHeaders = {
		--["User-Agent"] = "ARPM/dropper" -- Gitlab returns HTTP 403 when default user agent is used (e.g. Java/1.8.0_131)
	}
	local saveFile = Location..FileName
	print("Downloading to  " .. saveFile)
	local content = ""
	local response = internet.request(arpmUrl, nil, additionalHeaders)
	for chunk in response do
		content = content .. chunk
	end

	local handle = io.open(saveFile, "w")
	handle:write(content)
	handle:close()
	print(FileName.." Download complete")

end

for k,v in pairs(FileList) do
	local _Location = "/lib/"
	local _FileNmae = v.FileName
	local _Url = v.Url
	download(_FileNmae,_Location,_Url)
end

for k,v in pairs(FileList1) do
	local _Location = "/lib/FormatModules/"
	local _FileNmae = v.FileName
	local _Url = v.Url
	download(_FileNmae,_Location,_Url)
end

for k,v in pairs(FileList2) do
	local _Location = "/home/"
	local _FileNmae = v.FileName
	local _Url = v.Url
	download(_FileNmae,_Location,_Url)
end