local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SnowMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local frame = Instance.new("Frame", ScreenGui)
frame.Size = UDim2.new(0, 320, 0, 140)
frame.Position = UDim2.new(0.35, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true
frame.AnchorPoint = Vector2.new(0, 0)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
title.Text = "SNOW MENU"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(200, 200, 200)
title.BorderSizePixel = 0

local minimizeBtn = Instance.new("TextButton", frame)
minimizeBtn.Size = UDim2.new(0, 26, 0, 26)
minimizeBtn.Position = UDim2.new(1, -32, 0, 2)
minimizeBtn.Text = "–"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 24
minimizeBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
minimizeBtn.AutoButtonColor = true
minimizeBtn.BorderSizePixel = 0

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -60, 0, 2)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 24
closeBtn.TextColor3 = Color3.fromRGB(220, 100, 100)
closeBtn.BackgroundColor3 = Color3.fromRGB(70, 30, 30)
closeBtn.AutoButtonColor = true
closeBtn.BorderSizePixel = 0

local infoLabel = Instance.new("TextLabel", frame)
infoLabel.Size = UDim2.new(1, -20, 0, 22)
infoLabel.Position = UDim2.new(0, 10, 0, 40)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 16
infoLabel.Text = "FPS Optimization Levels"

local buttonsFrame = Instance.new("Frame", frame)
buttonsFrame.Size = UDim2.new(1, -20, 0, 45)
buttonsFrame.Position = UDim2.new(0, 10, 0, 70)
buttonsFrame.BackgroundTransparency = 1
buttonsFrame.BorderSizePixel = 0

local function createOptionButton(text)
	local btn = Instance.new("TextButton", buttonsFrame)
	btn.Size = UDim2.new(0, 90, 0, 35)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.fromRGB(230, 230, 230)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Text = text
	btn.AutoButtonColor = true
	btn.BorderSizePixel = 0
	return btn
end

local ultraLowBtn = createOptionButton("Ultra Low")
ultraLowBtn.Position = UDim2.new(0, 0, 0, 5)
local highBtn = createOptionButton("High")
highBtn.Position = UDim2.new(0, 110, 0, 5)
local lowBtn = createOptionButton("Low")
lowBtn.Position = UDim2.new(0, 220, 0, 5)

local currentSetting = nil

local function resetWorkspace()
	Lighting.GlobalShadows = true
	Lighting.FogEnd = 1000
	Lighting.Brightness = 2
	Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.CastShadow = true
			obj.Transparency = 0
			obj.Material = Enum.Material.Plastic
		end
		if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
			obj.Enabled = true
		end
	end
end

local function applyUltraLow()
	Lighting.GlobalShadows = false
	Lighting.FogEnd = 100000
	Lighting.Brightness = 1
	Lighting.OutdoorAmbient = Color3.new(0,0,0)
	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Material = Enum.Material.Plastic
			obj.CastShadow = false
			obj.Transparency = 0.6
		end
		if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
			obj.Enabled = false
		end
	end
end

local function applyHigh()
	Lighting.GlobalShadows = false
	Lighting.FogEnd = 3000
	Lighting.Brightness = 1.5
	Lighting.OutdoorAmbient = Color3.fromRGB(40,40,40)
	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Material = Enum.Material.Plastic
			obj.CastShadow = false
			obj.Transparency = 0.3
		end
		if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
			obj.Enabled = false
		end
	end
end

local function applyLow()
	Lighting.GlobalShadows = true
	Lighting.FogEnd = 1000
	Lighting.Brightness = 2
	Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Material = Enum.Material.Plastic
			obj.CastShadow = true
			obj.Transparency = 0
		end
		if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
			obj.Enabled = true
		end
	end
end

local function setSetting(setting)
	currentSetting = setting
	if setting == "UltraLow" then
		applyUltraLow()
		ultraLowBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
		highBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		lowBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	elseif setting == "High" then
		applyHigh()
		ultraLowBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		highBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
		lowBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	elseif setting == "Low" then
		applyLow()
		ultraLowBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		highBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		lowBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
	else
		resetWorkspace()
		ultraLowBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		highBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		lowBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end
end

ultraLowBtn.MouseButton1Click:Connect(function() setSetting("UltraLow") end)
highBtn.MouseButton1Click:Connect(function() setSetting("High") end)
lowBtn.MouseButton1Click:Connect(function() setSetting("Low") end)

-- Minimize behavior with small FPS/Ping display
local minimized = false

local fpsPingLabel = Instance.new("TextLabel", ScreenGui)
fpsPingLabel.AnchorPoint = Vector2.new(1, 0)
fpsPingLabel.Position = UDim2.new(1, -10, 0, 10)
fpsPingLabel.Size = UDim2.new(0, 120, 0, 25)
fpsPingLabel.BackgroundTransparency = 0.85
fpsPingLabel.BackgroundColor3 = Color3.fromRGB(15, 40, 90)
fpsPingLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
fpsPingLabel.Font = Enum.Font.GothamBold
fpsPingLabel.TextSize = 16
fpsPingLabel.Text = ""
fpsPingLabel.Visible = false
fpsPingLabel.BorderSizePixel = 0
fpsPingLabel.TextStrokeTransparency = 0.7

local function getPing()
	local ping = 0
	pcall(function()
		ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
	end)
	return math.floor(ping)
end

local fps = 0
local lastTime = tick()
local frameCount = 0
RunService.Heartbeat:Connect(function()
	frameCount += 1
	local currentTime = tick()
	if currentTime - lastTime >= 1 then
		fps = frameCount
		frameCount = 0
		lastTime = currentTime
	end
	if minimized then
		fpsPingLabel.Text = "FPS: "..fps.." | Ping: "..getPing().." ms"
	end
end)

minimizeBtn.MouseButton1Click:Connect(function()
	if not minimized then
		minimized = true
		frame.Size = UDim2.new(0, 130, 0, 30)
		for _, child in ipairs(frame:GetChildren()) do
			if child ~= title and child ~= minimizeBtn then
				child.Visible = false
			end
		end
		title.Text = "Snow"
		minimizeBtn.Position = UDim2.new(1, -38, 0, 1)
		closeBtn.Visible = false
		fpsPingLabel.Visible = true
		fpsPingLabel.Position = UDim2.new(1, 150, 0, 10)
		fpsPingLabel:TweenPosition(UDim2.new(1, -10, 0, 10), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.3, true)
	else
		minimized = false
		frame.Size = UDim2.new(0, 320, 0, 140)
		for _, child in ipairs(frame:GetChildren()) do
			child.Visible = true
		end
		title.Text = "SNOW MENU"
		minimizeBtn.Position = UDim2.new(1, -32, 0, 2)
		closeBtn.Visible = true
		fpsPingLabel.Visible = false
		setSetting(currentSetting or "Low")
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
	fpsPingLabel:Destroy()
end)

-- Animate menu open
frame.Position = UDim2.new(0.35, 0, 0.35, -100)
frame.BackgroundTransparency = 1
title.TextTransparency = 1
minimizeBtn.TextTransparency = 1
closeBtn.TextTransparency = 1
infoLabel.TextTransparency = 1
ultraLowBtn.TextTransparency = 1
highBtn.TextTransparency = 1
lowBtn.TextTransparency = 1
ultraLowBtn.BackgroundTransparency = 1
highBtn.BackgroundTransparency = 1
lowBtn.BackgroundTransparency = 1

local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

TweenService:Create(frame, tweenInfo, {Position = UDim2.new(0.35, 0, 0.35, 0), BackgroundTransparency = 0}):Play()
TweenService:Create(title, tweenInfo, {TextTransparency = 0}):Play()
TweenService:Create(minimizeBtn, tweenInfo, {TextTransparency = 0}):Play()
TweenService:Create(closeBtn, tweenInfo, {TextTransparency = 0}):Play()
TweenService:Create(infoLabel, tweenInfo, {TextTransparency = 0}):Play()
TweenService:Create(ultraLowBtn, tweenInfo, {TextTransparency = 0, BackgroundTransparency = 0}):Play()
TweenService:Create(highBtn, tweenInfo, {TextTransparency = 0, BackgroundTransparency = 0}):Play()
TweenService:Create(lowBtn, tweenInfo, {TextTransparency = 0, BackgroundTransparency = 0}):Play()

-- Initialize default setting
setSetting("Low")
