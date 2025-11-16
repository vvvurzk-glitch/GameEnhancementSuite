-- Advanced Brain Rot Duplicator
local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("🎯 ADVANCED DUPE LOADED")

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
title.Text = "BRAIN ROT DUPLICATOR"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.new(0, 0.5, 0)
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 280, 0, 150)
button.Position = UDim2.new(0, 10, 0, 40)
button.Text = "🔄 ЗАПУСТИТЬ ДЮП\n\nСоздаст копии Brain Rot"
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundColor3 = Color3.new(0.8, 0.2, 0)
button.Parent = frame

button.MouseButton1Click:Connect(function()
    print("🔄 STARTING DUPE...")
    
    local duplicated = 0
    
    -- Ищем Brain Rot в workspace
    for _, obj in pairs(workspace:GetDescendants()) do
        if string.lower(obj.Name):find("brain") and obj:IsA("Part") then
            print("🎯 FOUND: " .. obj.Name)
            
            -- Создаем копию
            local clone = obj:Clone()
            clone.Parent = workspace
            clone.Name = obj.Name .. "_COPY"
            
            -- Позиционируем рядом
            clone.CFrame = obj.CFrame + Vector3.new(
                math.random(-5, 5),
                0,
                math.random(-5, 5)
            )
            
            duplicated = duplicated + 1
            print("✅ CREATED COPY: " .. clone.Name)
        end
    end
    
    -- Показываем результат
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Dupe Complete",
        Text = "Created " .. duplicated .. " copies",
        Duration = 5
    })
    
    print("🎉 DUPE FINISHED: " .. duplicated .. " copies created")
end)

print("✅ READY - CLICK ORANGE BUTTON TO DUPE")
