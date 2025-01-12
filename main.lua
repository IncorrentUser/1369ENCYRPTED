local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()


local toolGiverPosition = Vector3.new(-601.95, 273.094, 837.366)
local toolReceiverPosition = Vector3.new(-432.002, 287.344, 214.992)


local function teleportTo(position)
    if character and character.PrimaryPart then
        -- Işınlama
        character:SetPrimaryPartCFrame(CFrame.new(position))
        wait(0.5) 
    else
        warn("cidden sıkıntı")
    end
end


while true do

    teleportTo(toolGiverPosition)
    
    wait(0.5)

    teleportTo(toolReceiverPosition)
    
    wait(0.5)

end
