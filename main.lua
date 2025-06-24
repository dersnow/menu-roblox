local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESPEnabled = false
local AimBotEnabled = false
local WallHackEnabled = false
local ESPDistance = 500
local AimDistance = 300
local AimStrength = 0.25
local TeamPlayers = {}
local ESPDrawings = {}

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "SnowMenu"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 340)
frame.Position = UDim2.new(0, 20, 0, 140)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1, -60, 0, 30)
header.Position = UDim2.new(0, 0, 0, 0)
header.Text = "🎯 SNOW - Full System"
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
header.TextColor3 = Color3.fromRGB(0, 170, 255)
header.Font = Enum.Font.GothamBold
header.TextSize = 16
header.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14

local minimizeBtn = Instance.new("TextButton", frame)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -60, 0, 0)
minimizeBtn.Text = "-"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 14

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
	for _, d in pairs(ESPDrawings) do d:Remove() end
end)

minimizeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	local bar = Instance.new("TextButton", gui)
	bar.Size = UDim2.new(0, 100, 0, 30)
	bar.Position = UDim2.new(0, 20, 0, 140)
	bar.Text = "🔧 Snow Menu"
	bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	bar.TextColor3 = Color3.new(1, 1, 1)
	bar.Font = Enum.Font.Gotham
	bar.TextSize = 14
	bar.MouseButton1Click:Connect(function()
		frame.Visible = true
		bar:Destroy()
	end)
end)

local function createButton(txt, y)
	local b = Instance.new("TextButton", frame)
	b.Size = UDim2.new(1, -40, 0, 30)
	b.Position = UDim2.new(0, 20, 0, y)
	b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	b.TextSize = 14
	b.Font = Enum.Font.Gotham
	b.Text = txt
	return b
end

local btnESP = createButton("ESP", 40)
local btnAimbot = createButton("Aimbot", 80)
local btnWallhack = createButton("WallHack", 120)
local btnPlayers = createButton("Team Players", 160)

local distanceInput = Instance.new("TextBox", frame)
distanceInput.Size = UDim2.new(1, -40, 0, 30)
distanceInput.Position = UDim2.new(0, 20, 0, 200)
distanceInput.PlaceholderText = "ESP Distance"
distanceInput.Text = tostring(ESPDistance)
distanceInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
distanceInput.TextColor3 = Color3.new(1, 1, 1)
distanceInput.TextSize = 14
distanceInput.Font = Enum.Font.Gotham

local aimRangeInput = Instance.new("TextBox", frame)
aimRangeInput.Size = UDim2.new(1, -40, 0, 30)
aimRangeInput.Position = UDim2.new(0, 20, 0, 240)
aimRangeInput.PlaceholderText = "Aim Distance"
aimRangeInput.Text = tostring(AimDistance)
aimRangeInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
aimRangeInput.TextColor3 = Color3.new(1, 1, 1)
aimRangeInput.TextSize = 14
aimRangeInput.Font = Enum.Font.Gotham

local aimStrengthInput = Instance.new("TextBox", frame)
aimStrengthInput.Size = UDim2.new(1, -40, 0, 30)
aimStrengthInput.Position = UDim2.new(0, 20, 0, 280)
aimStrengthInput.PlaceholderText = "Aim Strength (0.1 - 1)"
aimStrengthInput.Text = tostring(AimStrength)
aimStrengthInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
aimStrengthInput.TextColor3 = Color3.new(1, 1, 1)
aimStrengthInput.TextSize = 14
aimStrengthInput.Font = Enum.Font.Gotham

local playerList = Instance.new("ScrollingFrame", gui)
playerList.Size = UDim2.new(0, 200, 0, 220)
playerList.Position = UDim2.new(0, 290, 0, 140)
playerList.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
playerList.BorderSizePixel = 0
playerList.Visible = false
playerList.CanvasSize = UDim2.new(0, 0, 1, 0)

btnESP.MouseButton1Click:Connect(function()
	ESPEnabled = not ESPEnabled
	btnESP.Text = "ESP: " .. (ESPEnabled and "ON ✅" or "OFF ❌")
end)

btnAimbot.MouseButton1Click:Connect(function()
	AimBotEnabled = not AimBotEnabled
	btnAimbot.Text = "Aimbot: " .. (AimBotEnabled and "ON ✅" or "OFF ❌")
end)

btnWallhack.MouseButton1Click:Connect(function()
	WallHackEnabled = not WallHackEnabled
	btnWallhack.Text = "WallHack: " .. (WallHackEnabled and "ON ✅" or "OFF ❌")
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
			obj.LocalTransparencyModifier = WallHackEnabled and 0.6 or 0
		end
	end
end)

btnPlayers.MouseButton1Click:Connect(function()
	playerList.Visible = not playerList.Visible
	playerList:ClearAllChildren()
	if playerList.Visible then
		local y = 5
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= LocalPlayer then
				local b = Instance.new("TextButton", playerList)
				b.Size = UDim2.new(1, -10, 0, 25)
				b.Position = UDim2.new(0, 5, 0, y)
				b.Text = p.Name .. " (Add to team)"
				b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				b.TextColor3 = Color3.new(1, 1, 1)
				b.Font = Enum.Font.Gotham
				b.TextSize = 13

				b.MouseButton1Click:Connect(function()
					TeamPlayers[p.Name] = true
					b.Text = p.Name .. " ✅ Added"
				end)

				y = y + 28
			end
		end
		playerList.CanvasSize = UDim2.new(0, 0, 0, y + 5)
	end
end)

distanceInput.FocusLost:Connect(function()
	local val = tonumber(distanceInput.Text)
	if val then ESPDistance = val end
end)

aimRangeInput.FocusLost:Connect(function()
	local val = tonumber(aimRangeInput.Text)
	if val then AimDistance = val end
end)

aimStrengthInput.FocusLost:Connect(function()
	local val = tonumber(aimStrengthInput.Text)
	if val and val >= 0.1 and val <= 1 then AimStrength = val end
end)

RunService.RenderStepped:Connect(function()
	for _, d in pairs(ESPDrawings) do d.Visible = false end
	if not ESPEnabled then return end

	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and not TeamPlayers[p.Name] then
			local char = p.Character
			local pos, onScreen = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
			local dist = (Camera.CFrame.Position - char.HumanoidRootPart.Position).Magnitude
			if onScreen and dist <= ESPDistance then
				local tag = ESPDrawings[p.Name]
				if not tag then
					tag = Drawing.new("Text")
					tag.Size = 14
					tag.Center = true
					tag.Outline = true
					tag.Font = 2
					tag.Color = Color3.fromRGB(0, 255, 170)
					ESPDrawings[p.Name] = tag
				end
				tag.Text = p.Name .. " [" .. math.floor(dist) .. "m]"
				tag.Position = Vector2.new(pos.X, pos.Y - 20)
				tag.Visible = true
			end
		end
	end

	if AimBotEnabled then
		local closest, shortest = nil, AimDistance
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character and not TeamPlayers[p.Name] then
				local hrp = p.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
					if onScreen then
						local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
						if dist < shortest then
							closest = hrp
							shortest = dist
						end
					end
				end
			end
		end
		if closest then
			local dir = (closest.Position - Camera.CFrame.Position).Unit
			local newLook = Camera.CFrame.Position + dir * AimStrength
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, newLook)
		end
	end
end)
