-- Fake Ban Message Script - Garden Theme
-- Execute with: loadstring(game:HttpGet("your_url_here"))()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Check if GUI already exists and remove it
if playerGui:FindFirstChild("FakeDisconnectGui") then
    playerGui.FakeDisconnectGui:Destroy()
end

-- Create the fake disconnect GUI with garden theme
local function createFakeDisconnectGui()
    -- Main ScreenGui
    local disconnectGui = Instance.new("ScreenGui")
    disconnectGui.Name = "FakeDisconnectGui"
    disconnectGui.ResetOnSpawn = false
    disconnectGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Dark background overlay with garden theme
    local overlay = Instance.new("Frame")
    overlay.Name = "Overlay"
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.Position = UDim2.new(0, 0, 0, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(20, 25, 30) -- Dark garden-like background
    overlay.BorderSizePixel = 0
    overlay.Parent = disconnectGui
    
    -- Create garden-themed background pattern
    local backgroundPattern = Instance.new("Frame")
    backgroundPattern.Name = "BackgroundPattern"
    backgroundPattern.Size = UDim2.new(1, 0, 1, 0)
    backgroundPattern.Position = UDim2.new(0, 0, 0, 0)
    backgroundPattern.BackgroundColor3 = Color3.fromRGB(25, 30, 35)
    backgroundPattern.BorderSizePixel = 0
    backgroundPattern.Parent = overlay
    
    -- Add garden title at the top
    local gardenTitle = Instance.new("TextLabel")
    gardenTitle.Name = "GardenTitle"
    gardenTitle.Size = UDim2.new(0, 400, 0, 80)
    gardenTitle.Position = UDim2.new(0.5, -200, 0.2, 0)
    gardenTitle.BackgroundTransparency = 1
    gardenTitle.Text = "GROW A GARDEN"
    gardenTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    gardenTitle.TextSize = 36
    gardenTitle.Font = Enum.Font.SourceSansBold
    gardenTitle.TextXAlignment = Enum.TextXAlignment.Center
    gardenTitle.Parent = overlay
    
    -- Create strawberry emoji substitute (red square with green top)
    local strawberry = Instance.new("Frame")
    strawberry.Name = "Strawberry"
    strawberry.Size = UDim2.new(0, 30, 0, 35)
    strawberry.Position = UDim2.new(0.5, -65, 0.2, 10)
    strawberry.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    strawberry.BorderSizePixel = 0
    strawberry.Parent = overlay
    
    local strawberryTop = Instance.new("Frame")
    strawberryTop.Size = UDim2.new(1, 0, 0, 8)
    strawberryTop.Position = UDim2.new(0, 0, 0, -4)
    strawberryTop.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    strawberryTop.BorderSizePixel = 0
    strawberryTop.Parent = strawberry
    
    -- Add "GARDEN" text in green
    local gardenSubtitle = Instance.new("TextLabel")
    gardenSubtitle.Name = "GardenSubtitle"
    gardenSubtitle.Size = UDim2.new(0, 400, 0, 60)
    gardenSubtitle.Position = UDim2.new(0.5, -200, 0.28, 0)
    gardenSubtitle.BackgroundTransparency = 1
    gardenSubtitle.Text = "GARDEN"
    gardenSubtitle.TextColor3 = Color3.fromRGB(100, 200, 100)
    gardenSubtitle.TextSize = 32
    gardenSubtitle.Font = Enum.Font.SourceSansBold
    gardenSubtitle.TextXAlignment = Enum.TextXAlignment.Center
    gardenSubtitle.Parent = overlay
    
    -- Fun tagline
    local tagline = Instance.new("TextLabel")
    tagline.Name = "Tagline"
    tagline.Size = UDim2.new(0, 500, 0, 30)
    tagline.Position = UDim2.new(0.5, -250, 0.38, 0)
    tagline.BackgroundTransparency = 1
    tagline.Text = "Playing with friends makes the game even more fun!"
    tagline.TextColor3 = Color3.fromRGB(200, 200, 200)
    tagline.TextSize = 16
    tagline.Font = Enum.Font.SourceSansItalic
    tagline.TextXAlignment = Enum.TextXAlignment.Center
    tagline.Parent = overlay
    
    -- Main disconnect message frame
    local disconnectFrame = Instance.new("Frame")
    disconnectFrame.Name = "DisconnectFrame"
    disconnectFrame.Size = UDim2.new(0, 320, 0, 160)
    disconnectFrame.Position = UDim2.new(0.5, -160, 0.6, -80)
    disconnectFrame.BackgroundColor3 = Color3.fromRGB(68, 74, 84)
    disconnectFrame.BorderSizePixel = 0
    disconnectFrame.Parent = overlay
    
    -- Frame corner rounding
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = disconnectFrame
    
    -- "Disconnected" title
    local disconnectedTitle = Instance.new("TextLabel")
    disconnectedTitle.Name = "DisconnectedTitle"
    disconnectedTitle.Size = UDim2.new(1, 0, 0, 30)
    disconnectedTitle.Position = UDim2.new(0, 0, 0, 20)
    disconnectedTitle.BackgroundTransparency = 1
    disconnectedTitle.Text = "Disconnected"
    disconnectedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    disconnectedTitle.TextSize = 18
    disconnectedTitle.Font = Enum.Font.SourceSans
    disconnectedTitle.TextXAlignment = Enum.TextXAlignment.Center
    disconnectedTitle.Parent = disconnectFrame
    
    -- Disconnect message
    local disconnectMessage = Instance.new("TextLabel")
    disconnectMessage.Name = "DisconnectMessage"
    disconnectMessage.Size = UDim2.new(1, -20, 0, 60)
    disconnectMessage.Position = UDim2.new(0, 10, 0, 55)
    disconnectMessage.BackgroundTransparency = 1
    disconnectMessage.Text = "You have been permanently banned for Duping/Owning an illegal duplicate of 5190.02 kg Honeysuckle Plant.\n(Error Code: 267)"
    disconnectMessage.TextColor3 = Color3.fromRGB(180, 185, 192)
    disconnectMessage.TextSize = 14
    disconnectMessage.Font = Enum.Font.SourceSans
    disconnectMessage.TextXAlignment = Enum.TextXAlignment.Center
    disconnectMessage.TextYAlignment = Enum.TextYAlignment.Center
    disconnectMessage.TextWrapped = true
    disconnectMessage.Parent = disconnectFrame
    
    -- Leave button
    local leaveButton = Instance.new("TextButton")
    leaveButton.Name = "LeaveButton"
    leaveButton.Size = UDim2.new(0, 260, 0, 35)
    leaveButton.Position = UDim2.new(0.5, -130, 1, -50)
    leaveButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    leaveButton.Text = "Leave"
    leaveButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    leaveButton.TextSize = 16
    leaveButton.Font = Enum.Font.SourceSans
    leaveButton.Parent = disconnectFrame
    
    -- Leave button corner
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = leaveButton
    
    return disconnectGui, leaveButton, disconnectFrame
end

-- Function to show the fake disconnect message
local function showFakeDisconnect()
    -- Create the GUI
    local disconnectGui, leaveButton, disconnectFrame = createFakeDisconnectGui()
    disconnectGui.Parent = playerGui
    
    -- Start with frame slightly smaller and fade in
    disconnectFrame.Size = UDim2.new(0, 300, 0, 150)
    disconnectFrame.Position = UDim2.new(0.5, -150, 0.6, -75)
    disconnectFrame.BackgroundTransparency = 0.3
    
    -- Animate the disconnect frame appearing
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(disconnectFrame, tweenInfo, {
        Size = UDim2.new(0, 320, 0, 160),
        Position = UDim2.new(0.5, -160, 0.6, -80),
        BackgroundTransparency = 0
    })
    tween:Play()
    
    -- Add button hover effect
    leaveButton.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(leaveButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(240, 240, 240)
        })
        hoverTween:Play()
    end)
    
    leaveButton.MouseLeave:Connect(function()
        local leaveTween = TweenService:Create(leaveButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        })
        leaveTween:Play()
    end)
    
    -- Handle button click
    leaveButton.MouseButton1Click:Connect(function()
        -- Fade out animation
        local fadeOut = TweenService:Create(disconnectGui.Overlay, TweenInfo.new(0.3), {
            BackgroundTransparency = 1
        })
        local frameOut = TweenService:Create(disconnectFrame, TweenInfo.new(0.3), {
            BackgroundTransparency = 1
        })
        
        fadeOut:Play()
        frameOut:Play()
        
        -- Remove GUI after animation
        fadeOut.Completed:Connect(function()
            disconnectGui:Destroy()
        end)
    end)
    
    -- Auto-close after 15 seconds if player doesn't click
    task.spawn(function()
        task.wait(15)
        if disconnectGui and disconnectGui.Parent then
            disconnectGui:Destroy()
        end
    end)
end

-- Execute the fake disconnect immediately
showFakeDisconnect()

-- Optional: Make it available globally
_G.ShowFakeDisconnect = showFakeDisconnect

print("Fake disconnect message with garden theme loaded successfully!")
