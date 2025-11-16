-- Trench Combat Simple God Mode
-- GitHub: https://raw.githubusercontent.com/vvvurzk-glitch/GameEnhancementSuite/main/TrenchCombatSimpleGod.lua

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

print("🎯 Trench Combat Simple God Mode Loaded!")

-- Только самые важные функции
getgenv().GodMode = false
getgenv().OneShot = false
getgenv().ESP = false

-- ПРОСТОЙ God Mode
function SimpleGodMode()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    if getgenv().GodMode then
        -- Бессмертие
        humanoid.MaxHealth = 10000
        humanoid.Health = 10000
        
        -- Защита от пуль
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Transparency = 0.3
                part.BrickColor = BrickColor.new("Bright green")
            end
        end
    else
        humanoid.MaxHealth = 100
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
                part.Transparency = 0
                part.BrickColor = BrickColor.new("Medium stone grey")
            end
        end
    end
end

-- ПРОСТОЙ One Shot
function SimpleOneShot()
    if not getgenv().OneShot then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                humanoid.MaxHealth = 1
                humanoid.Health = 1
            end
        end
    end
end

-- ПРОСТОЙ ESP
function SimpleESP()
    if not getgenv().ESP then 
        -- Очистка ESP
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChild("SimpleESP")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
        return 
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            
            if humanoid and humanoid.Health > 0 then
                local highlight = character:FindFirstChild("SimpleESP")
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "SimpleESP"
                    highlight.Adornee = character
                    highlight.FillTransparency = 0.8
                    highlight.OutlineTransparency = 0.2
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = character
                end
                
                -- Красный для врагов, зеленый для своих
                if player.Team and LocalPlayer.Team then
                    if player.Team == LocalPlayer.Team then
                        highlight.FillColor = Color3.fromRGB(0, 255, 0)
                        highlight.OutlineColor = Color3.fromRGB(0, 200, 0)
                    else
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(200, 0, 0)
                    end
                else
                    highlight.FillColor = Color3.fromRGB(255, 165, 0)
                    highlight.OutlineColor = Color3.fromRGB(200, 120, 0)
                end
            else
                local highlight = character:FindFirstChild("SimpleESP")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end

-- ПРОСТОЙ UI
function CreateSimpleUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer.PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 200, 0, 160)
    MainFrame.Position = UDim2.new(0, 10, 0, 10)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Text = "GOD MODE"
    Title.TextColor3 = Color3.fromRGB(255, 255, 0)
    Title.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    -- Большие понятные кнопки
    local function CreateBigButton(text, yPos, toggleVar)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0, 180, 0, 35)
        Button.Position = UDim2.new(0, 10, 0, yPos)
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.Font = Enum.Font.GothamBold
        Button.TextSize = 14
        Button.Parent = MainFrame
        
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
        end)
        
        UpdateButton()
        return Button
    end

    local yPos = 40
    CreateBigButton("🛡️ GOD", yPos, "GodMode")
    yPos = yPos + 40
    CreateBigButton("💀 1-SHOT", yPos, "OneShot")
    yPos = yPos + 40
    CreateBigButton("👁️ ESP", yPos, "ESP")
end

-- Основные циклы
RunService.Heartbeat:Connect(function()
    SimpleGodMode()
    SimpleOneShot()
end)

RunService.Stepped:Connect(function()
    SimpleESP()
end)

-- Создаем UI
CreateSimpleUI()

print("✅ Simple God Mode активирован!")
print("🛡️ GOD MODE - бессмертие")
print("💀 1-SHOT - убиваешь с одного выстрела") 
print("👁️ ESP - видишь врагов")
print(" ")
print("🎮 Тебя невозможно убить!")
