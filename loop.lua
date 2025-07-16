-- Private Server Menu Detection + Rejoin Script
-- This script teleports to a specific private server when menu is opened

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local isRestarting = false

-- REPLACE THIS WITH YOUR PRIVATE SERVER JOBID
local PRIVATE_SERVER_JOBID = "a82cab16-aac9-43e5-9042-2c47de56f603"

-- You can also add multiple private server JobIDs to cycle through
local privateServerJobIds = {
    "a82cab16-aac9-43e5-9042-2c47de56f603"
}

local function getRandomPrivateServer()
    if #privateServerJobIds > 0 then
        local randomIndex = math.random(1, #privateServerJobIds)
        return privateServerJobIds[randomIndex]
    else
        return PRIVATE_SERVER_JOBID
    end
end

local function restartToPrivateServer()
    if isRestarting then return end
    isRestarting = true
    
    local placeId = game.PlaceId
    local targetJobId = getRandomPrivateServer()
    
    print("Menu detected - teleporting to private server...")
    print("Target Private Server JobID:", targetJobId)
    
    -- Small delay to ensure detection works properly
    wait(0.1)
    
    -- Teleport to specific private server
    local success, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(placeId, targetJobId, player)
    end)
    
    if not success then
        print("Private server teleport failed:", err)
        print("Make sure the JobID is correct and the private server is active")
        -- Reset flag so it can try again
        isRestarting = false
    else
        print("Successfully teleporting to private server!")
    end
end

-- Primary detection method
GuiService.MenuOpened:Connect(function()
    restartToPrivateServer()
end)

-- Backup ESC key detection
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape then
        wait(0.1)
        restartToPrivateServer()
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
                restartToPrivateServer()
            end
        end
    end
end)
