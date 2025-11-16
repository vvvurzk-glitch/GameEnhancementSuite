-- Trench Combat Ultimate Hack v2.0 - FIXED UI
-- GitHub: https://raw.githubusercontent.com/vvvurzk-glitch/GameEnhancementSuite/main/TrenchCombat.lua

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

print("🎯 Trench Combat Ultimate Hack v2.0 Loaded!")

-- Simple Config
getgenv().AimbotEnabled = false
getgenv().ESPEnabled = false
getgenv().SpeedEnabled = false
getgenv().NoRecoilEnabled = false

-- Simple Aimbot
function SimpleAimbot()
    if not getgenv().AimbotEnabled then return end
    
    local closestPlayer = nil
    local closestDistance = 1000
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local head = character:FindFirstChild("Head")
            
            if humanoid and humanoid.Health > 0 and head then
                if player.Team ~= LocalPlayer.Team then
                    local screenPoint, onScreen = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)).Magnitude
                        
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
        if head then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, head.Position)
        end
    end
end

-- Simple ESP
function SimpleESP()
    if not getgenv().ESPEnabled then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            
            if humanoid and humanoid.Health > 0 then
                local highlight = character:FindFirstChild("ESP_Highlight") or Instance.new("Highlight")
                highlight.Name = "ESP_Highlight"
                highlight.Adornee = character
                highlight.FillTransparency = 0.8
                highlight.OutlineTransparency = 0
                
                if player.Team == LocalPlayer.Team then
                    highlight.FillColor = Color3.fromRGB(0, 255, 0)
                    highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
                else
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                end
                
                highlight.Parent = character
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
        humanoid.WalkSpeed = 30
    else
        humanoid.WalkSpeed = 16
    end
end

-- Create UI with BUTTONS
function CreateUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer.PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 400)
    MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "TRENCH COMBAT HACK"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, 0, 1, -40)
    ScrollFrame.Position = UDim2.new(0, 0, 0, 40)
    ScrollFrame.ScrollBarThickness = 5
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.Parent = MainFrame

    -- Function to create buttons
    local function CreateButton(text, yPos, toggleVar)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0, 280, 0, 40)
        Button.Position = UDim2.new(0, 10, 0, yPos)
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Button.Font = Enum.Font.Gotham
        Button.Parent = ScrollFrame
        
        Button.MouseButton1Click:Connect(function()
            getgenv()[toggleVar] = not getgenv()[toggleVar]
            
            if getgenv()[toggleVar] then
                Button.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
                Button.Text = text .. " [ON]"
            else
                Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Button.Text = text .. " [OFF]"
            end
        end)
        
        return Button
    end

    -- Create buttons
    local yPos = 10
    CreateButton("🎯 AIMBOT", yPos, "AimbotEnabled")
    yPos = yPos + 45
    CreateButton("👁️ ESP", yPos, "ESPEnabled")
    yPos = yPos + 45
    CreateButton("💨 SPEED HACK", yPos, "SpeedEnabled")
    yPos = yPos + 45
    CreateButton("🔫 NO RECOIL", yPos, "NoRecoilEnabled")
    yPos = yPos + 45
    CreateButton("🕊️ FLY HACK", yPos, "FlyEnabled")
    yPos = yPos + 45
    CreateButton("👻 NO CLIP", yPos, "NoClipEnabled")

    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

-- Main loops
RunService.RenderStepped:Connect(function()
    SimpleAimbot()
    ApplySpeedHack()
end)

spawn(function()
    while wait(1) do
        SimpleESP()
    end
end)

-- Create UI
CreateUI()

print("✅ Trench Combat Hack Loaded with BUTTONS!")
print("🎯 Now you should see buttons in the menu!")
