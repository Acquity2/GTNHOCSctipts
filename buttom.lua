local GUI = require("GUI")
local image = require("Image")
local screen = require("Screen")
--------------------------------------------------------------------------------

local workspace = GUI.workspace()
workspace:addChild(GUI.panel(1, 1, workspace.width, workspace.height, 0x2D2D2D))

--[[
-- Create and add template object to workspace
local object2 = workspace:addChild(GUI.object(2, 1, 152, 6))
-- Create own :draw() method and make it render green rectangle
object2.draw = function(object)
	screen.drawRectangle(object.x, object.y, object.width, object.height, 0x012368, 0x0, " ")
end
--]]

-- Create and add template object to workspace
local object1 = workspace:addChild(GUI.object(2, 2, 152, 6))
-- Create own :draw() method and make it render green rectangle
object1.draw = function(object)
	screen.drawSemiPixelRectangle(object.x, object.y, object.width, object.height, 0x181818)
end


-- Create and add template object to workspace
local object1 = workspace:addChild(GUI.object(3, 3, 150, 4))
-- Create own :draw() method and make it render green rectangle
object1.draw = function(object)
	screen.drawSemiPixelRectangle(object.x, object.y, object.width, object.height, 0x33FF80)
end





-- Add a regular button
local regularButton = workspace:addChild(GUI.button(2, 2, 30, 3, 0xFFFFFF, 0x555555, 0x880000, 0xFFFFFF, "Regular button"))
regularButton.onTouch = function()
	regularButton.text="pressed"
	object1.width = 50
end

-- Add a regular button with disabled state
local disabledButton = workspace:addChild(GUI.button(2, 6, 30, 3, 0xFFFFFF, 0x555555, 0x880000, 0xFFFFFF, "Disabled button"))
disabledButton.disabled = true

-- Add a regular button with switchMode state
local switchButton = workspace:addChild(GUI.button(2, 10, 30, 3, 0xFFFFFF, 0x555555, 0x880000, 0xFFFFFF, "Switch button"))
switchButton.switchMode = true
switchButton.onTouch = function()
	GUI.alert("Switch button was pressed")
end

-- Add a regular button with disabled animation
local notAnimatedButton = workspace:addChild(GUI.button(2, 14, 30, 3, 0xFFFFFF, 0x555555, 0x880000, 0xFFFFFF, "Not animated button"))
notAnimatedButton.animated = false
notAnimatedButton.onTouch = function()
	GUI.alert("Not animated button was pressed")
end

-- Add a rounded button
workspace:addChild(GUI.roundedButton(2, 18, 30, 3, 0xFFFFFF, 0x555555, 0x880000, 0xFFFFFF, "Rounded button")).onTouch = function()
	GUI.alert("Rounded button was pressed")
	local wieqhj = component.isAvailable("redstone")
	local wdfqwe = component.isAvailable("gt_machine")
	if wieqhj and wdfqwe then
		fqatrue = "true"
	else
		fqatrue = "false"
	end
	GUI.alert("redstone and gtmachine: "..fqatrue)
end

-- Add a framed button
workspace:addChild(GUI.framedButton(2, 22, 30, 3, 0xFFFFFF, 0xFFFFFF, 0x880000, 0x880000, "EXIT")).onTouch = function()
	GUI.alert("Framed button was pressed")
	workspace:stop()
end

--------------------------------------------------------------------------------


workspace:draw()
workspace:start()