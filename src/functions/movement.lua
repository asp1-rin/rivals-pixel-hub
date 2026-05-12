local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Movement = {
    WalkSpeed = 16,
    JumpPower = 50,
    FlyEnabled = false,
    NoClipEnabled = false,
    FlySpeed = 50
}

-- [[ 메인 루프: NoClip 및 상태 유지 ]]
RunService.Stepped:Connect(function()
    if LocalPlayer.Character then
        -- NoClip 로직
        if Movement.NoClipEnabled then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end

        -- 실시간 스피드/점프 적용 (리스폰 시 초기화 방지)
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = Movement.WalkSpeed
            humanoid.JumpPower = Movement.JumpPower
            humanoid.UseJumpPower = true
        end
    end
end)

-- [[ 비행(Fly) 로직 ]]
local BodyGyro, BodyVelocity
RunService.RenderStepped:Connect(function()
    if Movement.FlyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local Root = LocalPlayer.Character.HumanoidRootPart
        
        if not Root:FindFirstChild("FlyGyro") then
            BodyGyro = Instance.new("BodyGyro", Root)
            BodyGyro.Name = "FlyGyro"
            BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            BodyGyro.P = 9e4
            
            BodyVelocity = Instance.new("BodyVelocity", Root)
            BodyVelocity.Name = "FlyVelocity"
            BodyVelocity.velocity = Vector3.new(0, 0, 0)
            BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
        end
        
        BodyGyro.cframe = workspace.CurrentCamera.CFrame
        local Direction = Vector3.new(0, 0, 0)
        local UIS = game:GetService("UserInputService")
        
        if UIS:IsKeyDown(Enum.KeyCode.W) then Direction = Direction + workspace.CurrentCamera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then Direction = Direction - workspace.CurrentCamera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then Direction = Direction - workspace.CurrentCamera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then Direction = Direction + workspace.CurrentCamera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then Direction = Direction + Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then Direction = Direction - Vector3.new(0, 1, 0) end
        
        BodyVelocity.velocity = Direction * Movement.FlySpeed
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local Root = LocalPlayer.Character.HumanoidRootPart
            if Root:FindFirstChild("FlyGyro") then Root.FlyGyro:Destroy() end
            if Root:FindFirstChild("FlyVelocity") then Root.FlyVelocity:Destroy() end
        end
    end
end)

return Movement
