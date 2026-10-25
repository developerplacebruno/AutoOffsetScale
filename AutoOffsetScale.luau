--!strict
--[[
The purpose of this script is to make the offset responsive, specifically for interfaces that rely on AutomaticSize—a 
feature commonly used in interfaces that change size based on the text size, such as a tooltip. 
If your interface does not use AutomaticSize, choose to use `scale` instead of `offset`.
]]

local CollectionService = game:GetService("CollectionService")
local camera = workspace.CurrentCamera

const TAG_NAME = "AutoOffsetScale"

local AutoOffsetScale = {}

local function updateScale(object)
	local viewportSize = camera.ViewportSize

	local uiScale = object:FindFirstChild("UIScale") or Instance.new("UIScale", object)
	uiScale.Scale = (viewportSize.X / 1920 + viewportSize.Y / 1080) / 2
end

local function updateAll()
	for _, object in pairs(CollectionService:GetTagged(TAG_NAME)) do
		updateScale(object)
	end
end

function AutoOffsetScale:init()
	updateAll()
	camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateAll)

	CollectionService:GetInstanceAddedSignal(TAG_NAME):Connect(function(object)
		updateScale(object)
	end)
end

return AutoOffsetScale
