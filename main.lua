local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local knownPlayers = {"ArchieN37", "Zonderhize", "PassedForever"}

local toolGiverPosition = Vector3.new(-601.95, 273.094, 837.366)
local toolReceiverPosition = Vector3.new(-432.002, 287.344, 214.992)

local function checkNewPlayer()
    for _, newPlayer in pairs(Players:GetPlayers()) do
        if not table.find(knownPlayers, newPlayer.Name) then
            if newPlayer.Character then
                newPlayer.Character:BreakJoints() 
            end
        end
    end
end

while true do
    checkNewPlayer()  -- Yeni oyuncuları kontrol et

    teleportTo(toolGiverPosition)
    wait(0.5)

    teleportTo(toolReceiverPosition)
    wait(0.5)
end

local function teleportTo(position)
    if character and character.PrimaryPart then
        character:SetPrimaryPartCFrame(CFrame.new(position))
        wait(0.5)
    else
        warn("yapamadın ki baba olmadı iste")
    end
end
