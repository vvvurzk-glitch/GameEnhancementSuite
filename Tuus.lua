-- Base Brain Rot Duplication System
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

print("🎯 Starting Base Brain Rot Dupe...")

-- UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BaseBrainRotDupe"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 250)
mainFrame.Position = UDim2.new(0.4, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "BASE BRAIN ROT DUPE"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -40)
scrollFrame.Position = UDim2.new(0, 0, 0, 40)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 5
scrollFrame.Parent = mainFrame

function CreateButton(name, yPos, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 330, 0, 35)
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.Font = Enum.Font.Gotham
    button.Parent = scrollFrame
    button.MouseButton1Click:Connect(callback)
    return button
end

-- МЕТОД 1: Поиск и дупликация Brain Rot на базе
function DupeBaseBrainRots()
    print("🔍 Searching for Brain Rots on base...")
    
    local brainRotsFound = 0
    
    -- Ищем Brain Rot объекты на базе
    for _, obj in pairs(workspace:GetDescendants()) do
        if (obj.Name:lower():find("brain") or obj.Name:lower():find("rot")) and 
           (obj:IsA("Part") or obj:IsA("MeshPart") or obj:IsA("Model")) then
            
            print("🎯 Found Brain Rot: " .. obj:GetFullName())
            brainRotsFound = brainRotsFound + 1
            
            -- Создаем копии этого Brain Rot
            for i = 1, 20 do  -- Создаем 20 копий
                local clone = obj:Clone()
                
                -- Сохраняем все свойства оригинала
                if obj:IsA("Model") then
                    for _, child in pairs(obj:GetChildren()) do
                        if child:IsA("Part") then
                            local childClone = child:Clone()
                            childClone.Parent = clone
                        end
                    end
                end
                
                clone.Parent = obj.Parent
                clone.Name = obj.Name .. "_Dupe_" .. i
                
                -- Позиционируем копии вокруг оригинала
                local offset = Vector3.new(
                    math.random(-10, 10),
                    math.random(0, 5),
                    math.random(-10, 10)
                )
                
                if obj:IsA("Part") then
                    clone.CFrame = obj.CFrame + offset
                    clone.Anchored = true  -- Чтобы не упали
                elseif obj:IsA("Model") and obj:FindFirstChild("PrimaryPart") then
                    clone:SetPrimaryPartCFrame(obj.PrimaryPart.CFrame + offset)
                end
                
                print("🔄 Created: " .. clone.Name)
            end
        end
    end
    
    if brainRotsFound > 0 then
        print("✅ Created " .. (brainRotsFound * 20) .. " Brain Rot copies!")
    else
        print("❌ No Brain Rots found on base")
        print("💡 Make sure you have Brain Rots placed on your base first!")
    end
end

-- МЕТОД 2: Массовое создание Brain Rot
function MassCreateBrainRots()
    print("🏗️ Mass creating Brain Rots on base...")
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- Создаем много Brain Rot объектов
    for i = 1, 50 do
        local brainRot = Instance.new("Part")
        brainRot.Name = "BrainRot_" .. i
        brainRot.Size = Vector3.new(3, 3, 3)
        brainRot.BrickColor = BrickColor.new("Bright green")
        brainRot.Material = Enum.Material.Neon
        brainRot.CanCollide = true
        brainRot.Anchored = true
        brainRot.Parent = workspace
        
        -- Располагаем на базе в сетке
        local row = math.floor((i - 1) / 10)  -- 10 в ряду
        local col = (i - 1) % 10
        
        brainRot.CFrame = root.CFrame * CFrame.new(
            (col - 5) * 4,  -- X позиция
            2,              -- Высота
            row * 4         -- Z позиция
        )
        
        -- Добавляем свечение
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 2
        pointLight.Range = 8
        pointLight.Color = Color3.new(0, 1, 0)
        pointLight.Parent = brainRot
    end
    
    print("✅ Created 50 Brain Rots on your base!")
end

-- МЕТОД 3: Поиск и использование системы хранения
function StorageSystemDupe()
    print("📦 Searching for storage system...")
    
    -- Ищем системы хранения на базе
    local storageSystems = {}
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("storage") or 
           obj.Name:lower():find("chest") or 
           obj.Name:lower():find("container") or
           obj.Name:lower():find("base") then
            
            table.insert(storageSystems, obj)
            print("🎯 Found storage: " .. obj:GetFullName())
            
            -- Пробуем взаимодействовать с системой хранения
            for _, remote in pairs(obj:GetDescendants()) do
                if remote:IsA("RemoteEvent") then
                    print("📡 Found storage Remote: " .. remote.Name)
                    
                    -- Пробуем добавить Brain Rot
                    pcall(function()
                        remote:FireServer("AddBrainRot", 100)
                        remote:FireServer("StoreBrainRot", 50)
                        remote:FireServer("Duplicate", "BrainRot")
                    end)
                end
            end
        end
    end
    
    if #storageSystems == 0 then
        print("❌ No storage systems found")
    end
end

-- МЕТОД 4: Auto-Duplicate System
function AutoDupeSystem()
    print("🔄 Starting Auto-Dupe System...")
    
    _G.AutoDuping = true
    
    spawn(function()
        while _G.AutoDuping and wait(2) do  -- Дюпим каждые 2 секунды
            pcall(function()
                -- Ищем существующие Brain Rots и создаем копии
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name:lower():find("brain") and obj:IsA("Part") then
                        local clone = obj:Clone()
                        clone.Parent = workspace
                        clone.Name = obj.Name .. "_AutoDupe"
                        
                        -- Случайное позиционирование рядом
                        clone.CFrame = obj.CFrame + Vector3.new(
                            math.random(-3, 3),
                            math.random(0, 2),
                            math.random(-3, 3)
                        )
                    end
                end
                print("🔄 Auto-dupe cycle completed")
            end)
        end
    end)
    
    print("✅ Auto-Dupe system started!")
end

-- Создаем кнопки
local yPos = 10
CreateButton("🔍 Dupe Existing Brain Rots", yPos, DupeBaseBrainRots)
yPos = yPos + 40
CreateButton("🏗️ Mass Create Brain Rots", yPos, MassCreateBrainRots)
yPos = yPos + 40
CreateButton("📦 Storage System Dupe", yPos, StorageSystemDupe)
yPos = yPos + 40
CreateButton("🔄 Start Auto-Dupe", yPos, AutoDupeSystem)
yPos = yPos + 40
CreateButton("🛑 Stop Auto-Dupe", yPos, function()
    _G.AutoDuping = false
    print("🛑 Auto-Dupe stopped")
end)

scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)

print("✅ Base Brain Rot Dupe loaded!")
print("💡 First, use 'Dupe Existing Brain Rots' if you have Brain Rots on base")
print("💡 Or use 'Mass Create Brain Rots' to create new ones")
