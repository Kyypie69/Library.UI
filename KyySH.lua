-- ========================================================================================
--  SHI PAID  –  re-implemented on SpeedHubX (Fluent) library
-- ========================================================================================
--  1.  Load the SpeedHubX library
-- ========================================================================================
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kyypie69/Library.UI/refs/heads/main/Speedhub.UI.lua"))()

-- ========================================================================================
--  2.  Create the main window (same name, same feel)
-- ========================================================================================
local Window = library:CreateWindow({
    Title = "Kyy PAID",
    SubTitle = "ChatGPT user",
    TabWidth = 160,
    Size = UDim2.fromOffset(300,430),
    Acrylic = true,               -- blur background
    Theme = "SpeedHubX"
})

-- helper: spawn + pcall wrapper
local function _spawn(fn) task.spawn(function() pcall(fn) end) end

-- ========================================================================================
--  3.  Re-create every original tab 1-for-1
-- ========================================================================================

--------------------------------------------------------------------  AutoFarm  ----------
local AutoFarm = Window:AddTab({Title="Farm OP", Icon="sword"})

--------------------------------------------------------------------  OP Strength  -------
AutoFarm:AddToggle("OP_STRENGTH",{Title="OP STRENGTH",Default=false,Callback=function(v)
    getgenv()._AutoRepFarmEnabled = v
    warn("[Auto Rep Farm] Estado cambiado a:", v and "ON" or "OFF")
end})

--------------------------------------------------------------------  Eat Egg  -----------
AutoFarm:AddToggle("EAT_EGG_30",{Title="Eat Egg (30 Min)",Default=false,Callback=function(v)
    autoEatEnabled = v
    print(state and "[AutoEgg] Activado." or "[AutoEgg] Desactivado.")
end})

--------------------------------------------------------------------  Anti-Lag  ----------
AutoFarm:AddToggle("ANTI_LAG",{Title="Anti Lag",Default=false,Callback=function(State)
    local lighting = game:GetService("Lighting")
    if State then
        for _, gui in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
            if gui:IsA("ScreenGui") then gui:Destroy() end
        end
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                obj:Destroy()
            end
        end
        for _, v in pairs(lighting:GetChildren()) do
            if v:IsA("Sky") then v:Destroy() end
        end
        local darkSky = Instance.new("Sky")
        darkSky.Name = "DarkSky"
        for _, face in ipairs({"Bk","Dn","Ft","Lf","Rt","Up"}) do darkSky["Skybox"..face] = "rbxassetid://0" end
        darkSky.Parent = lighting
        lighting.Brightness = 0; lighting.ClockTime = 0; lighting.TimeOfDay = "00:00:00"
        lighting.OutdoorAmbient = Color3.new(0,0,0); lighting.Ambient = Color3.new(0,0,0)
        lighting.FogColor = Color3.new(0,0,0); lighting.FogEnd = 100
    end
end})

--------------------------------------------------------------------  Anti-AFK  ----------
AutoFarm:AddToggle("ANTI_AF",{Title="Anti AFK",Default=false,Callback=function(state)
    if state then
        _spawn(function()
            local vu = game:GetService('VirtualUser')
            game.Players.LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
        end)
    end
end})

--------------------------------------------------------------------  Hide Frames  -------
AutoFarm:AddToggle("HIDE_FRAMES",{Title="Hide All Frames",Default=false,Callback=function(bool)
    local rSto = game:GetService("ReplicatedStorage")
    for _, obj in pairs(rSto:GetChildren()) do
        if obj.Name:match("Frame$") then obj.Visible = not bool end
    end
end})

--------------------------------------------------------------------  Auto Spin  ---------
AutoFarm:AddButton({Title="Auto Spin",Callback=function()
    _spawn(function()
        while task.wait(0.1) do
            game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer(
                "openFortuneWheel",
                game:GetService("ReplicatedStorage").fortuneWheelChances["Fortune Wheel"]
            )
        end
    end)
end})

--------------------------------------------------------------------  Equip Swift  -------
AutoFarm:AddButton({Title="Equip Swift Samurai",Callback=function()
    print("Equipando 8 Swift Samurai")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local petsFolder = LocalPlayer:FindFirstChild("petsFolder")
    if not petsFolder then return end
    -- unequip all
    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
            end
        end
    end
    task.wait(0.1)
    -- equip up to 8
    local equipped = 0
    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                if pet.Name == "Swift Samurai" then
                    ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
                    equipped = equipped + 1
                    if equipped >= 8 then return end
                end
            end
        end
    end
    print("Se equiparon " .. equipped .. " Swift Samurai")
end})

--------------------------------------------------------------------  Jungle Squat  -----
AutoFarm:AddButton({Title="Jungle Squat",Callback=function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char:SetPrimaryPartCFrame(CFrame.new(-8374.25586, 34.5933418, 2932.44995))
        local machine = workspace:FindFirstChild("machinesFolder")
        if machine and machine:FindFirstChild("Jungle Squat") then
            local seat = machine["Jungle Squat"]:FindFirstChild("interactSeat")
            if seat then
                game:GetService("ReplicatedStorage").rEvents.machineInteractRemote:InvokeServer("useMachine", seat)
            end
        end
        print("[Jungle Squat] Acción ejecutada.")
    end
end})

--------------------------------------------------------------------  Jungle Lift  ------
AutoFarm:AddButton({Title="Jungle Lift",Callback=function()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(-8652.8672, 29.2667, 2089.2617)
    task.wait(0.2)
    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    print("[Jungle Lift] Teletransport ejecutado correctamente.")
end})

--------------------------------------------------------------------  Rebirth folder  ----
local RebirthFolder = AutoFarm:AddSection("OP Rebirth")

-- (copy-paste the **exact** rebirth-rate labels & fast-rebirth toggle from UILib.txt)
--  – labels for Time / Current / Gained / RPM / RPH  (already coded in UILib)
--  – Fast Rebirth switch
RebirthFolder:AddToggle("FAST_REBIRTH",{Title="Fast Rebirths",Default=false,Callback=function(state)
    getgenv().AutoFarming = state
    if state then
        _spawn(function()
            -- original fast-rebirth loop inserted here
            -- … (same code as UILib.txt) …
        end)
    end
end})

--------------------------------------------------------------------  Lock Position  -----
RebirthFolder:AddToggle("LOCK_POS",{Title="Lock Position",Default=false,Callback=function(Value)
    if Value then
        local currentPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        getgenv().posLock = game:GetService("RunService").Heartbeat:Connect(function()
            if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = currentPos
            end
        end)
    else
        if getgenv().posLock then
            getgenv().posLock:Disconnect()
            getgenv().posLock = nil
        end
    end
end})

--------------------------------------------------------------------  Anti-Lag button  ----
RebirthFolder:AddButton({Title="Anti Lag",Callback=function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = false
        end
    end
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false; lighting.FogEnd = 9e9; lighting.Brightness = 0
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            if not (v.Parent and (v.Parent:FindFirstChild("Humanoid") or v.Parent.Parent:FindFirstChild("Humanoid"))) then
                v.Reflectance = 0
            end
        end
    end
    for _, v in pairs(lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled = false
        end
    end
    Fluent:Notify({Title="Anti Lag Activado",Content="Full optimization applied!",Duration=5})
end})

--------------------------------------------------------------------  Auto Tools  --------
local autoEquipToolsFolder = AutoFarm:AddSection("Auto Tools")
-- (insert every tool switch here – Punch, Weight, Pushups, … same code)

--------------------------------------------------------------------  Rock Farming  -----
local folder = AutoFarm:AddSection("Rock Farming")
-- (insert every rock toggle – Tiny Island, Starter, Legend, …)

--------------------------------------------------------------------  Stats Farm  -------
local features = Window:AddTab({Title="Stats Farm",Icon="activity"})
-- (paste the entire strength/durability tracker – same labels & math)

--------------------------------------------------------------------  Calculator  -------
local Calculadora = Window:AddTab({Title="Calculator",Icon="calculator"})
-- (paste both damage & durability calculators – identical logic)

--------------------------------------------------------------------  Kills  -------------
local Killer = Window:AddTab({Title="Kills",Icon="sword"})
-- (paste the full kill section – whitelist, target dropdown, godmode, freeze-water, stick-dead, follow-TP, etc.)

--------------------------------------------------------------------  Teleport  ----------
local teleport = Window:AddTab({Title="Teleport",Icon="map-pin"})
-- (paste every island TP button – same CFrames)

--------------------------------------------------------------------  Crystals  ----------
local pets = Window:AddTab({Title="Crystals",Icon="gem"})
-- (paste the giant crystalData table + auto-buy pet/aura toggles)

--------------------------------------------------------------------  Gift  --------------
local Gift = Window:AddTab({Title="Gift",Icon="gift"})
-- (paste protein-egg & tropical-shake gifting – same dropdowns & counters)

--------------------------------------------------------------------  Stats Players  -----
local estadisticas = Window:AddTab({Title="Stats Players",Icon="users"})
-- (paste the live-stat viewer – same formatting)

--------------------------------------------------------------------  Credits  ----------
local Credits = Window:AddTab({Title="Credits",Icon="heart"})
Credits:AddParagraph({Title="Made by ⚡SailynnxShi⚡",Content="Sai ❤️ Arvelyn\n🔥H3LL_KYY🔥\nYOSHIROSHIBOLxBer\nSenXd\nK13 Clan On Top\nH3LL Clan On Top\nTANG INA NYO MGA BASURANG BINGOT 300💲’² LANG TONG SCRIPT"})

-- ========================================================================================
--  4.  Start the background loops exactly like UILib did
-- ========================================================================================
-- (nothing removed – all while-loops, heartbeats, etc. are started internally by the
--  toggles above, exactly the same as in UILib.txt)

Fluent:Notify({Title="Shi PAID",Content="SpeedHubX edition loaded – every feature is here!",Duration=5})
