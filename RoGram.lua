-- RoGram Item Duplicator
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

print("🎯 RoGram Duplicator Loaded!")

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "ROGRAM DUPLICATOR"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, 0, 1, -40)
ScrollFrame.Position = UDim2.new(0, 0, 0, 40)
ScrollFrame.ScrollBarThickness = 5
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.Parent = MainFrame

function CreateButton(name, yPos, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 330, 0, 35)
    Button.Position = UDim2.new(0, 10, 0, yPos)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.Font = Enum.Font.Gotham
    Button.Parent = ScrollFrame
    Button.MouseButton1Click:Connect(callback)
    return Button
end

-- МЕТОД 1: Поиск и дупликация предметов
function DuplicateItems()
    print("🔍 Searching for items to duplicate...")
    
    local duplicated = 0
    
    -- Поиск предметов в инвентаре игрока
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        for _, item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") or item:IsA("Accessory") then
                print("🎯 Found item: " .. item.Name)
                
                -- Создаем копии
                for i = 1, 5 do
                    local clone = item:Clone()
                    clone.Parent = backpack
                    clone.Name = item.Name .. "_COPY_" .. i
                    duplicated = duplicated + 1
                    print("🔄 Created: " .. clone.Name)
                end
            end
        end
    end
    
    -- Поиск предметов в workspace
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") or obj.Name:lower():find("helmet") or obj.Name:lower():find("mask") then
            print("🎯 Found world item: " .. obj.Name)
            
            for i = 1, 3 do
                local clone = obj:Clone()
                clone.Parent = workspace
                clone.Name = obj.Name .. "_COPY_" .. i
                
                -- Позиционируем рядом
                if obj:IsA("Part") then
                    clone.CFrame = obj.CFrame + Vector3.new(math.random(-3, 3), 0, math.random(-3, 3))
                end
                
                duplicated = duplicated + 1
            end
        end
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Duplication Complete",
        Text = "Created " .. duplicated .. " copies",
        Duration = 5
    })
end

-- МЕТОД 2: RemoteEvent Exploit
function RemoteDupe()
    print("📡 Attempting RemoteEvent duplication...")
    
    local remotesFound = 0
    for _, remote in pairs(game:GetDescendants()) do
        if remote:IsA("RemoteEvent") then
            local remoteName = remote.Name:lower()
            
            if remoteName:find("add") or remoteName:find("give") or 
               remoteName:find("item") or remoteName:find("reward") then
                
                print("🎯 Trying remote: " .. remote.Name)
                remotesFound = remotesFound + 1
                
                -- Пробуем разные параметры
                pcall(function() remote:FireServer("Neko Helmet") end)
                pcall(function() remote:FireServer("Rose") end)
                pcall(function() remote:FireServer("Apple") end)
                pcall(function() remote:FireServer("Star") end)
                pcall(function() remote:FireServer(100) end)
                pcall(function() remote:FireServer(LocalPlayer) end)
            end
        end
    end
    
    print("✅ Tried " .. remotesFound .. " remotes")
end

-- МЕТОД 3: DataStore Exploit
function DataStoreDupe()
    print("💾 Attempting DataStore duplication...")
    
    pcall(function()
        local DataStoreService = game:GetService("DataStoreService")
        
        -- Пробуем разные DataStore имена
        local stores = {"PlayerData", "Inventory", "Items", "Collection"}
        
        for _, storeName in pairs(stores) do
            pcall(function()
                local store = DataStoreService:GetDataStore(storeName)
                local key = "Player_" .. LocalPlayer.UserId
                
                -- Фейковые данные с предметами
                local fakeData = {
                    Items = {"Neko Helmet", "Rose", "Apple Pattern", "Star Pattern"},
                    Coins = 99999,
                    Gems = 9999
                }
                
                store:SetAsync(key, fakeData)
                print("✅ DataStore attempt: " .. storeName)
            end)
        end
    end)
end

-- МЕТОД 4: Auto-Farm Items
function AutoFarmItems()
    if _G.AutoFarming then
        _G.AutoFarming = false
        print("🛑 Auto-Farm stopped")
        return
    end
    
    _G.AutoFarming = true
    print("💰 Starting Auto-Farm...")
    
    spawn(function()
        while _G.AutoFarming and wait(2) do
            pcall(function()
                -- Поиск предметов для сбора
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Tool") or obj.Name:lower():find("coin") or obj.Name:lower():find("gem") then
                        -- Телепортируемся к предмету
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                            wait(0.2)
                        end
                    end
                end
            end)
        end
    end)
end

-- Создание кнопок
local yPos = 10
CreateButton("🔍 Duplicate Items", yPos, DuplicateItems)
yPos = yPos + 40
CreateButton("📡 RemoteEvent Dupe", yPos, RemoteDupe)
yPos = yPos + 40
CreateButton("💾 DataStore Exploit", yPos, DataStoreDupe)
yPos = yPos + 40
CreateButton("💰 Auto-Farm Items", yPos, AutoFarmItems)
yPos = yPos + 40
CreateButton("🛑 Stop Auto-Farm", yPos, function()
    _G.AutoFarming = false
    print("🛑 Auto-Farm stopped")
end)

ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)

print("✅ RoGram Duplicator Ready!")
print("💡 Try different methods to duplicate items!")
