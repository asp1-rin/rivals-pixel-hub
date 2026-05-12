local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Bypass = {}

function Bypass:Initialize()
    local RawMetatable = getrawmetatable(game)
    local OldIndex = RawMetatable.__index
    local OldNewIndex = RawMetatable.__newindex
    setreadonly(RawMetatable, false)

    -- [1] 속성 읽기 가로채기 (안티치트가 값을 확인할 때)
    RawMetatable.__index = newcclosure(function(Self, Key)
        if not checkcaller() and Self and Self:IsA("Humanoid") then
            if Key == "WalkSpeed" then
                return 16
            elseif Key == "JumpPower" then
                return 50
            end
        end
        return OldIndex(Self, Key)
    end)

    -- [2] 속성 변경 감시 무력화 (안티치트가 값을 강제로 되돌릴 때)
    RawMetatable.__newindex = newcclosure(function(Self, Key, Value)
        if not checkcaller() and Self and Self:IsA("Humanoid") then
            if Key == "WalkSpeed" or Key == "JumpPower" then
                -- 게임 스크립트가 속도를 바꾸려 하면 무시하거나 허용 (상황에 따라 조절)
                return
            end
        end
        OldNewIndex(Self, Key, Value)
    end)

    setreadonly(RawMetatable, true)
end

-- -----------------------------------
-- 라이벌 전용 스크립트 삽입부분
