-- Brain Rot Game Enhancement Utilities
-- Advanced Duplication System

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- UI Creation
local GameUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")

GameUI.Name = "BrainRotAdvanced"
GameUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
GameUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GameUI.ResetOnSpawn = false

MainFrame.Parent = GameUI
MainFrame.Size = UDim2.new(0, 450, 0, 550)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(0, 450, 0, 40)
Title.Text = "BRAIN ROT ADVANCED SUITE"
Title.TextColor3 = Color3.fromRGB(255, 255, 0)
Title.BackgroundColor3 = Color3.fromRGB(80, 0, 120)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

ScrollFrame.Parent = MainFrame
ScrollFrame.Size = UDim2.new(0, 450, 0, 510)
ScrollFrame.Position = UDim2.new(0, 0, 0, 40)
ScrollFrame.ScrollBarThickness = 5
ScrollFrame.BackgroundTransparency = 1

-- Button Creator
function CreateFeatureButton(name, position, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = ScrollFrame
    Button.Size = UDim2.new(0, 430, 0, 35)
    Button.Position = position
    Button.Text = name
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 12
    Button.MouseButton1Click:Connect(callback)
    return Button
end

-- ADVANCED DUPLICATION SYSTEM
function AdvancedDuplication()
    if _G.Duplicating then
        _G.Duplicating = false
        return
    end
    
    _G.Duplicating = true
    
    spawn(function()
        while _G.Duplicating and wait(0.1) do
            pcall(function()
                local character = LocalPlayer.Character
                if not character then return end
                
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if not humanoidRootPart then return end
                
                -- Метод 1: Быстрое клонирование предметов
                for _, item in pairs(workspace:GetDescendants()) do
                    if item:IsA("Tool") or item:IsA("Part") then
                        if item.Name:lower():find("brain") or 
                           item.Name:lower():find("rot") or 
                           item.Name:lower():find("coin") or 
                           item.Name:lower():find("money") or
                           item.Name:lower():find("reward") then
                           
                            -- Создание копии предмета
                            local clone = item:Clone()
                            clone.Parent = workspace
                            clone.CFrame = humanoidRootPart.CFrame + Vector3.new(
                                math.random(-5, 5),
                                math.random(0, 3),
                                math.random(-5, 5)
                            )
                        end
                    end
                end
                
                -- Метод 2: Массовое создание ресурсов
                for i = 1, 10 do
                    local newPart = Instance.new("Part")
                    newPart.Name = "DuplicatedBrainRot"
                    newPart.Size = Vector3.new(2, 2, 2)
                    newPart.BrickColor = BrickColor.new("Bright green")
                    newPart.Material = Enum.Material.Neon
                    newPart.CanCollide = false
                    newPart.Anchored = true
                    newPart.Parent = workspace
                    newPart.CFrame = humanoidRootPart.CFrame + Vector3.new(
                        math.random(-8, 8),
                        math.random(0, 5),
                        math.random(-8, 8)
                    )
                    
                    -- Добавляем свечение
                    local pointLight = Instance.new("PointLight")
                    pointLight.Brightness = 5
                    pointLight.Range = 10
                    pointLight.Color = Color3.new(0, 1, 0)
                    pointLight.Parent = newPart
                end
            end)
        end
    end)
end

-- INSTANT ITEM DUPLICATOR
function InstantItemDupe()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        -- Мгновенное создание 50 копий
        for i = 1, 50 do
            spawn(function()
                local dupePart = Instance.new("Part")
                dupePart.Name = "InstantDupe_" .. i
                dupePart.Size = Vector3.new(3, 3, 3)
                dupePart.BrickColor = BrickColor.new("Bright blue")
                dupePart.Material = Enum.Material.Neon
                dupePart.CanCollide = false
                dupePart.Anchored = true
                dupePart.Parent = workspace
                
                -- Позиционирование вокруг игрока
                local angle = (i / 50) * math.pi * 2
                local radius = 10
                dupePart.CFrame = humanoidRootPart.CFrame + Vector3.new(
                    math.cos(angle) * radius,
                    math.random(0, 8),
                    math.sin(angle) * radius
                )
                
                -- Анимация появления
                local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local tween = TweenService:Create(dupePart, tweenInfo, {Size = Vector3.new(2, 2, 2)})
                tween:Play()
            end)
        end
    end)
end

-- SMART BRAIN ROT DUPLICATOR
function SmartBrainRotDupe()
    if _G.SmartDupe then
        _G.SmartDupe = false
        return
    end
    
    _G.SmartDupe = true
    
    spawn(function()
        while _G.SmartDupe and wait(0.2) do
            pcall(function()
                -- Поиск оригинальных Brain Rot объектов
                for _, original in pairs(workspace:GetDescendants()) do
                    if original.Name:lower():find("brain") and not original:FindFirstChild("IsDupe") then
                        
                        -- Создание умной копии
                        local smartClone = original:Clone()
                        smartClone.Name = original.Name .. "_Dupe"
                        
                        -- Помечаем как дубликат
                        local marker = Instance.new("BoolValue")
                        marker.Name = "IsDupe"
                        marker.Value = true
                        marker.Parent = smartClone
                        
                        smartClone.Parent = workspace
                        
                        -- Позиционирование рядом с оригиналом
                        local offset = Vector3.new(
                            math.random(-3, 3),
                            math.random(0, 2),
                            math.random(-3, 3)
                        )
                        smartClone.CFrame = original.CFrame + offset
                    end
                end
            end)
        end
    end)
end

-- MASS CURRENCY DUPLICATOR
function MassCurrencyDupe()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        -- Создание различных типов валюты
        local currencyTypes = {
            {Name = "SuperCoin", Color = BrickColor.new("Bright yellow"), Size = Vector3.new(1, 1, 1)},
            {Name = "MegaCash", Color = BrickColor.new("Bright green"), Size = Vector3.new(1.5, 1.5, 1.5)},
            {Name = "UltraReward", Color = BrickColor.new("Bright red"), Size = Vector3.new(2, 2, 2)},
            {Name = "HyperToken", Color = BrickColor.new("Bright blue"), Size = Vector3.new(0.8, 0.8, 0.8)}
        }
        
        for i = 1, 30 do
            local currencyType = currencyTypes[math.random(1, #currencyTypes)]
            
            local currencyPart = Instance.new("Part")
            currencyPart.Name = currencyType.Name
            currencyPart.Size = currencyType.Size
            currencyPart.BrickColor = currencyType.Color
            currencyPart.Material = Enum.Material.Neon
            currencyPart.CanCollide = false
            currencyPart.Anchored = true
            currencyPart.Parent = workspace
            
            -- Вращающееся расположение
            local angle = math.rad(i * 12)
            local radius = 15
            currencyPart.CFrame = humanoidRootPart.CFrame * CFrame.new(
                math.cos(angle) * radius,
                math.random(2, 10),
                math.sin(angle) * radius
            ) * CFrame.Angles(0, angle, 0)
            
            -- Добавляем вращение
            spawn(function()
                while currencyPart.Parent do
                    wait(0.1)
                    currencyPart.CFrame = currencyPart.CFrame * CFrame.Angles(0, 0.1, 0)
                end
            end)
        end
    end)
end

-- AUTO FARM BRAIN ROT
function AutoFarmBrainRot()
    if _G.AutoFarm then
        _G.AutoFarm = false
        return
    end
    
    _G.AutoFarm = true
    
    spawn(function()
        while _G.AutoFarm and wait(0.3) do
            pcall(function()
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name:lower():find("brain") or obj.Name:lower():find("rot") then
                        if obj:IsA("Part") or obj:IsA("MeshPart") then
                            local char = LocalPlayer.Character
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                char.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                                wait(0.1)
                            end
                        end
                    end
                end
            end)
        end
    end)
end

-- PLAYER ESP
function PlayerESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESP_" .. player.Name
            highlight.Parent = player.Character
            highlight.FillColor = Color3.fromRGB(255, 50, 50)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
            highlight.FillTransparency = 0.5
        end
    end
end

-- FLY HACK
function ToggleFly()
    if _G.Flying then
        _G.Flying = false
        if _G.FlyConnection then
            _G.FlyConnection:Disconnect()
        end
        return
    end
    
    _G.Flying = true
    local char = LocalPlayer.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVelocity.Parent = root
    
    _G.FlyConnection = game:GetService("UserInputService").InputBegan:Connect(function(input)
        if not _G.Flying then return end
        
        if input.KeyCode == Enum.KeyCode.W then
            bodyVelocity.Velocity = root.CFrame.LookVector * 100
        elseif input.KeyCode == Enum.KeyCode.S then
            bodyVelocity.Velocity = -root.CFrame.LookVector * 100
        elseif input.KeyCode == Enum.KeyCode.A then
            bodyVelocity.Velocity = -root.CFrame.RightVector * 100
        elseif input.KeyCode == Enum.KeyCode.D then
            bodyVelocity.Velocity = root.CFrame.RightVector * 100
        elseif input.KeyCode == Enum.KeyCode.Space then
            bodyVelocity.Velocity = Vector3.new(0, 100, 0)
        elseif input.KeyCode == Enum.KeyCode.LeftShift then
            bodyVelocity.Velocity = Vector3.new(0, -100, 0)
        end
    end)
end

-- Создание кнопок интерфейса
local yPos = 10
CreateFeatureButton("🌀 ADVANCED DUPLICATION SYSTEM", UDim2.new(0, 10, 0, yPos), AdvancedDuplication)
yPos = yPos + 40
CreateFeatureButton("⚡ INSTANT ITEM DUPLICATOR (50x)", UDim2.new(0, 10, 0, yPos), InstantItemDupe)
yPos = yPos + 40
CreateFeatureButton("🧠 SMART BRAIN ROT DUPLICATOR", UDim2.new(0, 10, 0, yPos), SmartBrainRotDupe)
yPos = yPos + 40
CreateFeatureButton("💰 MASS CURRENCY DUPLICATOR", UDim2.new(0, 10, 0, yPos), MassCurrencyDupe)
yPos = yPos + 40
CreateFeatureButton("🎯 AUTO FARM BRAIN ROT", UDim2.new(0, 10, 0, yPos), AutoFarmBrainRot)
yPos = yPos + 40
CreateFeatureButton("👁️ PLAYER ESP", UDim2.new(0, 10, 0, yPos), PlayerESP)
yPos = yPos + 40
CreateFeatureButton("🕊️ TOGGLE FLY", UDim2.new(0, 10, 0, yPos), ToggleFly)
yPos = yPos + 40
CreateFeatureButton("⚡ SPEED x2 (32)", UDim2.new(0, 10, 0, yPos), function() 
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 32
    end
end)
yPos = yPos + 40
CreateFeatureButton("⚡ SPEED x5 (80)", UDim2.new(0, 10, 0, yPos), function() 
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 80
    end
end)
yPos = yPos + 40
CreateFeatureButton("🔄 RESET ALL SETTINGS", UDim2.new(0, 10, 0, yPos), function()
    _G.AutoFarm = false
    _G.Duplicating = false
    _G.SmartDupe = false
    _G.Flying = false
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 16
    end
end)

warn("🎮 Brain Rot Advanced Suite loaded! Use duplication features wisely!")
