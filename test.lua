local component = require("component")
local gpu = component.gpu
gpu.setResolution(80,25)
local gui = require("gui")
local event = require("event")

gui.checkVersion(2,5)

local prgName = "test"
local version = "v1.0"

-- Begin: Callbacks
local function hprogress_0_callback(guiID, hProgressID)
   -- Your code here
end

local function button_0_callback(guiID, buttonID)
   -- Your code here
end

local function exitButtonCallback(guiID, id)
   local result = gui.getYesNo("", "Do you really want to exit?", "")
   if result == true then
      gui.exit()
   end
   gui.displayGui(mainGui)
   refresh()
end
-- End: Callbacks

-- Begin: Menu definitions
mainGui = gui.newGui(1, 2, 79, 23, true)
label_0 = gui.newLabel(mainGui, 1, 2, "EU in storage:", 0xc0c0c0, 0x0, 7)
hprogress_0 = gui.newProgress(mainGui, 4, 4, 68, 10, 1, hprogress_0_callback, true)
label_1 = gui.newLabel(mainGui, 1, 6, "Generator In Function:", 0xc0c0c0, 0x0, 7)
label_2 = gui.newLabel(mainGui, 4, 8, "label_2", 0xc0c0c0, 0x0, 7)
button_0 = gui.newButton(mainGui, 4, 10, "Stop Generator", button_0_callback)
exitButton = gui.newButton(mainGui, 73, 23, "exit", exitButtonCallback)
-- End: Menu definitions

gui.clearScreen()
gui.setTop("Monitor")
gui.setBottom("Made with Visual Gui v0.1a and Gui library v2.5")

-- Main loop
while true do
   gui.runGui(mainGui)
   gui.setValue()
end


