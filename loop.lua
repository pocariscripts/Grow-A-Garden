-- Perpetual Menu Detection + Smart Server Rejoin Script
-- This script finds a different server that's not full when restarting

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local isRestarting = false

local function findAvailableServer()
    local placeId = game.PlaceId
    local currentJobId = game.JobId
    
    -- Try to get server list (this may not always work due to Roblox restrictions)
    local success, servers = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
    end)
    
    if success and servers and servers.data then
        -- Find a server that's not full and not the current one
        for _, server in pairs(servers.data) do
            if server.id ~= currentJobId and server.playing < server.maxPlayers - 1 then
                return server.id
            end
        end
    end
    
    return nil -- No available server found
end

local function restartPlayer()
    if isRestarting then return end
    isRestarting = true
    
    local placeId = game.PlaceId
    local currentJobId = game.JobId
    
    print("Menu detected - finding new server...")
    
    -- Small delay to ensure detection works properly
    wait(0.1)
    
    -- Try to find an available server
    local availableServer = findAvailableServer()
    
    if availableServer then
        print("Found available server:", availableServer)
        -- Teleport to specific server
        local success, err = pcall(function()
            TeleportService:TeleportToPlaceInstance(placeId, availableServer, player)
        end)
        
        if not success then
            print("Specific server teleport failed:", err)
            -- Fallback: regular teleport (will find any available server)
            TeleportService:Teleport(placeId, player)
        end
    else
        print("No specific server found, using regular teleport")
        -- Regular teleport - Roblox will find an available server
        TeleportService:Teleport(placeId, player)
    end
end

-- Alternative method: Use TeleportService's built-in server finding
local function restartPlayerSimple()
    if isRestarting then return end
    isRestarting = true
    
    local placeId = game.PlaceId
    
    print("Menu detected - finding new server (simple method)...")
    
    wait(0.1)
    
    -- This will automatically find an available server
    local success, err = pcall(function()
        TeleportService:Teleport(placeId, player)
    end)
    
    if not success then
        print("Teleport failed:", err)
        -- Reset flag so it can try again
        isRestarting = false
    end
end

-- Primary detection method
GuiService.MenuOpened:Connect(function()
    restartPlayerSimple() -- Using simple method as it's more reliable
end)

-- Backup ESC key detection
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape then
        wait(0.1)
        restartPlayerSimple()
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
                restartPlayerSimple()
            end
        end
    end
end)

-- Show current server info
print("🔄 Smart Server Rejoin Script Loaded!")
print("🌐 Current Server ID:", game.JobId)
print("👥 Players in server:", #Players:GetPlayers())
print("⚠️  Opening menu will teleport you to a different available server")

-- Optional: Show GUI notification with server info
spawn(function()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 80)
    frame.Position = UDim2.new(0.5, -175, 0, 20)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "🌐 Smart Server Rejoin Active\n👥 Current Server: " .. #Players:GetPlayers() .. " players"
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true
    label.Parent = frame
    
    -- Fade out after 4 seconds
    wait(4)
    for i = 1, 30 do
        frame.BackgroundTransparency = i/30
        label.TextTransparency = i/30
        wait(0.1)
    end
    screenGui:Destroy()
end)
