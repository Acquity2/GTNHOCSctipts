local GUI = require("GUI")
local buffer = require("doubleBuffering")

local component = require("component")
local sides = require("sides")
local string = require("string")

local GTMachine = component.gt_machine

local function GetMachineInfo()
    local _info = GTMachine.getSensorInformation()
    local EUStoredStr = string.sub(_info[3],15,-4)
    local ESS = string.gsub(EUStoredStr,",","")
    local EUStoredNum = tonumber(ESS)
    local MaxEUStr = string.sub(_info[4],13,-4)
    local MES = string.gsub(MaxEUStr,",","")
    local MaxEUNum = tonumber(MES)
    local percent = math.floor(EUStoredNum / MaxEUNum * 100)
    return percent,tostring(percent).."%",EUStoredStr,MaxEUStr
end


local workspace = GUI.application()

-- Create and add template object to application
local object = workspace:addChild(GUI.object(3, 2, 50, 10))
-- Create own :draw() method and make it render green rectangle
object.draw = function(object)
	buffer.drawRectangle(object.x, object.y, object.width, object.height, 0x33FF80, 0x0, " ")
end

workspace:addChild(GUI.framedButton(2, 22, 30, 3, 0xFFFFFF, 0xFFFFFF, 0x880000, 0x880000, "Framed button")).onTouch = function()
	GUI.alert("Framed button was pressed")
    workspace:stop()
end
--------------------------------------------------------------------------------

-- Draw application content once on screen when program starts
workspace:draw(true)
-- Start processing events for application
workspace:start()