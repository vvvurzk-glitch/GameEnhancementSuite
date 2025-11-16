-- Real Brain Rot Finder
local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("🔍 REAL BRAIN ROT FINDER STARTED")

-- UI
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "BRAIN ROT ANALYZER"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.new(0, 0.5, 0)
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 280, 0, 150)
button.Position = UDim2.new(0, 10, 0, 40)
button.Text = "🔍 АНАЛИЗИРОВАТЬ ИГРУ\n\nНайдет КАК создаются Brain Rot"
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
button.Parent = frame

button.MouseButton1Click:Connect(function()
    print("🎯 Начинаем анализ игры...")
    
    -- 1. Ищем настоящие Brain Rot объекты
    print("🔍 Поиск настоящих Brain Rot...")
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("brain") and not obj.Name:lower():find("part") then
            print("🎯 НАСТОЯЩИЙ Brain Rot: " .. obj:GetFullName())
            print("   Тип: " .. obj.ClassName)
            if obj:IsA("Part") then
                print("   Размер: " .. tostring(obj.Size))
                print("   Цвет: " .. tostring(obj.BrickColor))
            end
        end
    end
    
    -- 2. Ищем системы создания Brain Rot
    print("🔍 Поиск систем создания...")
    for _, remote in pairs(game:GetDescendants()) do
        if remote:IsA("RemoteEvent") then
            local name = remote.Name:lower()
            if name:find("brain") or name:find("spawn") or name:find("create") then
                print("🎯 RemoteEvent для создания: " .. remote.Name)
                print("   Путь: " .. remote:GetFullName())
            end
        end
    end
    
    -- 3. Ищем в ReplicatedStorage
    print("🔍 Поиск в ReplicatedStorage...")
    local rs = game:GetService("ReplicatedStorage")
    for _, item in pairs(rs:GetDescendants()) do
        if item.Name:lower():find("brain") then
            print("🎯 Объект в ReplicatedStorage: " .. item.Name)
            print("   Тип: " .. item.ClassName)
        end
    end
    
    -- 4. Ищем скрипты связанные с Brain Rot
    print("🔍 Поиск скриптов...")
    for _, script in pairs(game:GetDescendants()) do
        if script:IsA("Script") or script:IsA("LocalScript") then
            if script.Name:lower():find("brain") then
                print("🎯 Скрипт Brain Rot: " .. script.Name)
            end
        end
    end
    
    print("✅ Анализ завершен! Проверь консоль.")
end)

print("✅ Brain Rot Analyzer загружен!")
print("💡 Нажми кнопку чтобы узнать КАК игра создает Brain Rot")
