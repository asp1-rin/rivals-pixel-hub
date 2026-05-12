local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local ESP = {
    Enabled = false,
    Boxes = true,
    Names = true,
    Tracer = false,
    Color = Color3.fromRGB(255, 255, 255)
}

local function CreateESP(player)
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.FillColor = ESP.Color
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_NameTag"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    
    local label = Instance.new("TextLabel", billboard)
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = player.Name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 0
    label.TextScaled = false
    label.TextSize = 14

    local function Update()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            highlight.Parent = player.Character
            billboard.Parent = player.Character:FindFirstChild("Head")
            
            highlight.Enabled = ESP.Enabled and ESP.Boxes
            billboard.Enabled = ESP.Enabled and ESP.Names
            highlight.FillColor = ESP.Color
        else
            highlight.Parent = nil
            billboard.Parent = nil
        end
    end

    RunService.RenderStepped:Connect(Update)
end

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        CreateESP(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        CreateESP(player)
    end
end)

return ESP
