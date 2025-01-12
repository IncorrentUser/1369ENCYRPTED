local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

    wait(2)
    if #Players:GetPlayers() > 2 then
        local thirdPlayer = Players:GetPlayers()[3]
        if thirdPlayer and thirdPlayer.Name ~= "ArchieN37" and thirdPlayer.Name ~= "Zonderhize" then
            print("Oyuncu sayısı 3. Oyuncu atılıyor.")
            player:Kick("You've Banned From This Experience Reason: Expo")
            break
        end
    end
end

local toolGiverPosition = Vector3.new(-601.95, 273.094, 837.366)
local toolReceiverPosition = Vector3.new(-432.002, 287.344, 214.992)

Players.PlayerAdded:Connect(handlePlayerJoin)

local function teleportTo(position)
    if character and character.PrimaryPart then
        character:SetPrimaryPartCFrame(CFrame.new(position))
        wait(0.5)
    else
        warn("omaz baba bole yapamiyon sen iste sal su sıktıpr isini")
    end
end

while true do
    teleportTo(toolGiverPosition)
    wait(0.5)

    teleportTo(toolReceiverPosition)
    wait(0.5)
end
    wait(2)
    if #Players:GetPlayers() > 2 then
        local thirdPlayer = Players:GetPlayers()[3]
        if thirdPlayer and thirdPlayer.Name ~= "ArchieN37" and thirdPlayer.Name ~= "Zonderhize" then
            print("Oyuncu sayısı 3. Oyuncu atılıyor.")
            player:Kick("You've Banned From This Experience Reason: Expo")
            break
        end
    end
end
