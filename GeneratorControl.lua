local GUI = require("GUI")
local buffer = require("doubleBuffering")
local component = require("component")
local sides = require("sides")
local string = require("string")
local event = require("event")


local GTMachine = component.gt_machine
local redstone = component.redstone
local perNum = 50
local generator = false
local PID = nil
local _side = sides.east --设置红石信号输出面

buffer.setResolution(80,30)

--------------------------------------------------------------------------------------------------------------------------------
local function GetMachineInfo()
    local _info = GTMachine.getSensorInformation()
    local EUStoredStr = string.sub(_info[3],15,-4)
    local ESS = string.gsub(EUStoredStr,",","")
    local EUStoredNum = tonumber(ESS)
    local MaxEUStr = string.sub(_info[4],14,-4)
    local MES = string.gsub(MaxEUStr,",","")
    local MaxEUNum = tonumber(MES)
    local percent = math.floor(EUStoredNum / MaxEUNum * 100)
    local RunningCostStr = string.sub(_info[5],19,-9).." EU/t    "
    local MaxEnergyIncome = string.gsub(string.gsub(_info[20],"§e",""),"§r","")
    local AEnergyOutput = string.sub(_info[11],19,-7).." EU/t    "
    return percent, tostring(percent).."%", RunningCostStr, MaxEnergyIncome, AEnergyOutput, EUStoredStr, MaxEUStr
end

local function stopGenerator()
    redstone.setOutput(_side,0)
    generator = false
end

local function startGenerator()
    redstone.setOutput(_side,15)
    generator = true
end

--------------------------------------------------------------------------------------------------------------------------------
local workspace = GUI.application()

--------------------------------------------------------------------------------------------------------------------------------
workspace:addChild(GUI.panel(1, 1, workspace.width, workspace.height, 0x262626))

--------------------------------------------------------------------------------------------------------------------------------
local Frame1 = workspace:addChild(GUI.object(2, 2, 78, 5))
Frame1.draw = function(object)
	buffer.drawFrame(object.x, object.y, object.width, object.height, 0x44cdff)
end

local Frame2 = workspace:addChild(GUI.object(2, 7, 38, 16))
Frame2.draw = function(object)
	buffer.drawFrame(object.x, object.y, object.width, object.height, 0x44cdff)
end

local Frame3 = workspace:addChild(GUI.object(40, 7, 40, 9))
Frame3.draw = function(object)
	buffer.drawFrame(object.x, object.y, object.width, object.height, 0x44cdff)
end

local Box1 = workspace:addChild(GUI.object(3, 5, 76, 6))
Box1.draw = function(object)
	buffer.drawSemiPixelRectangle(object.x, object.y, object.width, object.height, 0x646464)
end

local Box2 = workspace:addChild(GUI.object(4, 6, 74, 4))
Box2.draw = function(object)
	buffer.drawSemiPixelRectangle(object.x, object.y, object.width, object.height, 0x662D2D)
end

local Box3 = workspace:addChild(GUI.object(78, 7, 1, 2))
Box3.draw = function(object)
	buffer.drawSemiPixelRectangle(object.x, object.y, object.width, object.height, 0xffff00)
end

local Bar = workspace:addChild(GUI.object(4, 6, 37, 4))
Bar.draw = function(object)
	buffer.drawSemiPixelRectangle(object.x, object.y, object.width, object.height, 0x138000)
end

local percent = workspace:addChild(GUI.label(39, 2, workspace.width, workspace.height, 0xFFFFFF, "50%"))

--------------------------------------------------------------------------------------------------------------------------------
workspace:addChild(GUI.label(3, 2, workspace.width, workspace.height, 0xFFFFFF, "Energy Storage in Station:"))

local label = workspace:addChild(GUI.label(41, 6, workspace.width, workspace.height, 0xFFFFFF, "EU/EU  "))

workspace:addChild(GUI.label(3, 8, workspace.width, workspace.height, 0xFFFFFF, "Maximum Eu Input:"))

local MEI = workspace:addChild(GUI.label(7, 10, workspace.width, workspace.height, 0x9aff9f, "MEI_value"))

workspace:addChild(GUI.label(3, 13, workspace.width, workspace.height, 0xFFFFFF, "Average EU Output:"))

local AEO = workspace:addChild(GUI.label(7, 15, workspace.width, workspace.height, 0x9aff9f, "AEO_value"))

workspace:addChild(GUI.label(3, 18, workspace.width, workspace.height, 0xFFFFFF, "Running Costs:"))

local RC = workspace:addChild(GUI.label(7, 20, workspace.width, workspace.height, 0x9aff9f, "RC_value"))

workspace:addChild(GUI.label(41, 14, workspace.width, workspace.height, 0xFFFFFF, "Generator Status:"))

local GS = workspace:addChild(GUI.label(75, 14, workspace.width, workspace.height, 0x9aff9f, "GS"))

workspace:addChild(GUI.label(41, 8, workspace.width, workspace.height, 0xFFFFFF, "Generator Control Process Status:"))

local GCS = workspace:addChild(GUI.label(75, 8, workspace.width, workspace.height, 0x9aff9f, "OFF"))

workspace:addChild(GUI.label(41, 11, workspace.width, workspace.height, 0xFFFFFF, "Generator Control processID:"))

local PIDlabel = workspace:addChild(GUI.label(75, 11, workspace.width, workspace.height, 0x9aff9f, " "))


--------------------------------------------------------------------------------------------------------------------------------

local function fresh()
    local str, str1
    perNum, percent.text, RC.text, MEI.text, AEO.text, str, str1 = GetMachineInfo()
    label.text = str.." EU/"..str1.."EU"
    Bar.width = perNum * 74 // 100
    if generator then
        GS.text = "ON   "
    else
        GS.text = "OFF  "
    end

end

local function exam()
    fresh()
    if perNum > 80 then
        stopGenerator()
    else
        startGenerator()
    end
    workspace:draw(true)
end

local function alert()
    GUI.alert("test")
end

--------------------------------------------------------------------------------------------------------------------------------
local framedButton1 = workspace:addChild(GUI.framedButton(40, 23, 40, 3, 0xFFFFFF, 0xFFFFFF, 0x880000, 0x880000, "EXIT"))
framedButton1.onTouch = function()
    if PID ~= nil then
        event.cancel(PID)
    end
    stopGenerator()
    component.gpu.setResolution(component.gpu.maxResolution())
	workspace:stop()
end

local framedButton2 = workspace:addChild(GUI.framedButton(2, 23, 38, 3, 0xFFFFFF, 0xFFFFFF, 0x880000, 0x880000, "Reflash"))
framedButton2.onTouch = function()
    fresh()
    --exam()
    --GUI.alert(perNum, percent.text.."/n", RC.text, MEI.text, AEO.text)
end

local roundedButton1 = workspace:addChild(GUI.roundedButton(40, 17, 40, 3, 0x00ff00, 0x000000, 0x007100, 0x880000, "Start generator control"))
roundedButton1.onTouch = function()
    PID = event.timer(0.5,exam,math.huge)
    --GUI.alert(eventhandle)
    PIDlabel.text = tostring(PID)
    GCS.text = "ON "
    roundedButton1.disabled = true
end

local roundedButton2 = workspace:addChild(GUI.roundedButton(40, 20, 40, 3, 0xff0000, 0x000000, 0x880000, 0x880000, "STOP generator&control"))
roundedButton2.onTouch = function()
    if PID ~= nil then
        event.cancel(PID)
        stopGenerator()
        GCS.text = "OFF "
        roundedButton1.disabled = false
        PID = nil
    else
        GUI.alert("Control system is not running! Start it first!")
    end
end

--[[
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
--]]

-- Draw application content once on screen when program starts
fresh()
workspace:draw(true)
-- Start processing events for application
workspace:start()