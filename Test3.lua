-- Brain Rot Machine Bypass System
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- UI
local GameUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")

GameUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
GameUI.ResetOnSpawn = false

MainFrame.Parent = GameUI
MainFrame.Size = UDim2.new(0, 400, 0, 400)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(0, 400, 0, 40)
Title.Text = "MACHINE BYPASS SYSTEM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Title.Font = Enum.Font.GothamBold

ScrollFrame.Parent = MainFrame
ScrollFrame.Size = UDim2.new(0, 400, 0, 360)
ScrollFrame.Position = UDim2.new(0, 0, 0, 40)
ScrollFrame.ScrollBarThickness = 5

function CreateButton(name, position, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = ScrollFrame
    Button.Size = UDim2.new(0, 380, 0, 35)
    Button.Position = position
    Button.Text = name
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 12
    Button.MouseButton1Click:Connect(callback)
    return Button
end

-- МЕТОД 1: Поиск и использование Machine RemoteEvents
function FindMachineRemotes()
    warn("🔍 Поиск Machine RemoteEvents...")
    
    for _, remote in pairs(game:GetDescendants()) do
        if remote:IsA("RemoteEvent") then
            local remoteName = remote.Name:lower()
            
            if remoteName:find("machine") or 
               remoteName:find("craft") or 
               remoteName:find("create") or
               remoteName:find("manufacture") or
               remoteName:find("make") then
                
                warn("🎯 Найден Machine Remote: " .. remote.Name)
                
                -- Пробуем разные команды
                local commands = {
                    "CraftBrainRot", "craft", "Create", "make", 
                    "Manufacture", "start", "Begin", "Generate"
                }
                
                for _, cmd in pairs(commands) do
                    pcall(function()
                        remote:FireServer(cmd)
                        remote:FireServer(cmd, "BrainRot")
                        remote:FireServer(cmd, LocalPlayer)
                    end)
                end
            end
        end
    end
end

-- МЕТОД 2: Поиск Machine и принудительное использование
function ForceMachineUse()
    warn("🔄 Принудительное использование Machine...")
    
    local machine = nil
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("machine") and (obj:IsA("Part") or obj:IsA("Model")) then
            machine = obj
            break
        end
    end
    
    if machine then
        warn("🎯 Machine найдена: " .. machine:GetFullName())
        
        -- Пытаемся остаться у Machine
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart
            
            -- Отключаем коллизию чтобы не отталкивало
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
            
            -- Телепортируемся и фиксируем позицию
            root.CFrame = machine.CFrame + Vector3.new(0, 5, 0)
            
            -- Пытаемся использовать Machine
            for i = 1, 10 do
                pcall(function()
                    -- Ищем ClickDetector или ProximityPrompt
                    for _, detector in pairs(machine:GetDescendants()) do
                        if detector:IsA("ClickDetector") or detector:IsA("ProximityPrompt") then
                            if detector:IsA("ClickDetector") then
                                detector:MaxActivationDistance = 1000
                                detector:MouseClick(LocalPlayer)
                            else
                                detector:InputHoldBegin()
                            end
                        end
                    end
                end)
                wait(0.5)
            end
        end
    end
end

-- МЕТОД 3: Создание фейковой Machine
function CreateFakeMachine()
    warn("🏗️ Создание фейковой Machine...")
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- Создаем фейковую Machine
    local fakeMachine = Instance.new("Part")
    fakeMachine.Name = "BrainRotManufacturer"
    fakeMachine.Size = Vector3.new(10, 8, 6)
    fakeMachine.BrickColor = BrickColor.new("Bright blue")
    fakeMachine.Material = Enum.Material.Neon
    fakeMachine.CanCollide = true
    fakeMachine.Anchored = true
    fakeMachine.Parent = workspace
    fakeMachine.CFrame = root.CFrame + Vector3.new(0, 0, -10)
    
    -- Добавляем ClickDetector
    local clickDetector = Instance.new("ClickDetector")
    clickDetector.Parent = fakeMachine
    
    clickDetector.MouseClick:Connect(function()
        warn("🖱️ Фейковая Machine активирована!")
        -- Пытаемся вызвать настоящие Machine RemoteEvents
        FindMachineRemotes()
    end)
    
    warn("✅ Фейковая Machine создана! Попробуй нажать на нее!")
end

-- МЕТОД 4: Поиск рецептов крафта
function FindCraftRecipes()
    warn("📖 Поиск рецептов крафта...")
    
    -- Ищем в ReplicatedStorage
    local rs = game:GetService("ReplicatedStorage")
    for _, item in pairs(rs:GetDescendants()) do
        if item.Name:lower():find("recipe") or 
           item.Name:lower():find("craft") or
           item.Name:lower():find("formula") then
            warn("📚 Найден рецепт: " .. item:GetFullName())
        end
    end
    
    -- Ищем модули с рецептами
    for _, script in pairs(game:GetDescendants()) do
        if script:IsA("ModuleScript") then
            if script.Name:lower():find("recipe") or 
               script.Name:lower():find("craft") then
                warn("📦 Модуль с рецептами: " .. script:GetFullName())
            end
        end
    end
end

-- Создание кнопок
local yPos = 10
CreateButton("🔍 Найти Machine RemoteEvents", UDim2.new(0, 10, 0, yPos), FindMachineRemotes)
yPos = yPos + 40
CreateButton("🔄 Принудительно использовать Machine", UDim2.new(0, 10, 0, yPos), ForceMachineUse)
yPos = yPos + 40
CreateButton("🏗️ Создать фейковую Machine", UDim2.new(0, 10, 0, yPos), CreateFakeMachine)
yPos = yPos + 40
CreateButton("📖 Найти рецепты крафта", UDim2.new(0, 10, 0, yPos), FindCraftRecipes)
yPos = yPos + 40
CreateButton("🚀 ЗАПУСТИТЬ ВСЕ МЕТОДЫ", UDim2.new(0, 10, 0, yPos), function()
    FindMachineRemotes()
    wait(1)
    ForceMachineUse()
    wait(1)
    CreateFakeMachine()
    wait(1)
    FindCraftRecipes()
end)

warn("🎯 Machine Bypass System загружен!")
warn("💡 Попробуй разные методы чтобы обойти защиту Machine!")
