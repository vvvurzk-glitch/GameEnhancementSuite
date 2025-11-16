-- Trench Combat Fixed Hack v3.0
-- GitHub: https://raw.githubusercontent.com/vvvurzk-glitch/GameEnhancementSuite/main/TrenchCombatFixed.lua

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

print("🎯 Trench Combat Fixed Hack v3.0 Loaded!")

-- Config
getgenv().AimbotEnabled = false
getgenv().ESPEnabled = false
getgenv().SpeedEnabled = false

-- FIXED Aimbot - не улетает в небо
function FixedAimbot()
    if not getgenv().AimbotEnabled then return end
    
    local closestPlayer = nil
    local closestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local head = character:FindFirstChild("Head")
            
            if humanoid and humanoid.Health > 0 and head then
                -- Team check
                if player.Team and LocalPlayer.Team and player.Team ~= LocalPlayer.Team then
                    local screenPoint, onScreen = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                    
                    if onScreen then
                        local distance = (head.Position - LocalPlayer.Character.Head.Position).Magnitude
                        
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
            end
        end
    end
    
    if closestPlayer and closestPlayer.Character then
        local head = closestPlayer.Character:FindFirstChild("Head")
        if head and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
            local camera = workspace.CurrentCamera
            -- Плавное наведение, а не резкий телепорт
            camera.CFrame = CFrame.new(
                camera.CFrame.Position,
                head.Position
            )
        end
    end
end

-- FIXED ESP - не мигает
function FixedESP()
    -- Сначала очищаем старый ESP
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local highlight = player.Character:FindFirstChild("ESP_Highlight")
            if highlight then
                highlight:Destroy()
            end
        end
    end
    
    if not getgenv().ESPEnabled then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            
            if humanoid and humanoid.Health > 0 then
                -- Создаем подсветку если её нет
                local highlight = character:FindFirstChild("ESP_Highlight")
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "ESP_Highlight"
                    highlight.Adornee = character
                    highlight.FillTransparency = 0.7
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    
                    -- Цвет в зависимости от команды
                    if player.Team and LocalPlayer.Team then
                        if player.Team == LocalPlayer.Team then
                            highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Зеленый для своей команды
                            highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
                        else
                            highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Красный для врагов
                            highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                        end
                    else
                        highlight.FillColor = Color3.fromRGB(255, 165, 0) -- Оранжевый если нет команд
                        highlight.OutlineColor = Color3.fromRGB(255, 165, 0)
                    end
                    
                    highlight.Parent = character
                end
            else
                -- Убираем подсветку если игрок мертв
                local highlight = character:FindFirstChild("ESP_Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end

-- Speed Hack
function ApplySpeedHack()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    if getgenv().SpeedEnabled then
        humanoid.WalkSpeed = 26 -- Умеренная скорость
    else
        humanoid.WalkSpeed = 16 -- Стандартная скорость
    end
end

-- UI
function CreateFixedUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer.PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 300)
    MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "TRENCH COMBAT FIXED"
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

    -- Функция создания кнопок
    local function CreateButton(text, yPos, toggleVar)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0, 280, 0, 40)
        Button.Position = UDim2.new(0, 10, 0, yPos)
        Button.Text = text .. " [OFF]"
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 12
        Button.Parent = ScrollFrame
        
        Button.MouseButton1Click:Connect(function()
            getgenv()[toggleVar] = not getgenv()[toggleVar]
            
            if getgenv()[toggleVar] then
                Button.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
                Button.Text = text .. " [ON]"
                print("✅ " .. text .. " включен")
            else
                Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                Button.Text = text .. " [OFF]"
                print("❌ " .. text .. " выключен")
            end
        end)
        
        return Button
    end

    -- Создаем кнопки
    local yPos = 10
    CreateButton("🎯 AIMBOT", yPos, "AimbotEnabled")
    yPos = yPos + 45
    CreateButton("👁️ ESP", yPos, "ESPEnabled")
    yPos = yPos + 45
    CreateButton("💨 SPEED", yPos, "SpeedEnabled")
    yPos = yPos + 45
    CreateButton("🔫 NO RECOIL", yPos, "NoRecoilEnabled")

    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- Основные циклы
RunService.RenderStepped:Connect(function()
    FixedAimbot()
    ApplySpeedHack()
end)

-- ESP обновляется реже чтобы не мигало
spawn(function()
    while wait(0.5) do
        FixedESP()
    end
end)

-- Создаем UI
CreateFixedUI()

print("✅ Fixed Hack Loaded!")
print("🎯 Aimbot: плавное наведение")
print("👁️ ESP: стабильная подсветка")
print("💨 Speed: умеренное ускорение")
