-- Brain Rot Machine Analysis System
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- UI
local GameUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AnalyzeButton = Instance.new("TextButton")

GameUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
GameUI.ResetOnSpawn = false

MainFrame.Parent = GameUI
MainFrame.Size = UDim2.new(0, 350, 0, 200)
MainFrame.Position = UDim2.new(0.4, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(0, 350, 0, 40)
Title.Text = "MACHINE ANALYZER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
Title.Font = Enum.Font.GothamBold

AnalyzeButton.Parent = MainFrame
AnalyzeButton.Size = UDim2.new(0, 330, 0, 140)
AnalyzeButton.Position = UDim2.new(0, 10, 0, 50)
AnalyzeButton.Text = "🔍 АНАЛИЗИРОВАТЬ MACHINE СИСТЕМУ\n\nНайдет Machine и поймет как она работает"
AnalyzeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AnalyzeButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
AnalyzeButton.Font = Enum.Font.Gotham

function AnalyzeMachineSystem()
    warn("🔍 Начинаем анализ Machine системы...")
    
    -- Поиск Machine в игре
    local machines = {}
    
    -- Поиск по всем объектам
    for _, obj in pairs(game:GetDescendants()) do
        if obj.Name:lower():find("machine") or 
           obj.Name:lower():find("collect") or
           obj.Name:lower():find("processor") then
            table.insert(machines, obj)
            warn("🎯 Найдена Machine: " .. obj:GetFullName())
        end
    end
    
    -- Поиск RemoteEvents связанных с Machine
    for _, remote in pairs(game:GetDescendants()) do
        if remote:IsA("RemoteEvent") then
            if remote.Name:lower():find("machine") or 
               remote.Name:lower():find("collect") or
               remote.Name:lower():find("brain") or
               remote.Name:lower():find("rot") then
                warn("📡 Найден Machine RemoteEvent: " .. remote.Name)
                
                -- Пробуем разные варианты взаимодействия
                pcall(function() remote:FireServer("Collect") end)
                pcall(function() remote:FireServer("collect") end)
                pcall(function() remote:FireServer("BrainRot") end)
                pcall(function() remote:FireServer("brainrot") end)
                pcall(function() remote:FireServer(LocalPlayer) end)
            end
        end
    end
    
    -- Поиск Parts с триггерами
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("Part") and part.Name:lower():find("machine") then
            warn("🏗️ Machine Part найдена: " .. part:GetFullName())
            
            -- Пытаемся взаимодействовать с Machine частью
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 5, 0)
            end
        end
    end
    
    -- Анализ ReplicatedStorage для Machine префабов
    local rs = game:GetService("ReplicatedStorage")
    for _, item in pairs(rs:GetDescendants()) do
        if item.Name:lower():find("machine") or item.Name:lower():find("brain") then
            warn("📦 Machine объект в ReplicatedStorage: " .. item.Name)
        end
    end
    
    if #machines == 0 then
        warn("❌ Machine не найдена автоматически")
        warn("💡 Попробуй подойти к Machine вручную и нажать кнопку снова")
    else
        warn("✅ Найдено " .. #machines .. " Machine объектов")
        warn("🎯 Анализ завершен - проверь консоль для деталей")
    end
end

AnalyzeButton.MouseButton1Click:Connect(AnalyzeMachineSystem)

warn("🔍 Machine Analyzer загружен!")
warn("💡 Подойди к Machine в игре и нажми кнопку анализа!")
