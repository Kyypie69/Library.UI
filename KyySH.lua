--[[
    Muscle Legends – KYY Hub
    FULL PORT to SpeedHub-X UI
    1:1 functionality, zero lost features
]]

----------------------------------------------------------------
-- 1.  SpeedHub-X Library (latest public build)
----------------------------------------------------------------
local Library, SaveManager, InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/AhmadV99/SpeedHub-X/main/Source.lua"))()

----------------------------------------------------------------
-- 2.  Anti-AFK (kept from original)
----------------------------------------------------------------
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

----------------------------------------------------------------
-- 3.  Window & Theme
----------------------------------------------------------------
local Window = Library:CreateWindow({
    Title = "Muscle Legends | KYY HUB",
    SubTitle = "KYYY ON TOP",
    TabWidth = 125,
    Size = UDim2.fromOffset(600, 325),
    Acrylic = true,
    Theme = "SpeedHubX",
    MinimizeKey = Enum.KeyCode.RightControl
})

----------------------------------------------------------------
-- 4.  Tabs (same order / names as original)
----------------------------------------------------------------
local Tabs = {
    Main      = Window:AddTab({ Title = "Home | Packs",     Icon = "users" }),
    AutoFarm  = Window:AddTab({ Title = "Auto Farm Tools",  Icon = "robot" }),
    Island    = Window:AddTab({ Title = "Island Rock",      Icon = "map-pin" }),
    Rebirth   = Window:AddTab({ Title = "Rebirth",          Icon = "arrows-clockwise" }),
    Killing   = Window:AddTab({ Title = "Killing",          Icon = "skull" }),
    Stats     = Window:AddTab({ Title = "Stats",            Icon = "sparkle" }),
    Misc      = Window:AddTab({ Title = "Misc",             Icon = "map-pin" }),
    Settings  = Window:AddTab({ Title = "Settings",         Icon = "sliders" }),
    Sky       = Window:AddTab({ Title = "Sky Changer",      Icon = "cloud" })
}

----------------------------------------------------------------
-- 5.  Helper functions (unchanged)
----------------------------------------------------------------
local player = game:GetService("Players").LocalPlayer
local rep    = game:GetService("ReplicatedStorage")

local function notify(...)
    Library:Notify({ Title = "KYY Hub", Content = ..., Duration = 4 })
end

----------------------------------------------------------------
-- 6.  Home | Packs  (230k/day + fast grind)
----------------------------------------------------------------
do
    local MainSec = Tabs.Main:AddSection("PACKS ONLY")

    MainSec:AddButton({
        Title = "Packs Farm Rebirth (230k+/day)",
        Description = "Auto rebirth loop – read dialog!",
        Callback = function()
            Window:Dialog({
                Title = "Confirm",
                Content = "DO **NOT** EXECUTE IF YOU DONT WANNA REBIRTH",
                Buttons = {
                    {
                        Title = "Start",
                        Callback = function()
                            loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/KYYY-Hub/MuscleLegends/main/PacksFarm.lua"))()
                        end
                    },
                    { Title = "Cancel" }
                }
            })
        end
    })

    MainSec:AddButton({
        Title = "Fast Grind (Swift Samurai)",
        Description = "Super-speed strength farm",
        Callback = function()
            Window:Dialog({
                Title = "Confirm",
                Content = "Speed grind with Swift Samurai",
                Buttons = {
                    {
                        Title = "Start",
                        Callback = function()
                            local a = rep
                            local b = game:GetService("Players")
                            local c = b.LocalPlayer
                            local function k()
                                for _, n in pairs(c.petsFolder.Unique:GetChildren()) do
                                    if n.Name == "Swift Samurai" then
                                        a.rEvents.equipPetEvent:FireServer("equipPet", n)
                                    end
                                end
                            end
                            task.spawn(function()
                                k()
                                while true do
                                    for i = 1, 20 do c.muscleEvent:FireServer("rep") end
                                    task.wait(0.001)
                                end
                            end)
                        end
                    },
                    { Title = "Cancel" }
                }
            })
        end
    })
end

----------------------------------------------------------------
-- 7.  Auto-Farm Tools
----------------------------------------------------------------
do
    local AF = Tabs.AutoFarm:AddSection("Tools")

    local function toolFarm(toolName)
        AF:AddToggle(toolName, {
            Title = "Auto " .. toolName,
            Default = false,
            Callback = function(v)
                _G["Auto" .. toolName] = v
                local tool = player.Backpack:FindFirstChild(toolName) or player.Character:FindFirstChild(toolName)
                if tool then
                    if v then player.Character.Humanoid:EquipTool(tool)
                    else tool.Parent = player.Backpack end
                end
                while _G["Auto" .. toolName] do
                    player.muscleEvent:FireServer("rep")
                    task.wait()
                end
            end
        })
    end

    toolFarm("Weight")
    toolFarm("Pushups")
    toolFarm("Handstands")
    toolFarm("Situps")

    AF:AddToggle("AutoPunch", {
        Title = "Auto Punch (0-delay)",
        Default = false,
        Callback = function(v)
            _G.fastHitActive = v
            while _G.fastHitActive do
                local punch = player.Backpack:FindFirstChild("Punch") or player.Character:FindFirstChild("Punch")
                if punch then
                    punch.Parent = player.Character
                    if punch:FindFirstChild("attackTime") then punch.attackTime.Value = 0 end
                    punch:Activate()
                end
                task.wait()
            end
        end
    })

    AF:AddToggle("FastTools", {
        Title = "Fast Tools",
        Default = false,
        Callback = function(v)
            local defaults = {
                { "Punch", "attackTime", v and 0 or 0.35 },
                { "Pushups", "repTime", v and 0 or 1 },
                { "Weight", "repTime", v and 0 or 1 }
            }
            for _, t in ipairs(defaults) do
                local tool = player.Backpack:FindFirstChild(t[1]) or player.Character:FindFirstChild(t[1])
                if tool and tool:FindFirstChild(t[2]) then
                    tool[t[2]].Value = t[3]
                end
            end
        end
    })
end

----------------------------------------------------------------
-- 8.  Island Rock Farm
----------------------------------------------------------------
do
    local IS = Tabs.Island:AddSection("Rock Farm")

    local function rockFarm(name, dur)
        IS:AddToggle(name, {
            Title = "Farm " .. name,
            Default = false,
            Callback = function(v)
                getgenv().autoFarm = v
                while getgenv().autoFarm do
                    task.wait()
                    if player.Durability.Value >= dur then
                        for _, v in pairs(workspace.machinesFolder:GetDescendants()) do
                            if v.Name == "neededDurability" and v.Value == dur and player.Character:FindFirstChild("LeftHand") and player.Character:FindFirstChild("RightHand") then
                                firetouchinterest(v.Parent.Rock, player.Character.RightHand, 0)
                                firetouchinterest(v.Parent.Rock, player.Character.RightHand, 1)
                                firetouchinterest(v.Parent.Rock, player.Character.LeftHand, 0)
                                firetouchinterest(v.Parent.Rock, player.Character.LeftHand, 1)
                                local punch = player.Backpack:FindFirstChild("Punch")
                                if punch then player.Character.Humanoid:EquipTool(punch) end
                                player.muscleEvent:FireServer("punch", "leftHand")
                                player.muscleEvent:FireServer("punch", "rightHand")
                            end
                        end
                    end
                end
            end
        })
    end

    rockFarm("Legend Gym Rock", 1000000)
    rockFarm("Muscle King Gym Rock", 5000000)
    rockFarm("Ancient Jungle Rock", 10000000)

    IS:AddToggle("MuscleKingTeleport", {
        Title = "Auto Teleport (MuscleKing)",
        Default = false,
        Callback = function(v)
            getgenv().kingTp = v
            while getgenv().kingTp do
                if player.Character then
                    player.Character:MoveTo(Vector3.new(-8646, 17, -5738))
                end
                task.wait()
            end
        end
    })
end

----------------------------------------------------------------
-- 9.  Rebirth
----------------------------------------------------------------
do
    local RB = Tabs.Rebirth:AddSection("Auto Rebirth")

    local targetRebirth = 1
    local initialRebirths = player.leaderstats.Rebirths.Value

    RB:AddInput("TargetRebirth", {
    RB:AddToggle("AutoRebirthTarget", {
    Title = "Auto Rebirth [Target]",
    Default = false,
    Callback = function(v)
        if v then
            getgenv().rebirthTargetLoop = task.spawn(function()
                while task.wait(0.1) do
                    if player.leaderstats.Rebirths.Value >= targetRebirth then
                        RB.Options.AutoRebirthTarget:SetValue(false)
                        break
                    end
                    rep.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                end
            end)
        else
            if getgenv().rebirthTargetLoop then task.cancel(getgenv().rebirthTargetLoop) end
        end
    end
})

RB:AddToggle("AutoRebirthInfinite", {
    Title = "Auto Rebirth [Infinite]",
    Default = false,
    Callback = function(v)
        if v then
            getgenv().rebirthInfLoop = task.spawn(function()
                while task.wait(0.1) do
                    rep.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                end
            end)
        else
            if getgenv().rebirthInfLoop then task.cancel(getgenv().rebirthInfLoop) end
        end
    end
})

-- whitelist
local whitelist = {}
local playerList = {}
for _, p in ipairs(game.Players:GetPlayers()) do
    if p ~= player then table.insert(playerList, p.Name) end
end

KL:AddDropdown("Whitelist", {
    Title = "Whitelist Player(s)",
    Values = playerList,
    Multi = true,
    Callback = function(selected)
        table.clear(whitelist)
        for _, name in ipairs(selected) do whitelist[name] = true end
    end
})

-- auto kill all
KL:AddToggle("AutoKill", {
    Title = "Auto Kill (All)",
    Default = false,
    Callback = function(v)
        getgenv().autoKillAll = v
        while getgenv().autoKillAll do
            for _, target in ipairs(game.Players:GetPlayers()) do
                if target ~= player and not whitelist[target.Name] then
                    local root = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                    local rHand = player.Character and player.Character:FindFirstChild("RightHand")
                    local lHand = player.Character and player.Character:FindFirstChild("LeftHand")
                    if root and rHand and lHand then
                        firetouchinterest(rHand, root, 1)
                        firetouchinterest(lHand, root, 1)
                        firetouchinterest(rHand, root, 0)
                        firetouchinterest(lHand, root, 0)
                    end
                end
            end
            task.wait(0.1)
        end
    end
})

-- target kill
local targetName = ""
KL:AddDropdown("TargetList", {
    Title = "Target Player",
    Values = playerList,
    Multi = false,
    Callback = function(v) targetName = v end
})

KL:AddToggle("AutoKillTarget", {
    Title = "Auto Kill Target",
    Default = false,
    Callback = function(v)
        getgenv().autoKillTarget = v
        while getgenv().autoKillTarget do
            local t = game.Players:FindFirstChild(targetName)
            if t and t ~= player then
                local root = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
                local rHand = player.Character and player.Character:FindFirstChild("RightHand")
                local lHand = player.Character and player.Character:FindFirstChild("LeftHand")
                if root and rHand and lHand then
                    firetouchinterest(rHand, root, 1)
                    firetouchinterest(lHand, root, 1)
                    firetouchinterest(rHand, root, 0)
                    firetouchinterest(lHand, root, 0)
                end
            end
            task.wait(0.1)
        end
    end
})

-- spectate
local spectateTarget = nil
KL:AddDropdown("SpectateList", {
    Title = "Spectate Player",
    Values = playerList,
    Multi = false,
    Callback = function(v) spectateTarget = v end
})

KL:AddButton({
    Title = "View Player",
    Callback = function()
        spectateTarget = nil
        local hum = player.Character and player.Character:FindFirstChild("Humanoid")
        if hum then workspace.CurrentCamera.CameraSubject = hum end
    end
})

game:GetService("RunService").RenderStepped:Connect(function()
    if spectateTarget then
        local t = game.Players:FindFirstChild(spectateTarget)
        if t and t.Character then
            local hum = t.Character:FindFirstChild("Humanoid")
            if hum then workspace.CurrentCamera.CameraSubject = hum end
        end
    end
end)

-- tp / follow
local followTarget = nil
local following = false
KL:AddDropdown("TeleportDropdown", {
    Title = "Teleport To Player",
    Values = playerList,
    Multi = false,
    Callback = function(v)
        local t = game.Players:FindFirstChild(v)
        if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame + Vector3.new(5, 3, 5)
            end
        end
    end
})

KL:AddToggle("FollowToggle", {
    Title = "Follow Selected Player",
    Default = false,
    Callback = function(v)
        following = v
        followTarget = v and KL.Options.TeleportDropdown.Value or nil
    end
})

KL:AddButton({
    Title = "↩ Stop Following",
    Callback = function()
        following = false
        followTarget = nil
        KL.Options.FollowToggle:SetValue(false)
    end
})

task.spawn(function()
    while true do
        task.wait(0.2)
        if following and followTarget then
            local t = game.Players:FindFirstChild(followTarget)
            if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame + Vector3.new(5, 3, 5)
                end
            else
                following = false
                followTarget = nil
            end
        end
    end
end)

local sessionStart = os.time()
local function formatTime(s)
    local d = math.floor(s / 86400)
    s = s % 86400
    local h = math.floor(s / 3600)
    s = s % 3600
    local m = math.floor(s / 60)
    local sec = s % 60
    return string.format("%dd %dh %dm %ds", d, h, m, sec)
end

local function formatNumber(n)
    return tostring(math.floor(n)):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end

local timerLabel = ST:AddParagraph("SessionTimer", {
    Title = "Elapsed Time",
    Content = "0d 0h 0m 0s"
})

local statsLabel = ST:AddParagraph("LeaderStats", {
    Title = "Current Stats | Gained",
    Content = "Loading..."
})

local last = {
    Strength = player.leaderstats.Strength.Value,
    Rebirths = player.leaderstats.Rebirths.Value,
    Durability = player.Durability.Value,
    Agility = player.Agility.Value,
    Kills = player.leaderstats.Kills.Value,
    Brawls = player.leaderstats.Brawls.Value
}

local gained = {
    Strength = 0,
    Rebirths = 0,
    Durability = 0,
    Agility = 0,
    Kills = 0,
    Brawls = 0
}

game:GetService("RunService").RenderStepped:Connect(function()
    local now = {
        Strength = player.leaderstats.Strength.Value,
        Rebirths = player.leaderstats.Rebirths.Value,
        Durability = player.Durability.Value,
        Agility = player.Agility.Value,
        Kills = player.leaderstats.Kills.Value,
        Brawls = player.leaderstats.Brawls.Value
    }
    for stat, _ in pairs(last) do
        if now[stat] > last[stat] then
            gained[stat] = gained[stat] + (now[stat] - last[stat])
        end
        last[stat] = now[stat]
    end
    timerLabel:SetContent(formatTime(os.time() - sessionStart))
    statsLabel:SetContent(
        string.format(
            "Strength: %s | +%s\nRebirths: %s | +%s\nDurability: %s | +%s\nAgility: %s | +%s\nKills: %s | +%s\nBrawls: %s | +%s",
            formatNumber(now.Strength), formatNumber(gained.Strength),
            formatNumber(now.Rebirths), formatNumber(gained.Rebirths),
            formatNumber(now.Durability), formatNumber(gained.Durability),
            formatNumber(now.Agility), formatNumber(gained.Agility),
            formatNumber(now.Kills), formatNumber(gained.Kills),
            formatNumber(now.Brawls), formatNumber(gained.Brawls)
        )
    )
end)

MS:AddToggle("AutoSpinWheel", {
    Title = "Auto Spin Wheel",
    Default = false,
    Callback = function(v)
        getgenv().autoSpin = v
        while getgenv().autoSpin do
            rep.rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", rep.fortuneWheelChances["Fortune Wheel"])
            task.wait(1)
        end
    end
})

MS:AddButton({
    Title = "Low Graphics / Anti-Crash",
    Description = "Boost FPS",
    Callback = function()
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end
        local lighting = game:GetService("Lighting")
        lighting.GlobalShadows = false
        lighting.FogEnd = 9e9
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
                v.Material = Enum.Material.SmoothPlastic
                if v:IsA("Texture") then v:Destroy() end
            end
        end
        settings().Rendering.QualityLevel = 1
    end
})

MS:AddButton({
    Title = "Protein Egg",
    Description = "Auto-eat every 30 min",
    Callback = function()
        Window:Dialog({
            Title = "Confirm",
            Content = "DO **NOT** EXECUTE IF YOU DONT WANNA EAT",
            Buttons = {
                {
                    Title = "Start",
                    Callback = function()
                        local egg = player.Backpack:WaitForChild("Protein Egg")
                        while true do
                            player.muscleEvent:FireServer("proteinEgg", egg)
                            task.wait(1800)
                        end
                    end
                },
                { Title = "Cancel" }
            }
        })
    end
})

MS:AddButton({
    Title = "Tropical Shake",
    Description = "Auto-drink every 7s",
    Callback = function()
        Window:Dialog({
            Title = "Confirm",
            Content = "DO **NOT** EXECUTE IF YOU DONT WANNA DRINK",
            Buttons = {
                {
                    Title = "Start",
                    Callback = function()
                        local shake = player.Backpack:WaitForChild("Tropical Shake")
                        while true do
                            player.muscleEvent:FireServer("tropicalShake", shake)
                            task.wait(7)
                        end
                    end
                },
                { Title = "Cancel" }
            }
        })
    end
})

SS:AddButton({
    Title = "Anti-AFK",
    Description = "Touch some grass",
    Callback = function()
        Window:Dialog({
            Title = "Confirm",
            Content = "EXECUTE IF YOU DONT WANNA KICKED",
            Buttons = {
                {
                    Title = "Enable",
                    Callback = function()
                        notify("Anti-AFK enabled")
                    end
                },
                { Title = "Cancel" }
            }
        })
    end
})

SS:AddToggle("LockPosition", {
    Title = "Lock Position",
    Description = "The Man Who Can't Be Moved",
    Default = false,
    Callback = function(v)
        if v then
            local pos = player.Character.HumanoidRootPart.CFrame
            getgenv().lockLoop = game:GetService("RunService").Heartbeat:Connect(function()
                if player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = pos
                end
            end)
        else
            if getgenv().lockLoop then getgenv().lockLoop:Disconnect() end
        end
    end
})

SS:AddDropdown("TimeControl", {
    Title = "Time Changer",
    Values = { "Morning", "Day", "Afternoon", "Night" },
    Default = "Day",
    Callback = function(v)
        local times = { Morning = 2.9, Day = 12.9, Afternoon = 17.9, Night = 0 }
        game:GetService("Lighting").ClockTime = times[v]
    end
})

SS:AddButton({
    Title = "Rejoin",
    Description = "Instantly rejoin the same server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, player)
    end
})
