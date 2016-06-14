-----------------------------------------------------------------------------------------
--
-- parallax.lua
-- Parallax Scrolling Background
--
-- Created by Jorge Tapia on 6/13/16.
-- Copyright © 2016 Parallax Scrolling Background. All rights reserved.
--
-----------------------------------------------------------------------------------------

local M = {}
M.initialized = false
M.maxSpeed = 0

local layers = display.newGroup()
local runtime = 0
 
local function getDeltaTime()
    local temp = system.getTimer()
    local dt = (temp - runtime) / (1000 / 60)
    runtime = temp
    return dt
end

-- Scrolls layers
local function scroll(layer, event)
	local dt = getDeltaTime()

	for i = 1, layers.numChildren do
		local layer = layers[i]

		if layer.x < display.contentCenterX + display.contentCenterX * 2 - layer.speed - (layer.speed * dt) then
			layer.x = layers[i].x + layer.speed * dt
		else
			layer.x = -(display.contentWidth / 2) + layer.speed * dt
		end
	end
end

local function update(event)
	scroll()
end

-- Layers is a table of image paths ordered from slowest to fastest
function M:init(layerTable, maxSpeed, speedDecrement)
	assert(type(layerTable) == "table", "Layers is not a table.")
	assert(type(maxSpeed) == "number", "Max speed is not a number.")
	assert(type(speedDecrement) == "number", "Speed decrement is not a number.")

	assert(#layerTable >= 2, "Layers must contain at least two (2) images.")
	assert(maxSpeed > 0, "Max speed must be greater than zero (0).")
	assert(maxSpeed > speedDecrement, "Max speed must be greater than speed decrement.")

	self.maxSpeed = maxSpeed
	
	for i = 1, #layerTable do
		local layer = display.newImageRect(layerTable[i], display.contentWidth, display.contentHeight)
		layer.x = display.contentCenterX
		layer.y = display.contentCenterY

		local speed = 0.0

		if i == #layerTable then
			speed = maxSpeed
		else
			speed = maxSpeed - (speedDecrement * (#layerTable - i))
		end

		if speed <= 0 then
			speed = 0.5
		end

		layer.speed = speed
		layer.zPosition = i
		layers:insert(layer)

		local layerClone = display.newImageRect(layerTable[i], display.contentWidth, display.contentHeight)
		layerClone.x = -layer.x
		layerClone.y = layer.y
		layerClone.speed = layer.speed
		layerClone.zPosition = layer.zPosition
		layers:insert(layerClone)
	end

	self.initialized = true
	print("Parallax background is initialized...")
end

function M:start()
	assert(self.initialized, "Parallax is not initialized. Are your calling the init method first?")
	Runtime:addEventListener("enterFrame", update)
end

function M:stop()

end

return M
