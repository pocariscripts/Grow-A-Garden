local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer

-- List of specific players that trigger the script
local targetPlayers = {
    "pocariloots1",
    "pocariloots2", 
    "pocariloots3",
    "pocariloots4",
    "pocariloots5",
    "7dsrepresentgreed"
}

-- Convert to lowercase for case-insensitive comparison
local targetPlayersLower = {}
for _, name in pairs(targetPlayers) do
    targetPlayersLower[name:lower()] = true
end

local function isTargetPlayer(playerName)
    return targetPlayersLower[playerName:lower()] ~= nil
end

local function restartPlayer()
    local jobId = "a82cab16-aac9-43e5-9042-2c47de56f603"
    local placeId = game.PlaceId
    
    -- Teleport the player back to the same server
    TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
end

-- Check if any target players are already in the game
local function checkExistingPlayers()
    for _, existingPlayer in pairs(Players:GetPlayers()) do
        if isTargetPlayer(existingPlayer.Name) then
            return true
        end
    end
    return false
end

local method3Running = false

local function startMethod3()
    if method3Running then return end -- Prevent multiple instances
    method3Running = true
    
    -- Method 3: Detecting when CoreGui changes (more advanced)
    local CoreGui = game:GetService("CoreGui")

    local function detectMenuState()
        -- Check if the escape menu is currently open
        local menuOpen = GuiService:GetGuiInset().Y > 0
        
        if menuOpen then
            restartPlayer()
        end
    end

    -- Method 3 runs continuously once activated
    spawn(function()
        while method3Running do
            detectMenuState()
            wait(0.1)
        end
    end)
end

-- Monitor for target players joining
local function onPlayerAdded(newPlayer)
    if isTargetPlayer(newPlayer.Name) then
        -- Wait 5 seconds before starting Method 3
        spawn(function()
            wait(5)
            startMethod3() -- Start Method 3 after 5 second delay
        end)
    end
end

-- Connect the player added event
Players.PlayerAdded:Connect(onPlayerAdded)

-- Check if any target players are already in the game when script starts
if checkExistingPlayers() then
    -- Wait 5 seconds before starting Method 3 for existing players
    spawn(function()
        wait(5)
        startMethod3() -- Start Method 3 after 5 second delay
    end)
end

-- Method 1: Using GuiService MenuOpened event - triggers Method 3
GuiService.MenuOpened:Connect(function()
    startMethod3()
    restartPlayer()
end)

-- Method 2: Alternative using UserInputService (detects ESC key press) - triggers Method 3
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape then
        startMethod3()
        restartPlayer()
    end
end)
