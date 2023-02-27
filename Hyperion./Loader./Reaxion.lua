local module = {}

-- Services


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Functions

function initialize()
	local container = Instance.new("Folder", ReplicatedStorage)
	container.Name = "App"
	
end



function newApp()
	local App = Instance.new("ScreenGui")
	App.Name = "App"
	
	return App	
end



local APIs = {}

APIs.Components = {
	["input"] = function()
		local newTextBox = Instance.new("TextBox")
		return newTextBox
	end,
	["button"] = function()
		local newTextBox = Instance.new("TextButton")
		return newTextBox
	end,
	["label"] = function()
		local newTextBox = Instance.new("TextLabel")
		return newTextBox
	end,
	["panel"] = function()
		local newTextBox = Instance.new("Frame")
		return newTextBox
	end,
	["scrollablepanel"] = function()
		local newTextBox = Instance.new("ScrollingFrame")
		return newTextBox
	end,
	["box"] = function()
		local newTextBox = Instance.new("TextBox")
		return newTextBox
	end,
	["container"] = function()
		return Instance.new("Folder")
	end,
	
}


function module.CreateElement(item, dir, event)
	local controller = {}
	
	controller.Component = item.component

	
	for index, value in pairs(dir) do 
		controller.Component[index] = value
	end
	
	
	if item.component.Name == "TextBox" then 
		controller.Component.Changed:Connect(function()
			event["OnChanged"]()
		end)
	end
	
	if item.component.Name == "TextButton" then 
		controller.Component.MouseButton1Click:Connect(function()
			event["OnClick"]()
		end)
	end
	
	
	return
	
	
end

-- Main Functions
function module.Import(item)
	
	local controller = {}
	controller.Import = APIs.Components[item.import] or ""
	controller.App = item.App or nil
	if controller.App == controller.App then 
	else 
		controller.App = newApp()
	end
	
	if controller.Import then 
		return controller.Import
	end
	
end

function module.Decorate(item, property)
	local controller = {}
	controller.item = item
	controller.BackgroundColor3 = property.BackgroundColor3 or Color3.fromRGB(30,30,30)
	controller.TextColor3 = property.TextColor3 or Color3.fromRGB(255,255,255)
	controller.BorderPixel = property.BorderPixel or 0
	controller.TextScaled = property.TextScaled or false

	controller.Border = property.Border or false
	controller.BorderRadius = property.BorderRadius or 10

	if controller.item then 
		controller.item.BackgroundColor3 = controller.BackgroundColor3
		if controller.ClassName == "TextBox" or controller.ClassName == "Textlabel" or controller.ClassName == "TextButton" then 
			controller.item.TextColor3 = controller.BackgroundColor3 
		end

		controller.item.BorderSizePixel = controller.BorderPixel

		if controller.ClassName == "TextBox" or controller.ClassName == "Textlabel" or controller.ClassName == "TextButton" then 
			controller.item.TextScaled = controller.TextScaled
		end



		if controller.Border == true then 
			local UICorner = Instance.new("UICorner", controller.item)
			UICorner.CornerRadius = UDim.new(0, controller.BorderRadius)
		end



	end


	return controller.item
end

-- Locate

function module:Find(app, item)
	for i,v in pairs(app:GetDescendants()) do 
		if v.Name == item then 
			return v
		end
	end
end

-- Rendering and debug


function module.Remove(item, timer)
	task.wait(timer)
	item:Destroy()
end




function module.Profiler(item)
	local controller = {}

	controller.id = item.id or 0
	controller.frames = 0
	local function render()
		RunService.RenderStepped:Connect(function()
			controller.frames = controller.frames + 1
		end)
		
		coroutine.wrap(function()
			while wait(1) do 

				print(controller.frames)
				controller.frames = 0
			end
		end)()
		
	end
	
render()

	
end

return module
