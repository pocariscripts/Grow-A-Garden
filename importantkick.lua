-- Fake Kick Message Script for Roblox
-- Compatible with loadstring execution
-- Place this in ServerScriptService, StarterPlayerScripts, or execute via loadstring

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Get the local player
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Function to create the fake kick GUI
local function createFakeKickGUI()
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FakeKickGUI"
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 10
    screenGui.Parent = playerGui
    
    -- Create main frame (background)
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(1, 0, 1, 0)
    mainFrame.Position = UDim2.new(0, 0, 0, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Create kick message frame
    local kickFrame = Instance.new("Frame")
    kickFrame.Name = "KickFrame"
    kickFrame.Size = UDim2.new(0, 400, 0, 300)
    kickFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    kickFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    kickFrame.BorderSizePixel = 2
    kickFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    kickFrame.Parent = mainFrame
    
    -- Add corner radius to kick frame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = kickFrame
    
    -- Create title label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    titleLabel.BorderSizePixel = 0
    titleLabel.Text = "Disconnected"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = kickFrame
    
    -- Add corner to title
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = titleLabel
    
    -- Create message label
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "MessageLabel"
    messageLabel.Size = UDim2.new(1, -20, 1, -100)
    messageLabel.Position = UDim2.new(0, 10, 0, 60)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = "You have been kicked from this game:\n\nReason: Suspicious activity detected\n\nReconnect (Error Code: 267)"
    messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    messageLabel.TextScaled = true
    messageLabel.Font = Enum.Font.SourceSans
    messageLabel.TextWrapped = true
    messageLabel.Parent = kickFrame
    
    -- Create "Leave" button (fake)
    local leaveButton = Instance.new("TextButton")
    leaveButton.Name = "LeaveButton"
    leaveButton.Size = UDim2.new(0, 100, 0, 30)
    leaveButton.Position = UDim2.new(0.5, -50, 1, -40)
    leaveButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    leaveButton.BorderSizePixel = 1
    leaveButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
    leaveButton.Text = "Leave"
    leaveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    leaveButton.TextScaled = true
    leaveButton.Font = Enum.Font.SourceSans
    leaveButton.Parent = kickFrame
    
    -- Add corner to button
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = leaveButton
    
    -- Create close instruction (hidden initially)
    local closeInstruction = Instance.new("TextLabel")
    closeInstruction.Name = "CloseInstruction"
    closeInstruction.Size = UDim2.new(0, 300, 0, 30)
    closeInstruction.Position = UDim2.new(0.5, -150, 1, 20)
    closeInstruction.BackgroundTransparency = 1
    closeInstruction.Text = "Press ESC or click anywhere to close this fake message"
    closeInstruction.TextColor3 = Color3.fromRGB(200, 200, 200)
    closeInstruction.TextScaled = true
    closeInstruction.Font = Enum.Font.SourceSans
    closeInstruction.TextTransparency = 1
    closeInstruction.Parent = mainFrame
    
    -- Animate the kick frame appearing
    kickFrame.Size = UDim2.new(0, 0, 0, 0)
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local tween = TweenService:Create(kickFrame, tweenInfo, {Size = UDim2.new(0, 400, 0, 300)})
    tween:Play()
    
    -- Show close instruction after animation
    tween.Completed:Connect(function()
        local instructionTween = TweenService:Create(closeInstruction, TweenInfo.new(0.3), {TextTransparency = 0})
        instructionTween:Play()
    end)
    
    -- Function to close the fake kick message
    local function closeFakeKick()
        local closeTween = TweenService:Create(kickFrame, TweenInf
