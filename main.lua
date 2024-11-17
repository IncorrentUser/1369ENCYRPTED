-- ══════════════════════════════════════
--               Core				
-- ══════════════════════════════════════
local Find = function(Table) 
    for i, v in pairs(Table or {}) do 
        if typeof(v) == 'table' then 
            return v 
        end 
    end 
end

local Options = Find(({...})) or {
    Keybind = 'Home',

    Language = {
        UI = 'tr', -- Arayüz dili Türkçe
        Words = 'tr' -- Kelime dili Türkçe
    },

    Experiments = {},

    Tempo = 2.5,
    Rainbow = false,
}

local Version = '1.5'
local Parent = gethui() or game:GetService('CoreGui');
local require = function(Name)
    return loadstring(game:HttpGet(('https://raw.githubusercontent.com/IncorrentUser/1369ENCYRPTED/refs/heads/main/%s.lua'):format(Name)))()
end

-- ══════════════════════════════════════
--              Services				
-- ══════════════════════════════════════
local TweenService = game:GetService('TweenService')
local Players = game:GetService('Players')
local LP = Players.LocalPlayer

-- ══════════════════════════════════════
--              Modules				
-- ══════════════════════════════════════
local UI = require("UI") -- Kullanıcı arayüzü modülü
local Notification = require("Notification") -- Bildirim modülü
local Extenso = require("Modules/Extenso") -- Sayıları sözcüklere çeviren modül
local Character = require("Modules/Character") -- Karakter hareketleri için modül
local RemoteChat = require("Modules/RemoteChat") -- Sohbet mesajları gönderme modülü
local Request = require("Modules/Request") -- HTTP istekleri için modül

-- ══════════════════════════════════════
--  	        Constants				
-- ══════════════════════════════════════
local Char = Character.new(LP)
local UIElements = UI.UIElements

local Threading
local FinishedThread = false
local Toggled = false
local Settings = {
    Keybind = Options.Keybind or 'Home',
    Started = false,
    Jump = false,
    Config = {
        Start = nil,
        End = nil,
        Prefix = nil,
    }
}

-- ══════════════════════════════════════
--              Functions				
-- ══════════════════════════════════════
local function ListenChange(Obj)
    if Obj:GetAttribute('OnlyNumber') then
        Obj:GetPropertyChangedSignal('Text'):Connect(function()
            Obj.Text = Obj.Text:gsub("[^%d]", "")
        end)
    end
    Obj.FocusLost:Connect(function()
        local CurrentText = Obj.Text
        if not CurrentText or string.match(CurrentText, "^%s*$") then return end
        Settings.Config[Obj.Parent.Name] = Obj.Text
    end)
end

local function EndThread(success)
    if Threading then
        if not FinishedThread then task.cancel(Threading) end
        Threading = nil
        FinishedThread = false
        Settings["Started"] = false
        Notification:Notify(success and 6 or 12, nil, nil, nil)
    end
end

local function DoJJ(n, prefix, jump)
    local success, extenso = Extenso:Convert(n)
    local prefix = prefix and prefix or ''
    if success then
        if jump then Char:Jump() end
        if table.find(Options.Experiments, 'hell_jacks_2024_02-dev') then
            for i = 1, #extenso do
                if jump then Char:Jump() end
                RemoteChat:Send(('%s'):format(extenso:sub(i, i)))
                task.wait(Options.Tempo)
            end
            if jump then Char:Jump() end
            RemoteChat:Send(('%s'):format(extenso .. prefix))
        else
            RemoteChat:Send(('%s'):format(extenso .. prefix))
        end
    end
end

local function StartThread()
    local Config = Settings.Config;
    if not Config["Start"] or not Config["End"] then return end
    if Threading then EndThread(false) return end
    Notification:Notify(5, nil, nil, nil)
    Threading = task.spawn(function()
        for i = Config.Start, Config.End do
            if table.find(Options.Experiments, 'hell_jacks_2024_02-dev') then
                DoJJ(i, Config["Prefix"], Settings["Jump"])
            else
                task.spawn(DoJJ, i, Config["Prefix"], Settings["Jump"])
            end
            if i ~= tonumber(Config.End) then task.wait(Options.Tempo) end
        end
        FinishedThread = true
        EndThread(true)
    end)
end

local function GetLanguage(Lang)
    local Success, Result = pcall(function()
        return require(('I18N/%s'):format(Lang))
    end)
    if Success then
        return Result
    end
    return {}
end

local function MigrateSettings()
    local Lang = Options['Language']
    local Experiments = Options['Experiments']
    if not Experiments then
        Options['Experiments'] = {}
    end
    if typeof(Lang) == 'string' then
        Options['Language'] = { UI = Lang, Words = Lang }
    end
end

MigrateSettings()

-- ══════════════════════════════════════
--                Main				
-- ══════════════════════════════════════
UI:SetVersion(Version)
UI:SetLanguage(Options.Language.UI)
UI:SetRainbow(Options.Rainbow)
UI:SetParent(Parent)

Notification:SetParent(UI.getUI())
Notification:SetLang(GetLanguage(Options.Language.UI))
Extenso:SetLang(GetLanguage(Options.Language.Words))

for i, v in pairs(UIElements["Box"]) do
    ListenChange(v)
end

UIElements["Circle"].MouseButton1Click:Connect(function()
    if Toggled then
        Settings["Jump"] = false
        Toggled = false
        TweenService:Create(UIElements["Circle"], TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(0.22, 0, 0.5, 0) }):Play()
        TweenService:Create(UIElements["Slide"], TweenInfo.new(0.3), { BackgroundColor3 = Color3.fromRGB(20, 20, 20) }):Play()
    else
        Settings["Jump"] = true
        Toggled = true
        TweenService:Create(UIElements["Circle"], TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(0.772, 0, 0.5, 0) }):Play()
        TweenService:Create(UIElements["Slide"], TweenInfo.new(0.3), { BackgroundColor3 = Color3.fromRGB(37, 150, 255) }):Play()
    end
end)

UIElements["Play"].MouseButton1Up:Connect(function()
    if not Settings.Config["Start"] or not Settings.Config["End"] then return end
    if not Settings["Started"] then
        Settings["Started"] = true
        StartThread()
    else
        Settings["Started"] = false
        EndThread(false)
    end
end)

Notification:SetupJJs(Options.Experiments)
Request:Post('https://scripts-zvyz.glitch.me/api/count')
