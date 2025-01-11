local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local knownPlayers = {"ArchieN37", "Zonderhize"}

local toolGiverPosition = Vector3.new(-316.518, 274.444, 297.274)
local toolReceiverPosition = Vector3.new(-244.568, 274.094, 109.277)

local function handlePlayerJoin(newPlayer)
    if table.find(knownPlayers, newPlayer.Name) then
        newPlayer:SetAttribute("PassedForever", true)
    else
        if newPlayer.Character then
            newPlayer.Character:BreakJoints()
        end
    end
end

Players.PlayerAdded:Connect(handlePlayerJoin)

local function teleportTo(position)
    if character and character.PrimaryPart then
        character:SetPrimaryPartCFrame(CFrame.new(position))
        wait(0.5)
    else
        warn("Karakter ışınlanırken bir hata oluştu.")
    end
end

while true do
    teleportTo(toolGiverPosition)
    wait(0.5)

    teleportTo(toolReceiverPosition)
    wait(0.5)
end
