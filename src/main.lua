local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "[RIVAL] pixel-hub",
    SubTitle = "Private Version",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark"
})

local function Authenticate()
    local AuthWindow = Fluent:CreateWindow({
        Title = "Authentication",
        SubTitle = "Security Check",
        Size = UDim2.fromOffset(400, 250),
        Theme = "Dark"
    })

    local AuthTab = AuthWindow:AddTab({ Title = "Login", Icon = "lock" })
    
    local TokenInput = AuthTab:AddInput("Input", {
        Title = "Access Token",
        Placeholder = "Enter Token Here...",
        Callback = function(Value)
            _G.LoginToken = Value
        end
    })

    AuthTab:AddButton({
        Title = "Login",
        Callback = function()
            if _G.LoginToken == "asp1rin" then
                Fluent:Notify({ Title = "pixel-hub", Content = "Authentication Success!", Duration = 3 })
                AuthWindow:Destroy()
            else
                Fluent:Notify({ Title = "pixel-hub", Content = "Invalid Token!", Duration = 5 })
            end
        end
    })
end

local Tabs = {
    Combat = Window:AddTab({ Title = "Combat", Icon = "crosshair" }),
    Movement = Window:AddTab({ Title = "Movement", Icon = "zap" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

Tabs.Combat:AddToggle("AimbotEnable", { Title = "Enable Aimbot", Default = false })
Tabs.Combat:AddToggle("ShowFOV", { Title = "Show FOV Circle", Default = false })
Tabs.Combat:AddSlider("FOVRadius", {
    Title = "FOV Radius",
    Default = 100,
    Min = 10,
    Max = 800,
    Rounding = 1,
    Callback = function(Value)
        _G.AimbotFOV = Value
    end
})

Tabs.Movement:AddSlider("WalkSpeed", {
    Title = "Walk Speed",
    Default = 16,
    Min = 16,
    Max = 150,
    Rounding = 0,
    Callback = function(Value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end)
    end
})

Tabs.Movement:AddSlider("JumpPower", {
    Title = "Jump Height",
    Default = 50,
    Min = 50,
    Max = 300,
    Rounding = 0,
    Callback = function(Value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
        end)
    end
})

Tabs.Movement:AddToggle("FlyHack", { Title = "Enable Flight", Default = false })
Tabs.Movement:AddToggle("NoClip", { Title = "Enable No-Clip", Default = false })

Window:SelectTab(1)
Authenticate()
