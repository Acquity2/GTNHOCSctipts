local GUI = require("GUI")
local image = require("Image")
local screen = require("Screen")
local component = require("Component")

local GTMachine = component.gt_machine

local workspace = GUI.workspace()
workspace:addChild(GUI.panel(1, 1, workspace.width, workspace.height, 0x2D2D2D))

local framedButton = workspace:addChild(GUI.framedButton(40, 27, 40, 3, 0xFFFFFF, 0xFFFFFF, 0x880000, 0x880000, "EXIT"))
framedButton.onTouch = function()
	workspace:stop()
end

workspace:draw()
GUI.alert(GTMachine.getSensorInformation())
workspace:start()