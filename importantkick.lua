-- Fake Ban Message Script - Loadstring Compatible
-- Execute with: loadstring(game:HttpGet("your_url_here"))()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Check if GUI already exists and remove it
if playerGui:FindFirstChild("FakeBanGui") then
    playerGui.FakeBanGui:Destroy()
end

-- Create the fake ban GUI
local function createFakeBanGui()
    -- Main ScreenGui
    local banGui = Instance.new("ScreenGui")
    banGui.Name = "FakeBanGui"
    banGui.ResetOnSpawn = false
    banGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Dark background overlay
    local overlay = Instance.new("Frame")
    overlay.Name = "Overlay"
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.Position = UDim2.new(0, 0, 0, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(57, 59, 61)
    overlay.BorderSizePixel = 0
    overlay.Parent = banGui
    
    -- Main ban message frame
    local banFrame = Instance.new("Frame")
    banFrame.Name = "BanFrame"
    banFrame.Size = UDim2.new(0, 500, 0, 350)
    banFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    banFrame.BackgroundColor3 = Color3.fromRGB(44, 47, 51)
    banFrame.BorderSizePixel = 0
    banFrame.Parent = overlay
    
    -- Frame corner rounding
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = banFrame
    
    -- Frame border
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(220, 53, 69)
    border.Thickness = 2
    border.Parent = banFrame
    
    -- Roblox logo text
    local logoText = Instance.new("TextLabel")
    logoText.Name = "LogoText"
    logoText.Size = UDim2.new(1, 0, 0, 40)
    logoText.Position = UDim2.new(0, 0, 0, 10)
    logoText.BackgroundTransparency = 1
    logoText.Text = "ROBLOX"
    logoText.TextColor3 = Color3.fromRGB(255, 107, 107)
    logoText.TextSize = 24
    logoText.Font = Enum.Font.SourceSansBold
    logoText.Parent = banFrame
    
    -- Ban title
    local banTitle = Instance.new("TextLabel")
    banTitle.Name = "BanTitle"
    banTitle.Size = UDim2.new(1, -20, 0, 30)
    banTitle.Position = UDim2.new(0, 10, 0, 60)
    banTitle.BackgroundTransparency = 1
    banTitle.Text = "You have been kicked by this experience or its moderators."
    banTitle.TextColor3 = Color3.fromRGB(255, 71, 87)
    banTitle.TextSize = 18
    banTitle.Font = Enum.Font.SourceSansBold
    banTitle.TextWrapped = true
    banTitle.Parent = banFrame
    
    -- Moderation message label
    local modLabel = Instance.new("TextLabel")
    modLabel.Name = "ModLabel"
    modLabel.Size = UDim2.new(1, -20, 0, 25)
    modLabel.Position = UDim2.new(0, 10, 0, 100)
    modLabel.BackgroundTransparency = 1
    modLabel.Text = "Moderation message:"
    modLabel.TextColor3 = Color3.fromRGB(220, 221, 222)
    modLabel.TextSize = 16
    modLabel.Font = Enum.Font.SourceSansBold
    modLabel.TextXAlignment = Enum.TextXAlignment.Left
    modLabel.Parent = banFrame
    
    -- Ban reason box
    local reasonBox = Instance.new("Frame")
    reasonBox.Name = "ReasonBox"
    reasonBox.Size = UDim2.new(1, -40, 0, 120)
    reasonBox.Position = UDim2.new(0, 20, 0, 135)
    reasonBox.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
    reasonBox.BorderSizePixel = 0
    reasonBox.Parent = banFrame
    
    -- Reason box corner
    local reasonCorner = Instance.new("UICorner")
    reasonCorner.CornerRadius = UDim.new(0, 5)
    reasonCorner.Parent = reasonBox
    
    -- Reason box left border
    local reasonBorder = Instance.new("Frame")
    reasonBorder.Size = UDim2.new(0, 4, 1, 0)
    reasonBorder.Position = UDim2.new(0, 0, 0, 0)
    reasonBorder.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    reasonBorder.BorderSizePixel = 0
    reasonBorder.Parent = reasonBox
    
    -- Ban reason text
    local banReason = Instance.new("TextLabel")
    banReason.Name = "BanReason"
    banReason.Size = UDim2.new(1, -20, 1, -20)
    banReason.Position = UDim2.new(0, 15, 0, 10)
    banReason.BackgroundTransparency = 1
    banReason.Text = "You have been permanently banned for Duping/Owning an illegal duplicate of 5190.02 kg Honeysuckle Plant.\n\nuuid: {9fdae24-3b3c-4758-bbe5-3a06e97e99e1}\n(Error Code: 267)"
    banReason.TextColor3 = Color3.fromRGB(220, 221, 222)
    banReason.TextSize = 14
    banReason.Font = Enum.Font.SourceSans
    banReason.TextXAlignment = Enum.TextXAlignment.Left
    banReason.TextYAlignment = Enum.TextYAlignment.Top
    banReason.TextWrapped = true
    banReason.Parent = reasonBox
    
    -- OK button
    local okButton = Instance.new("TextButton")
    okButton.Name = "OKButton"
    okButton.Size = UDim2.new(0, 100, 0, 35)
    okButton.Position = UDim2.new(0.5, -50, 1, -50)
    okButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    okButton.Text = "OK"
    okButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    okButton.TextSize = 16
    okButton.Font = Enum.Font.SourceSansBold
    okButton.Parent = banFrame
    
    -- OK button corner
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 5)
    buttonCorner.Parent = okButton
    
    return banGui, okButton, banFrame
end

-- Function to show the fake ban message
local function showFakeBan()
    -- Create the GUI
    local banGui, okButton, banFrame = createFakeBanGui()
    banGui.Parent = playerGui
    
    -- Start with frame invisible
    banFrame.Size = UDim2.new(0, 0, 0, 0)
    banFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    -- Animate the ban frame appearing
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local tween = TweenService:Create(banFrame, tweenInfo, {
        Size = UDim2.new(0, 500, 0, 350),
        Position = UDim2.new(0.5, -250, 0.5, -175)
    })
    tween:Play()
    
    -- Add button hover effect
    okButton.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(okButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(185, 45, 58)
        })
        hoverTween:Play()
    end)
    
    okButton.MouseLeave:Connect(function()
        local leaveTween = TweenService:Create(okButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(220, 53, 69)
        })
        leaveTween:Play()
    end)
    
    -- Handle button click
    okButton.MouseButton1Click:Connect(function()
        -- Fade out animation
        local fadeOut = TweenService:Create(banGui.Overlay, TweenInfo.new(0.3), {
            BackgroundTransparency = 1
        })
        local frameOut = TweenService:Create(banFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        
        fadeOut:Play()
        frameOut:Play()
        
        -- Remove GUI after animation
        fadeOut.Completed:Connect(function()
            banGui:Destroy()
        end)
    end)
    
    -- Auto-close after 15 seconds if player doesn't click
    task.spawn(function()
        task.wait(15)
        if banGui and banGui.Parent then
            banGui:Destroy()
        end
    end)
end

-- Execute the fake ban immediately
showFakeBan()

-- Optional: Make it available globally
_G.ShowFakeBan = showFakeBan

print("Fake ban message loaded successfully!")
