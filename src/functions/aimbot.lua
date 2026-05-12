local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Cam = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Aimbot = {
    Enabled = false,
    ShowFOV = false,
    FOVRadius = 100,
    FOVColor = Color3.fromRGB(255, 255, 255),
    TargetPart = "Head"
}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.NumSides = 100
FOVCircle.Filled = false
FOVCircle.Transparency = 1
FOVCircle.Visible = false

local function GetClosestPlayer()
    local target = nil
    local dist = Aimbot.FOVRadius

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local screenPos, onScreen = Cam:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if onScreen then
                local mousePos = UserInputService:GetMouseLocation()
                local magnitude = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                if magnitude < dist then
                    target = v
                    dist = magnitude
                end
            end
        end
    end
    return target
end

RunService.RenderStepped:Connect(function()
    FOVCircle.Visible = Aimbot.ShowFOV
    FOVCircle.Radius = Aimbot.FOVRadius
    FOVCircle.Color = Aimbot.FOVColor
    FOVCircle.Position = UserInputService:GetMouseLocation()

    if Aimbot.Enabled then
        local target = GetClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild(Aimbot.TargetPart) then
            Cam.CFrame = CFrame.new(Cam.CFrame.Position, target.Character[Aimbot.TargetPart].Position)
        end
    end
end)

return Aimbot
