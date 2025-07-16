local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer

local function restartPlayer()
    local jobId = "a82cab16-aac9-43e5-9042-2c47de56f603"
    local placeId = game.PlaceId
    
    -- Teleport the player back to the same server
    TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
end

-- Method 1: Using GuiService MenuOpened event
GuiService.MenuOpened:Connect(function()
    restartPlayer()
end)

-- Method 2: Alternative using UserInputService (detects ESC key press)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape then
        restartPlayer()
    end
end)

-- Method 3: Detecting when CoreGui changes (more advanced)
local CoreGui = game:GetService("CoreGui")

local function detectMenuState()
    -- Check if the escape menu is currently open
    local menuOpen = GuiService:GetGuiInset().Y > 0
    
    if menuOpen then
        restartPlayer()
    end
end

-- Optional: Check menu state periodically
spawn(function()
    while wait(0.1) do
        detectMenuState()
    end
end)
