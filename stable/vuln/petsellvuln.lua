while true do
task.wait()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
fireproximityprompt(workspace.NPCS.Steven.HumanoidRootPart.ProximityPrompt)

local notfav = nil
if Humanoid then
    local Backpack = LocalPlayer:WaitForChild("Backpack")
    for _, tool in ipairs(Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:GetAttribute("ItemType") == "Pet" then
            local favourited = tool:GetAttribute("d") 
            if not favourited then 
                Humanoid:EquipTool(tool)
                notfav = tool
                break
            end
        end
    end
end

task.wait(2)
local gui = LocalPlayer.PlayerGui:FindFirstChild("Billboard_UI")
if gui then
    local skibidi = gui:GetChildren()[4]
    if skibidi and skibidi:FindFirstChild("Frame") and skibidi.Frame:FindFirstChild("ImageButton") then
        firesignal(skibidi.Frame.ImageButton.MouseButton1Click)
    end
end

task.wait(1.26) -- Change depending on your ping (higher ping = increase delay, lower ping = decrease delay)
if Humanoid and notfav then
    local equippedTool = Character:FindFirstChildOfClass("Tool")
    if equippedTool == notfav then
        Humanoid:UnequipTools()
        task.wait(0.3)
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end
end
