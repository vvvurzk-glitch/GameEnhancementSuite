-- Trench Combat ESP + God Mode FIXED
-- GitHub: https://raw.githubusercontent.com/vvvurzk-glitch/GameEnhancementSuite/main/TrenchCombatFull.lua

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

print("🎯 Trench Combat ESP + God Mode Loaded!")

-- Config
getgenv().ESPEnabled = true
getgenv().ShowNames = true
getgenv().ShowDistance = true
getgenv().TeamColor = true

getgenv().GodMode = false
getgenv().OneShotKill = false
getgenv().InfiniteAmmo = false
getgenv().SuperSpeed = false

-- ESP Objects storage
local ESPObjects = {}

-- Stable ESP Function
function UpdateESP()
    -- Clean up dead players
    for player, espData in pairs(ESPObjects) do
        if not player or not player.Parent or not player.Character then
            if espData.Highlight then espData.Highlight:Destroy() end
            if espData.Billboard then espData.Billboard:Destroy() end
            ESPObjects[player] = nil
        end
    end
    
    if not getgenv().ESPEnabled then
        for _, espData in pairs(ESPObjects) do
            if espData.Highlight then espData.Highlight.Enabled = false end
            if espData.Billboard then espData.Billboard.Enabled = false end
        end
        return
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if not player.Character then continue end
        
        local character = player.Character
        local humanoid = character:FindFirstChild("Humanoid")
        local head = character:FindFirstChild("Head")
        
        if not humanoid or humanoid.Health <= 0 or not head then
            if ESPObjects[player] then
                if ESPObjects[player].Highlight then ESPObjects[player].Highlight.Enabled = false end
                if ESPObjects[player].Billboard then ESPObjects[player].Billboard.Enabled = false end
            end
            continue
        end

        -- Get color based on team
        local espColor
        if getgenv().TeamColor and player.Team and LocalPlayer.Team then
            espColor = player.Team == LocalPlayer.Team and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        else
            espColor = Color3.fromRGB(255, 165, 0)
        end

        -- Create ESP if not exists
        if not ESPObjects[player] then
            ESPObjects[player] = {}
            
            -- Highlight
            ESPObjects[player].Highlight = Instance.new("Highlight")
            ESPObjects[player].Highlight.Name = "ESP"
            ESPObjects[player].Highlight.FillColor = espColor
            ESPObjects[player].Highlight.OutlineColor = espColor
            ESPObjects[player].Highlight.FillTransparency = 0.8
            ESPObjects[player].Highlight.OutlineTransparency = 0.3
            ESPObjects[player].Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            
            -- Billboard
            ESPObjects[player].Billboard = Instance.new("BillboardGui")
            ESPObjects[player].Billboard.Name = "ESPInfo"
            ESPObjects[player].Billboard.Size = UDim2.new(0, 200, 0, 60)
            ESPObjects[player].Billboard.StudsOffset = Vector3.new(0, 3, 0)
            ESPObjects[player].Billboard.AlwaysOnTop = true
            
            ESPObjects[player].Label = Instance.new("TextLabel")
            ESPObjects[player].Label.Name = "ESPLabel"
            ESPObjects[player].Label.Size = UDim2.new(1, 0, 1, 0)
            ESPObjects[player].Label.BackgroundTransparency = 1
            ESPObjects[player].Label.TextStrokeTransparency = 0
            ESPObjects[player].Label.TextColor3 = espColor
            ESPObjects[player].Label.TextSize = 12
            ESPObjects[player].Label.Font = Enum.Font.GothamBold
            ESPObjects[player].Label.Parent = ESPObjects[player].Billboard
        end

        local espData = ESPObjects[player]
        
        -- Update ESP
        espData.Highlight.Adornee = character
        espData.Highlight.FillColor = espColor
        espData.Highlight.OutlineColor = espColor
        espData.Highlight.Enabled = true
        espData.Highlight.Parent = character

        espData.Billboard.Adornee = head
        espData.Billboard.Enabled = true
        espData.Billboard.Parent = head

        -- Update label text
        local infoText = player.Name
        
        if getgenv().ShowDistance and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
            local distance = math.floor((head.Position - LocalPlayer.Character.Head.Position).Magnitude)
            infoText = infoText .. "\n" .. distance .. " studs"
        end
        
        if getgenv().ShowNames and humanoid then
            infoText = infoText .. "\nHP: " .. math.floor(humanoid.Health)
        end
        
        espData.Label.Text = infoText
        espData.Label.TextColor3 = espColor
    end
end

-- GOD MODE Functions
function UpdateGodMode()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    -- God Mode - бессмертие
    if getgenv().GodMode then
        humanoid.MaxHealth = 1000
        humanoid.Health = 1000
        
        -- Защита от урона
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Material = Enum.Material.ForceField
            end
        end
    else
        humanoid.MaxHealth = 100
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
                part.Material = Enum.Material.Plastic
            end
        end
    end
    
    -- Super Speed
    if getgenv().SuperSpeed then
        humanoid.WalkSpeed = 35
    else
        humanoid.WalkSpeed = 16
    end
end

-- One Shot Kill
function UpdateOneShotKill()
    if not getgenv().OneShotKill then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                if player.Team ~= LocalPlayer.Team then
                    humanoid.MaxHealth = 1
                    humanoid.Health = 1
                end
            end
        end
    end
end

-- Infinite Ammo
function UpdateInfiniteAmmo()
    if not getgenv().InfiniteAmmo then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") then
            -- Ищем и устанавливаем бесконечные патроны
            local config = tool:FindFirstChild("Configuration")
            if config then
                local ammo = config:FindFirstChild("Ammo") or config:FindFirstChild("Clip") or config:FindFirstChild("Bullets")
                if ammo and ammo:IsA("NumberValue") then
                    ammo.Value = 999
                end
            end
        end
    end
end

-- UI
function CreateUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer.PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 400)
    MainFrame.Position = UDim2.new(0, 10, 0, 10)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "TRENCH COMBAT ESP + GOD"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, 0, 1, -40)
    ScrollFrame.Position = UDim2.new(0, 0, 0, 40)
    ScrollFrame.ScrollBarThickness = 5
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.Parent = MainFrame

    local function CreateButton(text, yPos, toggleVar, description)
        local ButtonFrame = Instance.new("Frame")
        ButtonFrame.Size = UDim2.new(0, 280, 0, 45)
        ButtonFrame.Position = UDim2.new(0, 10, 0, yPos)
        ButtonFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        ButtonFrame.Parent = ScrollFrame
        
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0, 260, 0, 30)
        Button.Position = UDim2.new(0, 10, 0, 5)
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 12
        Button.Parent = ButtonFrame
        
        local Desc = Instance.new("TextLabel")
        Desc.Size = UDim2.new(1, 0, 0, 12)
        Desc.Position = UDim2.new(0, 0, 0, 32)
        Desc.Text = description
        Desc.TextColor3 = Color3.fromRGB(180, 180, 180)
        Desc.BackgroundTransparency = 1
        Desc.Font = Enum.Font.Gotham
        Desc.TextSize = 10
        Desc.Parent = ButtonFrame
        
        local function UpdateButton()
            if getgenv()[toggleVar] then
                Button.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
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
        return ButtonFrame
    end

    local yPos = 10
    CreateButton("👁️ ESP", yPos, "ESPEnabled", "Подсветка игроков")
    yPos = yPos + 50
    CreateButton("📏 Distance", yPos, "ShowDistance", "Показывать расстояние")
    yPos = yPos + 50
    CreateButton("👥 Team Color", yPos, "TeamColor", "Цвет по команде")
    yPos = yPos + 50
    CreateButton("🛡️ GOD MODE", yPos, "GodMode", "Бессмертие")
    yPos = yPos + 50
    CreateButton("💀 ONE SHOT", yPos, "OneShotKill", "Убивать с 1 выстрела")
    yPos = yPos + 50
    CreateButton("🔫 INF AMMO", yPos, "InfiniteAmmo", "Бесконечные патроны")
    yPos = yPos + 50
    CreateButton("💨 SPEED", yPos, "SuperSpeed", "Высокая скорость")

    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- Main loops
RunService.Heartbeat:Connect(function()
    UpdateGodMode()
    UpdateOneShotKill()
    UpdateInfiniteAmmo()
end)

RunService.Stepped:Connect(function()
    UpdateESP()
end)

-- Create UI
CreateUI()

print("✅ ESP + God Mode активирован!")
print("👁️ ESP: стабильная подсветка игроков")
print("🛡️ God Mode: бессмертие работает")
print("💀 One Shot: убиваешь с одного выстрела")
print("🔫 Inf Ammo: бесконечные патроны")
print("💨 Speed: увеличенная скорость")
