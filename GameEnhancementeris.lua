-- Real Brain Rot Duplication System
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Simple UI
local GameUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local DupeButton = Instance.new("TextButton")

GameUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
GameUI.ResetOnSpawn = false

MainFrame.Parent = GameUI
MainFrame.Size = UDim2.new(0, 300, 0, 150)
MainFrame.Position = UDim2.new(0.4, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(0, 300, 0, 40)
Title.Text = "REAL BRAIN ROT DUPE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Title.Font = Enum.Font.GothamBold

DupeButton.Parent = MainFrame
DupeButton.Size = UDim2.new(0, 280, 0, 80)
DupeButton.Position = UDim2.new(0, 10, 0, 50)
DupeButton.Text = "🎯 ПОПЫТКА РЕАЛЬНОГО ДЮПА\n(Ищем уязвимости игры)"
DupeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DupeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
DupeButton.Font = Enum.Font.Gotham

function AttemptRealDupe()
    warn("🔍 Начинаем поиск уязвимостей для дюпа...")
    
    -- МЕТОД 1: Поиск и использование RemoteEvents
    local remoteFound = false
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            if obj.Name:lower():find("brain") or 
               obj.Name:lower():find("rot") or 
               obj.Name:lower():find("add") or 
               obj.Name:lower():find("give") or
               obj.Name:lower():find("collect") then
                
                warn("🎯 Найден RemoteEvent: " .. obj.Name)
                pcall(function()
                    -- Пробуем разные варианты данных
                    obj:FireServer("BrainRot")
                    obj:FireServer("brainrot")
                    obj:FireServer("Collect")
                    obj:FireServer(1)
                    obj:FireServer(100)
                    obj:FireServer(LocalPlayer)
                    remoteFound = true
                end)
            end
        end
    end
    
    -- МЕТОД 2: Поиск в ReplicatedStorage
    local rs = game:GetService("ReplicatedStorage")
    for _, item in pairs(rs:GetDescendants()) do
        if item.Name:lower():find("brain") or item.Name:lower():find("rot") then
            warn("📦 Найден Brain Rot в ReplicatedStorage: " .. item.Name)
            pcall(function()
                local clone = item:Clone()
                clone.Parent = LocalPlayer.Backpack
            end)
        end
    end
    
    -- МЕТОД 3: Проверка Leaderstats
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        for _, stat in pairs(leaderstats:GetChildren()) do
            if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                if stat.Name:lower():find("brain") or stat.Name:lower():find("rot") then
                    warn("📊 Найден Brain Rot в статистике: " .. stat.Name)
                    stat.Value = stat.Value + 100
                end
            end
        end
    end
    
    -- МЕТОД 4: Поиск сервисов данных
    pcall(function()
        local dataStore = game:GetService("DataStoreService")
        warn("💾 DataStoreService найден")
    end)
    
    if not remoteFound then
        warn("❌ Не найдены подходящие RemoteEvents для дюпа")
        warn("💡 Возможные причины:")
        warn("   - Игра использует другие методы")
        warn("   - Нужен специальный эксплойт")
        warn("   - Дюп может быть невозможен")
    else
        warn("✅ Попытка дюпа завершена - проверьте инвентарь!")
    end
end

DupeButton.MouseButton1Click:Connect(AttemptRealDupe)
warn("🎯 Real Brain Rot Dupe загружен - пробуем найти уязвимости!")
