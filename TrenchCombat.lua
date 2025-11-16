-- Trench Combat GOD MODE
-- GitHub: https://raw.githubusercontent.com/vvvurzk-glitch/GameEnhancementSuite/main/TrenchCombatGod.lua

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

print("🎯 Trench Combat GOD MODE Loaded!")

-- GOD MODE Config
getgenv().GodMode = false
getgenv().OneShotKill = false
getgenv().InfiniteAmmo = false
getgenv().NoRecoil = false
getgenv().RapidFire = false
getgenv().SuperSpeed = false
getgenv().SuperJump = false
getgenv().FlyMode = false

-- GOD MODE: Бессмертие
function EnableGodMode()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        if getgenv().GodMode then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
        else
            humanoid.MaxHealth = 100
            humanoid.Health = 100
        end
    end
end

-- ONE SHOT KILL: Одно попадание - убийство
function OneShotKillHook()
    if not getgenv().OneShotKill then return end
    
    -- Перехватываем урон
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.MaxHealth = 1
                humanoid.Health = 1
            end
        end
    end
end

-- INFINITE AMMO: Бесконечные патроны
function InfiniteAmmo()
    if not getgenv().InfiniteAmmo then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") then
            -- Убираем расход патронов
            local config = tool:FindFirstChild("Configuration")
            if config then
                local ammo = config:FindFirstChild("Ammo")
                if ammo then
                    ammo.Value = 999
                end
            end
        end
    end
end

-- NO RECOIL: Нет отдачи
function NoRecoilHook()
    if not getgenv().NoRecoil then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") then
            -- Убираем отдачу
            local recoil = tool:FindFirstChild("Recoil")
            if recoil then
                recoil.Value = 0
            end
        end
    end
end

-- RAPID FIRE: Очень быстрая стрельба
function RapidFireHook()
    if not getgenv().RapidFire then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") then
            -- Убираем задержку между выстрелами
            local fireRate = tool:FindFirstChild("FireRate")
            if fireRate then
                fireRate.Value = 0.01
            end
        end
    end
end

-- SUPER SPEED: Сверхскорость
function SuperSpeedHook()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        if getgenv().SuperSpeed then
            humanoid.WalkSpeed = 50
        else
            humanoid.WalkSpeed = 16
        end
    end
end

-- SUPER JUMP: Супер-прыжок
function SuperJumpHook()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        if getgenv().SuperJump then
            humanoid.JumpPower = 100
        else
            humanoid.JumpPower = 50
        end
    end
end

-- FLY MODE: Режим полета
function FlyModeHook()
    if not getgenv().FlyMode then 
        local character = LocalPlayer.Character
        if character then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                local bodyVelocity = root:FindFirstChild("FlyBodyVelocity")
                if bodyVelocity then
                    bodyVelocity:Destroy()
                end
            end
        end
        return 
    end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local bodyVelocity = root:FindFirstChild("FlyBodyVelocity") or Instance.new("BodyVelocity")
    bodyVelocity.Name = "FlyBodyVelocity"
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
    bodyVelocity.Parent = root
    
    -- Управление полетом
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        bodyVelocity.Velocity = root.CFrame.LookVector * 50
    elseif UserInputService:IsKeyDown(Enum.KeyCode.S) then
        bodyVelocity.Velocity = -root.CFrame.LookVector * 50
    elseif UserInputService:IsKeyDown(Enum.KeyCode.A) then
        bodyVelocity.Velocity = -root.CFrame.RightVector * 50
    elseif UserInputService:IsKeyDown(Enum.KeyCode.D) then
        bodyVelocity.Velocity = root.CFrame.RightVector * 50
    elseif UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        bodyVelocity.Velocity = Vector3.new(0, 50, 0)
    elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
        bodyVelocity.Velocity = Vector3.new(0, -50, 0)
    else
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
end

-- AUTO WIN: Авто-победа
function AutoWin()
    if not getgenv().AutoWin then return end
    
    -- Убиваем всех врагов
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            if player.Team ~= LocalPlayer.Team then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end
        end
    end
end

-- UI для GOD MODE
function CreateGodModeUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer.PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 320, 0, 400)
    MainFrame.Position = UDim2.new(0, 10, 0, 10)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "🔥 GOD MODE - TRENCH COMBAT"
    Title.TextColor3 = Color3.fromRGB(255, 255, 0)
    Title.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.Parent = MainFrame

    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, 0, 1, -40)
    ScrollFrame.Position = UDim2.new(0, 0, 0, 40)
    ScrollFrame.ScrollBarThickness = 5
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.Parent = MainFrame

    local function CreateGodButton(text, yPos, toggleVar, description)
        local ButtonFrame = Instance.new("Frame")
        ButtonFrame.Size = UDim2.new(0, 300, 0, 50)
        ButtonFrame.Position = UDim2.new(0, 10, 0, yPos)
        ButtonFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        ButtonFrame.Parent = ScrollFrame
        
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0, 280, 0, 30)
        Button.Position = UDim2.new(0, 10, 0, 5)
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.Font = Enum.Font.GothamBold
        Button.TextSize = 14
        Button.Parent = ButtonFrame
        
        local DescLabel = Instance.new("TextLabel")
        DescLabel.Size = UDim2.new(1, 0, 0, 15)
        DescLabel.Position = UDim2.new(0, 0, 0, 32)
        DescLabel.Text = description
        DescLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        DescLabel.BackgroundTransparency = 1
        DescLabel.Font = Enum.Font.Gotham
        DescLabel.TextSize = 10
        DescLabel.Parent = ButtonFrame
        
        local function UpdateButton()
            if getgenv()[toggleVar] then
                Button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                Button.Text = "✅ " .. text
            else
                Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                Button.Text = text
            end
        end
        
        Button.MouseButton1Click:Connect(function()
            getgenv()[toggleVar] = not getgenv()[toggleVar]
            UpdateButton()
            print("🔥 " .. text .. ": " .. (getgenv()[toggleVar] and "ВКЛ" or "ВЫКЛ"))
        end)
        
        UpdateButton()
        return ButtonFrame
    end

    local yPos = 10
    CreateGodButton("🛡️ GOD MODE", yPos, "GodMode", "Бессмертие - тебя невозможно убить")
    yPos = yPos + 55
    CreateGodButton("💀 ONE SHOT KILL", yPos, "OneShotKill", "Одно попадание - убийство врага")
    yPos = yPos + 55
    CreateGodButton("🔫 INFINITE AMMO", yPos, "InfiniteAmmo", "Бесконечные патроны")
    yPos = yPos + 55
    CreateGodButton("🎯 NO RECOIL", yPos, "NoRecoil", "Нет отдачи оружия")
    yPos = yPos + 55
    CreateGodButton("⚡ RAPID FIRE", yPos, "RapidFire", "Очень быстрая стрельба")
    yPos = yPos + 55
    CreateGodButton("💨 SUPER SPEED", yPos, "SuperSpeed", "Сверхскорость передвижения")
    yPos = yPos + 55
    CreateGodButton("🦘 SUPER JUMP", yPos, "SuperJump", "Очень высокие прыжки")
    yPos = yPos + 55
    CreateGodButton("🕊️ FLY MODE", yPos, "FlyMode", "Полёт (WASD + Space/Shift)")

    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- Основные циклы
RunService.Heartbeat:Connect(function()
    EnableGodMode()
    OneShotKillHook()
    InfiniteAmmo()
    NoRecoilHook()
    RapidFireHook()
    SuperSpeedHook()
    SuperJumpHook()
    FlyModeHook()
    AutoWin()
end)

-- Создаем GOD MODE UI
CreateGodModeUI()

print("🔥 GOD MODE АКТИВИРОВАН!")
print("🛡️ Бессмертие - тебя нельзя убить")
print("💀 One Shot Kill - убиваешь с одного попадания") 
print("🔫 Infinite Ammo - бесконечные патроны")
print("🎯 No Recoil - нет отдачи")
print("⚡ Rapid Fire - супер-скорострельность")
print("💨 Super Speed - очень быстро бегаешь")
print("🦘 Super Jump - очень высоко прыгаешь")
print("🕊️ Fly Mode - летаешь по карте")
print(" ")
print("🎮 Теперь игра станет ОЧЕНЬ легкой!")
