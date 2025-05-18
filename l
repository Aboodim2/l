
--[[

    _   ____  ____  __   __  ____  ______ 
   / | / / / / / / / /  / / / / / / / __ )
  /  |/ / / / / /_/ /  / /_/ / / / / __  |
 / /|  / /_/ / __  /  / __  / /_/ / /_/ / 
/_/ |_/\____/_/ /_/  /_/ /_/\____/_____/  
                                          
                      https://discord.gg/ejBdgPzRb4                     
                                             
]]

local TweenService = game:GetService("TweenService")
local blurUI = Instance.new("ScreenGui")
blurUI.Name = "BlurScreen"
blurUI.IgnoreGuiInset = true
blurUI.ZIndexBehavior = Enum.ZIndexBehavior.Global
blurUI.DisplayOrder = 999999
blurUI.Parent = game:GetService("CoreGui")

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = game.Lighting

task.spawn(function()
    for i = 0, 24, 2 do
        blur.Size = i
        task.wait(0.03)
    end
end) 

local message = Instance.new("TextLabel")
message.Size = UDim2.new(0, 700, 0, 140)
message.Position = UDim2.new(0.5, -350, 0.35, -70)
message.BackgroundTransparency = 1
message.Text = "This is an old version of Skull Hub. Click the button below to copy the new version of the script!"
message.TextColor3 = Color3.fromRGB(255, 255, 255)
message.Font = Enum.Font.FredokaOne
message.TextSize = 40
message.TextWrapped = true
message.TextScaled = true
message.TextYAlignment = Enum.TextYAlignment.Center
message.Parent = blurUI

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 0, 0)
stroke.Parent = message

local buttonsHolder = Instance.new("Frame")
buttonsHolder.Size = UDim2.new(0, 400, 0, 50)
buttonsHolder.Position = UDim2.new(0.5, -200, 0.5, 0)
buttonsHolder.BackgroundTransparency = 1
buttonsHolder.Parent = blurUI

local layout = Instance.new("UIListLayout")
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Padding = UDim.new(0, 20)
layout.Parent = buttonsHolder

local function createButton(text, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.5, -10, 1, 0)
    button.BackgroundColor3 = color
    button.Text = text
    button.Font = Enum.Font.FredokaOne
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 24
    button.Parent = buttonsHolder

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.5
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.5
    stroke.Parent = button

    return button
end

local button1 = createButton("Copy", Color3.fromRGB(0, 170, 255))
local button2 = createButton("Close", Color3.fromRGB(255, 80, 80))

local function setupHover(button)
    local hoverIn = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = button.BackgroundColor3:Lerp(Color3.new(1,1,1), 0.1)})
    local hoverOut = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = button.BackgroundColor3})

    local originalSize = button.Size

    button.MouseEnter:Connect(function()
        hoverIn:Play()
        TweenService:Create(button, TweenInfo.new(0.2), {Size = originalSize + UDim2.new(0, 5, 0, 5)}):Play()
    end)
    button.MouseLeave:Connect(function()
        hoverOut:Play()
        TweenService:Create(button, TweenInfo.new(0.2), {Size = originalSize}):Play()
    end)
end

setupHover(button1)
setupHover(button2)

button1.MouseButton1Click:Connect(function()
    setclipboard("loadstring(game:HttpGet('https://raw.githubusercontent.com/hungquan99/SkullHub/main/loader.lua'))()")

    local originalColor = button1.BackgroundColor3
    button1.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
    task.wait(0.2)
    button1.BackgroundColor3 = originalColor

    local copiedLabel = Instance.new("TextLabel")
    copiedLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    copiedLabel.Position = UDim2.new(0.5, 0, 0.65, 0)
    copiedLabel.Size = UDim2.new(0, 200, 0, 40)
    copiedLabel.BackgroundTransparency = 1
    copiedLabel.Text = "Copied!"
    copiedLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
    copiedLabel.Font = Enum.Font.FredokaOne
    copiedLabel.TextSize = 28
    copiedLabel.TextTransparency = 1
    copiedLabel.Parent = blurUI

    local tweenIn = TweenService:Create(copiedLabel, TweenInfo.new(0.3), {TextTransparency = 0})
    local tweenOut = TweenService:Create(copiedLabel, TweenInfo.new(0.3), {TextTransparency = 1})

    tweenIn:Play()
    tweenIn.Completed:Wait()
    task.wait(1.5)
    tweenOut:Play()
    tweenOut.Completed:Wait()
    copiedLabel:Destroy()
end)


button2.MouseButton1Click:Connect(function()
    blur:Destroy()
    blurUI:Destroy()
end)
