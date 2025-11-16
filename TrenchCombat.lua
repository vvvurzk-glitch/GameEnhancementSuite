-- Trench Combat Silent Aim + FOV
-- GitHub: https://raw.githubusercontent.com/vvvurzk-glitch/GameEnhancementSuite/main/TrenchCombatSilent.lua

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

print("🎯 Trench Combat Silent Aim + FOV Loaded!")

-- Config
getgenv().SilentAimEnabled = false
getgenv().FOVCircle = false
getgenv().FOVSize = 80
getgenv().TeamCheck = true
getgenv().VisibleCheck = false

-- FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Radius = getgenv().FOVSize
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)

-- Silent Aim Function
function GetClosestPlayer()
    if not getgenv().SilentAimEnabled then return nil end
    
    local closestPlayer = nil
    local closestDistance = getgenv().FOVSize
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local head = character:FindFirstChild("Head")
            
            if humanoid and humanoid.Health > 0 and head then
                -- Team Check
                if getgenv().TeamCheck then
                    if player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
                        continue
                    end
                end
                
                -- Get screen position
                local screenPoint, onScreen = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local mousePos = UserInputService:GetMouseLocation()
                    local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - mousePos).Magnitude
                    
                    -- Check if within FOV
                    if distance <= closestDistance then
                        closestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

-- Hook for silent aim
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall

setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if getgenv().SilentAimEnabled and (method == "FireServer" or method == "InvokeServer") then
        if tostring(self) == "WeaponRemote" or tostring(self):find("Weapon") or tostring(self):find("Gun") then
            local closestPlayer = GetClosestPlayer()
            if closestPlayer and closestPlayer.Character then
                local head = closestPlayer.Character:FindFirstChild("Head")
                if head then
                    -- Modify arguments to hit the target
                    args[1] = head.Position -- Target position
                    print("🎯 Silent Aim: Hitting " .. closestPlayer.Name)
                end
            end
        end
    end
    
    return oldNamecall(self, unpack(args))
end)

setreadonly(mt, true)

-- FOV Update
RunService.RenderStepped:Connect(function()
    FOVCircle.Radius = getgenv().FOVSize
    FOVCircle.Visible = getgenv().FOVCircle
    FOVCircle.Position = UserInputService:GetMouseLocation()
end)

-- UI
function CreateSilentAimUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer.PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 350)
    MainFrame.Position = UDim2.new(0, 10, 0, 10)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Text = "SILENT AIM + FOV"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, 0, 1, -30)
    ScrollFrame.Position = UDim2.new(0, 0, 0, 30)
    ScrollFrame.ScrollBarThickness = 5
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.Parent = MainFrame

    local function CreateButton(text, yPos, toggleVar)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0, 280, 0, 35)
        Button.Position = UDim2.new(0, 10, 0, yPos)
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 12
        Button.Parent = ScrollFrame
        
        local function UpdateButton()
            if getgenv()[toggleVar] then
                Button.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
                Button.Text = text .. " ✓"
            else
                Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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

    local function CreateSlider(text, yPos, valueVar, minVal, maxVal)
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Size = UDim2.new(0, 280, 0, 50)
        SliderFrame.Position = UDim2.new(0, 10, 0, yPos)
        SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        SliderFrame.Parent = ScrollFrame
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0, 20)
        Label.Text = text .. ": " .. getgenv()[valueVar]
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.BackgroundTransparency = 1
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 12
        Label.Parent = SliderFrame
        
        local Slider = Instance.new("TextButton")
        Slider.Size = UDim2.new(0, 260, 0, 20)
        Slider.Position = UDim2.new(0, 10, 0, 25)
        Slider.Text = ""
        Slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        Slider.Parent = SliderFrame
        
        local Fill = Instance.new("Frame")
        Fill.Size = UDim2.new((getgenv()[valueVar] - minVal) / (maxVal - minVal), 0, 1, 0)
        Fill.Position = UDim2.new(0, 0, 0, 0)
        Fill.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        Fill.BorderSizePixel = 0
        Fill.Parent = Slider
        
        Slider.MouseButton1Down:Connect(function()
            local connection
            connection = RunService.RenderStepped:Connect(function()
                local mousePos = UserInputService:GetMouseLocation()
                local relativeX = math.clamp(mousePos.X - Slider.AbsolutePosition.X, 0, Slider.AbsoluteSize.X)
                local value = minVal + (relativeX / Slider.AbsoluteSize.X) * (maxVal - minVal)
                getgenv()[valueVar] = math.floor(value)
                Label.Text = text .. ": " .. getgenv()[valueVar]
                Fill.Size = UDim2.new((getgenv()[valueVar] - minVal) / (maxVal - minVal), 0, 1, 0)
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    connection:Disconnect()
                end
            end)
        end)
        
        return SliderFrame
    end

    local yPos = 10
    CreateButton("🎯 SILENT AIM", yPos, "SilentAimEnabled")
    yPos = yPos + 40
    CreateButton("⭕ FOV CIRCLE", yPos, "FOVCircle")
    yPos = yPos + 40
    CreateButton("👥 TEAM CHECK", yPos, "TeamCheck")
    yPos = yPos + 40
    CreateButton("👀 VISIBLE CHECK", yPos, "VisibleCheck")
    yPos = yPos + 50
    CreateSlider("FOV SIZE", yPos, "FOVSize", 20, 200)

    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 60)
end

-- Create UI
CreateSilentAimUI()

print("✅ Silent Aim + FOV Loaded!")
print("🎯 Стреляй куда угодно - попадаешь в цели в FOV круге")
print("⭕ FOV круг показывает зону поражения")
print("👥 Team Check - не стреляет по своим")
