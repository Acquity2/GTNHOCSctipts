local GUI = require("GUI")
local image = require("Image")
local screen = require("Screen")
local component = require("Component")

local GTMachine = component.gt_machine
local redstone = component.redstone

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
screen.setResolution(80,30)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local workspace = GUI.workspace()
workspace:addChild(GUI.panel(1, 1, workspace.width, workspace.height, 0x2D2D2D))

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Frame1 = workspace:addChild(GUI.object(2, 2, 78, 5))
Frame1.draw = function(object)
	screen.drawFrame(object.x, object.y, object.width, object.height, 0x44cdff)
end

local Frame2 = workspace:addChild(GUI.object(2, 7, 38, 16))
Frame2.draw = function(object)
	screen.drawFrame(object.x, object.y, object.width, object.height, 0x44cdff)
end

local Box1 = workspace:addChild(GUI.object(3, 5, 76, 6))
-- Create own :draw() method and make it render green rectangle
Box1.draw = function(object)
	screen.drawSemiPixelRectangle(object.x, object.y, object.width, object.height, 0x000000)
end

local Box2 = workspace:addChild(GUI.object(4, 6, 74, 4))
-- Create own :draw() method and make it render green rectangle
Box2.draw = function(object)
	screen.drawSemiPixelRectangle(object.x, object.y, object.width, object.height, 0x662D2D)
end

local Bar = workspace:addChild(GUI.object(4, 6, 37, 4))
-- Create own :draw() method and make it render green rectangle
Bar.draw = function(object)
	screen.drawSemiPixelRectangle(object.x, object.y, object.width, object.height, 0x138000)
end

local percent = workspace:addChild(GUI.text(39, 2, 0xFFFFFF, "50%"))

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
workspace:addChild(GUI.label(3, 2, workspace.width, workspace.height, 0xFFFFFF, "Energy Storage in Station:"))

workspace:addChild(GUI.label(3, 8, workspace.width, workspace.height, 0xFFFFFF, "Maximum Eu Input:"))

workspace:addChild(GUI.label(3, 13, workspace.width, workspace.height, 0xFFFFFF, "Current EU Output:"))

workspace:addChild(GUI.label(3, 18, workspace.width, workspace.height, 0xFFFFFF, "Running Cost:"))

workspace:addChild(GUI.label(41, 13, workspace.width, workspace.height, 0xFFFFFF, "Generator Status:"))

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local framedButton = workspace:addChild(GUI.framedButton(40, 27, 40, 3, 0xFFFFFF, 0xFFFFFF, 0x880000, 0x880000, "EXIT"))
framedButton.onTouch = function()
	workspace:stop()
end

local framedButton = workspace:addChild(GUI.framedButton(40, 20, 40, 3, 0xFFFFFF, 0xFFFFFF, 0x880000, 0x880000, "EXIT"))
framedButton.onTouch = function()
	local percent, _percent = GetMachineInfo()
    GUI.alert(percent, _percent)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function GetMachineInfo()
    local _info = GTMachine.getSensorInformation()
    local EUStoredStr = string.sub(_info[3],15,-4)
    local ESS = string.gsub(EUStoredStr,",","")
    local EUStoredNum = tonumber(ESS)
    local MaxEUStr = string.sub(_info[4],13,-4)
    local MES = string.gsub(MaxEUStr,",","")
    local MaxEUNum = tonumber(MES)
    local percent = math.floor(EUStoredNum / MaxEUNum * 100)
    return percent,tostring(percent).."%"
end


workspace:draw()
GUI.alert(screen.getResolution())
--GUI.alert(component.get("gt_machine"))
--GUI.alert(GTMachine.getEUStored())
workspace:start()
