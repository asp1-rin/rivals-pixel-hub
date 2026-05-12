local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/asp1-rin/rivals-pixel-hub/refs/heads/main/src/functions/aimbot.lua"))()
local Movement = loadstring(game:HttpGet("https://raw.githubusercontent.com/asp1-rin/rivals-pixel-hub/refs/heads/main/src/functions/movement.lua"))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/asp1-rin/rivals-pixel-hub/refs/heads/main/src/functions/esp.lua"))()

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
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

Tabs.Combat:AddToggle("AimbotEnable", { 
    Title = "Enable Aimbot", 
    Default = false,
    Callback = function(Value)
        Aimbot.Enabled = Value
    end
})

Tabs.Combat:AddToggle("ShowFOV", { 
    Title = "Show FOV Circle", 
    Default = false,
    Callback = function(Value)
        Aimbot.ShowFOV = Value
    end
})

Tabs.Combat:AddSlider("FOVRadius", {
    Title = "FOV Radius",
    Default = 100,
    Min = 10,
    Max = 800,
    Rounding = 1,
    Callback = function(Value)
        Aimbot.FOVRadius = Value
    end
})

Tabs.Combat:AddInput("FOVColorInput", {
    Title = "FOV Circle Color (HEX)",
    Default = "ffffff",
    Placeholder = "ffffff",
    Callback = function(Value)
        local success, color = pcall(function()
            return Color3.fromHex(Value)
        end)
        if success then
            Aimbot.FOVColor = color
        end
    end
})

Tabs.Movement:AddSlider("WalkSpeed", {
    Title = "Walk Speed",
    Default = 16,
    Min = 16,
    Max = 150,
    Rounding = 0,
    Callback = function(Value)
        Movement.WalkSpeed = Value
    end
})

Tabs.Movement:AddSlider("JumpPower", {
    Title = "Jump Height",
    Default = 50,
    Min = 50,
    Max = 300,
    Rounding = 0,
    Callback = function(Value)
        Movement.JumpPower = Value
    end
})

Tabs.Movement:AddToggle("FlyHack", { 
    Title = "Enable Flight", 
    Default = false,
    Callback = function(Value)
        Movement.FlyEnabled = Value
    end
})

Tabs.Movement:AddToggle("NoClip", { 
    Title = "Enable No-Clip", 
    Default = false,
    Callback = function(Value)
        Movement.NoClipEnabled = Value
    end
})

Tabs.Visuals:AddToggle("ESPEnable", {
    Title = "Enable ESP",
    Default = false,
    Callback = function(Value)
        ESP.Enabled = Value
    end
})

Tabs.Visuals:AddToggle("ESPBoxes", {
    Title = "Show Boxes (Highlight)",
    Default = true,
    Callback = function(Value)
        ESP.Boxes = Value
    end
})

Tabs.Visuals:AddToggle("ESPNames", {
    Title = "Show Names",
    Default = true,
    Callback = function(Value)
        ESP.Names = Value
    end
})

Tabs.Visuals:AddInput("ESPColorInput", {
    Title = "ESP Color (HEX)",
    Default = "ffffff",
    Callback = function(Value)
        local success, color = pcall(function() return Color3.fromHex(Value) end)
        if success then ESP.Color = color end
    end
})

Window:SelectTab(1)
Authenticate()
