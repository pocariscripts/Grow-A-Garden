-- Private Server Spam Join Script
-- This script spam joins a private server multiple times then stops

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local isRestarting = false

-- Your private server JobID
local PRIVATE_SERVER_JOBID = "a82cab16-aac9-43e5-9042-2c47de56f603"

-- Spam join settings
local MAX_JOINS = 5  -- Number of times to spam join
local JOIN_DELAY = 0.5  -- Delay between joins (in seconds)
local currentJoinCount = 0

local function spamJoinPrivateServer()
    if isRestarting then return end
    isRestarting = true
    
    local placeId = game.PlaceId
    
    print("Menu detected - starting spam join sequence...")
    print("Target Private Server JobID:", PRIVATE_SERVER_JOBID)
    print("Will attempt", MAX_JOINS, "joins with", JOIN_DELAY, "second delays")
    
    -- Spam join loop
    spawn(function()
        for i = 1, MAX_JOINS do
            currentJoinCount = i
            print("Spam join attempt", i, "of", MAX_JOINS)
            
            local success, err = pcall(function()
                TeleportService:TeleportToPlaceInstance(placeId, PRIVATE_SERVER_JOBID, player)
            end)
            
            if success then
                print("Join attempt", i, "sent successfully!")
                -- If successful, the player will be teleported and script will stop
                break
            else
                print("Join attempt", i, "failed:", err)
            end
            
            -- Wait before next attempt (except on last attempt)
            if i < MAX_JOINS then
                wait(JOIN_DELAY)
            end
        end
        
        if currentJoinCount >= MAX_JOINS then
            print("Spam join sequence completed. Stopping script.")
            isRestarting = false
        end
    end)
end

-- Primary detection method
GuiService.MenuOpened:Connect(function()
    spamJoinPrivateServer()
end)

-- Backup ESC key detection
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape then
        wait(0.1)
        spamJoinPrivateServer()
    end
end)

-- Continuous monitoring loop
spawn(function()
    while true do
        wait(0.1)
        
        if not isRestarting then
            local success, inset = pcall(function()
                return GuiService:GetGuiInset()
            end)
            
            if success and inset.Y > 0 then
                spamJoinPrivateServer()
            end
        end
    end
end)

-- Show current server info and script status
print("🔒 Private Server Spam Join Script Loaded!")
print("🌐 Current Server ID:", game.JobId)
print("🎯 Target Private Server:", PRIVATE_SERVER_JOBID)
print("📊 Max joins:", MAX_JOINS, "| Join delay:", JOIN_DELAY, "seconds")
print("👥 Players in current server:", #Players:GetPlayers())
print("⚠️  Opening menu will spam join the private server", MAX_JOINS, "times then stop")

-- Optional: Show GUI notification
spawn(function()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 450, 0, 120)
    frame.Position = UDim2.new(0.5, -225, 0, 20)
    frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
    frame.Parent = screenGui
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "🔒 Private Server Spam Join Active\n🎯 Target: " .. PRIVATE_SERVER_JOBID:sub(1, 20) .. "...\n📊 Will spam join " .. MAX_JOINS .. " times then stop\n⚠️ Opening menu = spam join sequence"
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true
    label.Parent = frame
    
    -- Fade out after 6 seconds
    wait(6)
    for i = 1, 30 do
        frame.BackgroundTransparency = i/30
        label.TextTransparency = i/30
        wait(0.1)
    end
    screenGui:Destroy()
end)
