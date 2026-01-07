local a = {}
local b = game:GetService("TweenService")
local c = game:GetService("UserInputService")
local d = game:GetService("RunService")
local e = game:GetService("Players")
local f = game:GetService("CoreGui")
local g = e.LocalPlayer; local h = g:GetMouse()
local RS = game:GetService("RunService")
local hue = 0
RS.Heartbeat:Connect(function(dt)
    hue = (hue + dt * 0.3) % 1          -- 0-1 rainbow cycle speed
    Primary = Color3.fromHSV(hue, 1, 1) -- full-saturation rainbow
end)

local i = { 
    Primary = Color3.new(1,1,1),   -- placeholder; will be overwritten immediately
    Secondary = Color3.fromRGB(0, 255, 255), -- Cyan
    Accent = Color3.fromRGB(255, 255, 0), -- Yellow
    Success = Color3.fromRGB(0, 255, 0), -- Green
    Minimize = Color3.fromRGB(255, 165, 0), -- Orange
    Warning = Color3.fromRGB(255, 140, 0), -- Orange
    Error = Color3.fromRGB(255, 0, 0), -- Red
    Background = Color3.fromRGB(10, 10, 10), -- Near black
    Surface = Color3.fromRGB(20, 20, 20), -- Dark surface
    Glass = Color3.fromRGB(15, 15, 15), -- Dark glass
    Text = Color3.fromRGB(30, 30, 30), -- Dark text
    TextMuted = Color3.fromRGB(60, 60, 60), -- Muted dark text
    Border = Color3.fromRGB(255, 255, 255), -- White border for contrast
    Rainbow = true -- Rainbow effect flag
}
local j = { 
    ChevronRight = "rbxassetid://10709759895", 
    ChevronDown = "rbxassetid://10709767827", 
    X = "rbxassetid://10747384394", 
    Check = "rbxassetid://10709790644", 
    Settings = "rbxassetid://10734950309", 
    User = "rbxassetid://10747373176", 
    Home = "rbxassetid://10723407389", 
    Search = "rbxassetid://7733921320", 
    Bell = "rbxassetid://10709775704", 
    Heart = "rbxassetid://10723406885", 
    Star = "rbxassetid://10734966248", 
    Plus = "rbxassetid://10734924532", 
    Minus = "rbxassetid://10734896206", 
    Edit = "rbxassetid://10734883598", 
    Trash = "rbxassetid://10747362393", 
    Eye = "rbxassetid://10723346959", 
    EyeOff = "rbxassetid://10723346871", 
    Lock = "rbxassetid://10723434711", 
    Unlock = "rbxassetid://10747366027", 
    Download = "rbxassetid://10723344270", 
    Upload = "rbxassetid://10747366434", 
    RefreshCw = "rbxassetid://10734933056", 
    Copy = "rbxassetid://10709812159", 
    ExternalLink = "rbxassetid://10723346684", 
    Info = "rbxassetid://10723415903", 
    AlertCircle = "rbxassetid://10709752996", 
    CheckCircle = "rbxassetid://10709790387", 
    XCircle = "rbxassetid://10747383819"
}
local k = { 
    Fast = TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), 
    Normal = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), 
    Slow = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), 
    Spring = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
    Bounce = TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), 
    SlideIn = TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    Rainbow = TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), -- Smooth rainbow tween
    Blink = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut) -- Blinking tween
}
local l = { 
    MainColor = i.Primary, 
    MinSize = Vector2.new(420, 300), 
    ToggleKey = Enum.KeyCode.RightShift, 
    CanResize = true, 
    BlurEnabled = true, 
    SoundEnabled = true,
    RainbowEnabled = true, -- Enable rainbow effects
    BlinkSpeed = 0.5 -- Blinking speed
}
local m = {}
local function n(o, p, q)
    if p and o < p then return p end; if q and o > q then return q end; return o
end; local function r(s)
    s = s or {}
    if s.Parent then return s.Parent end; if d:IsStudio() then
        local t = e.LocalPlayer; if t then
            local u = t:FindFirstChild("PlayerGui")
            if u then return u end
        end; return game:GetService("StarterGui")
    end; local t = e.LocalPlayer; if t then
        local u = t:FindFirstChild("PlayerGui")
        if u then return u end
    end; if gethui then
        local v, w = pcall(gethui)
        if v and w then return w end
    end; return f
end; local function x()
    local y = { f }
    local t = e.LocalPlayer; if t then
        local u = t:FindFirstChild("PlayerGui")
        if u then table.insert(y, u) end
    end; if gethui then
        local v, w = pcall(gethui)
        if v and w then table.insert(y, w) end
    end; for z, A in ipairs(y) do
        local B = A:FindFirstChild("RainbowV2")
        if B then B:Destroy() end
    end
end; 

-- Enhanced rainbow color generator with blinking
local function getRainbowColor(time, speed, blinkSpeed)
    speed = speed or 1
    blinkSpeed = blinkSpeed or 0.5
    local hue = (time * speed) % 360
    local blink = math.sin(time * blinkSpeed * 10) * 0.3 + 0.7 -- Blinking effect
    return Color3.fromHSV(hue / 360, 0.8, blink)
end

function m.Tween(C, D, E, F)
    local G = b:Create(C, D, E)
    if F then G.Completed:Connect(F) end; G:Play()
    return G
end; function m.CreateIcon(H, I, J, K)
    J = J or UDim2.new(0, 20, 0, 20)
    K = K or UDim2.new(0, 0, 0, 0)
    local L = Instance.new("ImageLabel")
    L.Size = J; L.Position = K; L.BackgroundTransparency = 1; L.Image = j[I] or ""
    L.ImageColor3 = Color3.new(1, 1, 1); -- White icons for contrast
    L.ScaleType = Enum.ScaleType.Fit; L.Parent = H; return L
end; function m.CreateGlassEffect(H, M)
    M = M or 0.15; local N = Instance.new("Frame")
    N.Name = "GlassEffect"
    N.Size = UDim2.new(1, 0, 1, 0)
    N.BackgroundColor3 = i.Glass; N.BackgroundTransparency = M; N.BorderSizePixel = 0; N.Parent = H; local O = Instance
    .new("UICorner")
    O.CornerRadius = UDim.new(0, 12)
    O.Parent = N; local P = Instance.new("UIStroke")
    P.Color = i.Border; P.Thickness = 2; P.Transparency = 0.3; P.Parent = N; return N
end; function m.CreateShadow(H, J, Q)
    J = J or 8; Q = Q or 3; local R = Instance.new("ImageLabel")
    R.Name = "DropShadow"
    R.Size = UDim2.new(1, J * 2, 1, J * 2)
    R.Position = UDim2.new(0, -J + Q, 0, -J + Q)
    R.BackgroundTransparency = 1; R.Image = ""
    R.ImageColor3 = Color3.new(0, 0, 0)
    R.ImageTransparency = 0.6; R.ScaleType = Enum.ScaleType.Slice; R.SliceCenter = Rect.new(10, 10, 10, 10)
    R.ZIndex = H.ZIndex - 1; R.Parent = H.Parent; return R
end; function m.CreateRipple(S, T, U) spawn(function()
        S.ClipsDescendants = true; local V = Instance.new("Frame")
        V.Size = UDim2.new(0, 0, 0, 0)
        V.BackgroundColor3 = Color3.new(1, 1, 1); -- White ripple
        V.BackgroundTransparency = 0.8; V.BorderSizePixel = 0; V.Parent = S; local O =
        Instance.new("UICorner")
        O.CornerRadius = UDim.new(1, 0)
        O.Parent = V; local J = math.max(S.AbsoluteSize.X, S.AbsoluteSize.Y) * 2; V.Position = UDim2.new(0,
            T - S.AbsolutePosition.X, 0, U - S.AbsolutePosition.Y)
        m.Tween(V, k.Rainbow,
            { Size = UDim2.new(0, J, 0, J), Position = UDim2.new(0, T - S.AbsolutePosition.X - J / 2, 0,
                U - S.AbsolutePosition.Y - J / 2), BackgroundTransparency = 1 }, function() V:Destroy() end)
    end) end; function m.AddHoverEffect(W, X, Y)
    W.MouseEnter:Connect(function() m.Tween(W, k.Fast,
            X or { BackgroundTransparency = math.max(0, W.BackgroundTransparency - 0.1) }) end)
    W.MouseLeave:Connect(function() m.Tween(W, k.Fast, Y or { BackgroundTransparency = W.BackgroundTransparency + 0.1 }) end)
end; local Z = {}
Z.Notifications = {}
Z.Container = nil; function Z:Initialize(_)
    self.Container = Instance.new("Frame")
    self.Container.Name = "NotificationContainer"
    self.Container.Size = UDim2.new(0, 300, 1, 0)
    self.Container.Position = UDim2.new(1, -320, 0, 20)
    self.Container.BackgroundTransparency = 1; self.Container.Parent = _; local a0 = Instance.new("UIListLayout")
    a0.SortOrder = Enum.SortOrder.LayoutOrder; a0.Padding = UDim.new(0, 10)
    a0.Parent = self.Container
end; function Z:CreateNotification(a1, a2, a3, a4)
    a3 = a3 or "Info"
    a4 = a4 or 5; local a5 = Instance.new("Frame")
    a5.Size = UDim2.new(1, 0, 0, 80)
    a5.BackgroundColor3 = i.Surface; a5.BackgroundTransparency = 0.1; a5.BorderSizePixel = 0; a5.Parent = self.Container; local O =
    Instance.new("UICorner")
    O.CornerRadius = UDim.new(0, 12)
    O.Parent = a5; local P = Instance.new("UIStroke")
    P.Thickness = 2; P.Transparency = 0.3; P.Parent = a5; if a3 == "Success" then P.Color = i.Success elseif a3 == "Warning" then P.Color =
        i.Warning elseif a3 == "Error" then P.Color = i.Error else P.Color = i.Primary end; local I = "Info"
    if a3 == "Success" then I = "CheckCircle" elseif a3 == "Warning" then I = "AlertCircle" elseif a3 == "Error" then I =
        "XCircle" end; local L = m.CreateIcon(a5, I, UDim2.new(0, 24, 0, 24), UDim2.new(0, 15, 0, 15))
    L.ImageColor3 = Color3.new(1, 1, 1); -- White icon
    local a6 = Instance.new("TextLabel")
    a6.Size = UDim2.new(1, -90, 0, 25)
    a6.Position = UDim2.new(0, 50, 0, 10)
    a6.BackgroundTransparency = 1; a6.Text = a1; a6.TextColor3 = Color3.new(1, 1, 1); a6.TextSize = 16; a6.TextXAlignment = Enum
    .TextXAlignment.Left; a6.Font = Enum.Font.GothamMedium; a6.Parent = a5; local a7 = Instance.new("TextLabel")
    a7.Size = UDim2.new(1, -90, 0, 20)
    a7.Position = UDim2.new(0, 50, 0, 35)
    a7.BackgroundTransparency = 1; a7.Text = a2; a7.TextColor3 = Color3.new(0.8, 0.8, 0.8); a7.TextSize = 14; a7.TextXAlignment = Enum
    .TextXAlignment.Left; a7.Font = Enum.Font.Gotham; a7.TextWrapped = true; a7.Parent = a5; local a8 = Instance.new(
    "TextButton")
    a8.Size = UDim2.new(0, 20, 0, 20)
    a8.Position = UDim2.new(1, -30, 0, 10)
    a8.BackgroundTransparency = 1; a8.Text = ""
    a8.Parent = a5; local a9 = m.CreateIcon(a8, "X", UDim2.new(0, 16, 0, 16), UDim2.new(0, 2, 0, 2))
    a9.ImageColor3 = Color3.new(1, 1, 1); a6.TextTransparency = 1; a7.TextTransparency = 1; L.ImageTransparency = 1; a9.ImageTransparency = 1; a5.Position =
    UDim2.new(1, 50, 0, 0)
    a5.BackgroundTransparency = 1; m.Tween(a5, k.Spring, { Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 0.1 })
    m.Tween(a6, k.Fast, { TextTransparency = 0 })
    m.Tween(a7, k.Fast, { TextTransparency = 0 })
    m.Tween(L, k.Fast, { ImageTransparency = 0 })
    m.Tween(a9, k.Fast, { ImageTransparency = 0 })
    local function aa()
        m.Tween(a6, k.Fast, { TextTransparency = 1 })
        m.Tween(a7, k.Fast, { TextTransparency = 1 })
        m.Tween(L, k.Fast, { ImageTransparency = 1 })
        m.Tween(a9, k.Fast, { ImageTransparency = 1 })
        m.Tween(a5, k.Fast, { Position = UDim2.new(1, 50, 0, 0), BackgroundTransparency = 1 }, function() a5:Destroy() end)
    end; a8.MouseButton1Click:Connect(aa)
    spawn(function()
        wait(a4)
        if a5.Parent then aa() end
    end)
    table.insert(self.Notifications, a5)
    return a5
end; function a.new(s)
    s = s or {}
    for ab, ac in pairs(l) do if s[ab] == nil then s[ab] = ac end end; x()
    local _ = Instance.new("ScreenGui")
    _.Name = "RainbowV2"
    _.ResetOnSpawn = false; _.Parent = r(s)
    Z:Initialize(_)
    c.InputBegan:Connect(function(ad, ae) if not ae and ad.KeyCode == s.ToggleKey then _.Enabled = not _.Enabled end end)
    local af = { ScreenGui = _, Config = s, Windows = {}, NotificationSystem = Z }
    function af:Notify(a1, a2, a3, a4) return self.NotificationSystem:CreateNotification(a1, a2, a3, a4) end; local ag = { 
        Default = { Primary = i.Primary, Minimize = i.Minimize, Accent = i.Accent, Background = i.Background, Surface = i.Surface, Glass = i.Glass, Text = i.Text, TextMuted = i.TextMuted, Border = i.Border, Error = i.Error, Success = i.Success, Warning = i.Warning }, 
        Rainbow = { -- Custom Rainbow theme
            Primary = Color3.fromRGB(255, 0, 255), -- Magenta
            Minimize = Color3.fromRGB(255, 165, 0), -- Orange
            Accent = Color3.fromRGB(255, 215, 0), -- Gold
            Background = Color3.fromRGB(10, 10, 10), -- Near black
            Surface = Color3.fromRGB(20, 20, 20), -- Dark surface
            Glass = Color3.fromRGB(15, 15, 15), -- Dark glass
            Text = Color3.fromRGB(30, 30, 30), -- Dark text
            TextMuted = Color3.fromRGB(60, 60, 60), -- Muted dark text
            Border = Color3.fromRGB(255, 255, 255), -- White border
            Error = Color3.fromRGB(255, 0, 0), -- Red
            Success = Color3.fromRGB(0, 255, 0), -- Green
            Warning = Color3.fromRGB(255, 165, 0) -- Orange
        }
    }
    
    -- Enhanced rainbow animation system with blinking
    local rainbowConnection = nil
    local rainbowObjects = {}
    local blinkObjects = {}
    local startTime = tick()
    
    local function startRainbowAnimation()
        if rainbowConnection then return end
        startTime = tick()
        rainbowConnection = d.RenderStepped:Connect(function()
            local currentTime = tick() - startTime
            local rainbowColor = getRainbowColor(currentTime, 0.5, l.BlinkSpeed)
            
            -- Update rainbow objects with blinking
            for obj, properties in pairs(rainbowObjects) do
                if obj.Parent then
                    for prop, _ in pairs(properties) do
                        if prop == "BackgroundColor3" then
                            obj.BackgroundColor3 = rainbowColor
                        elseif prop == "TextColor3" then
                            obj.TextColor3 = rainbowColor
                        elseif prop == "ImageColor3" then
                            obj.ImageColor3 = rainbowColor
                        elseif prop == "BorderColor3" then
                            obj.BorderColor3 = rainbowColor
                        end
                    end
                else
                    rainbowObjects[obj] = nil
                end
            end
            
            -- Update blink objects
            for obj, properties in pairs(blinkObjects) do
                if obj.Parent then
                    local blinkAlpha = math.sin(currentTime * 5) * 0.5 + 0.5
                    for prop, _ in pairs(properties) do
                        if prop == "BackgroundTransparency" then
                            obj.BackgroundTransparency = blinkAlpha * 0.5 + 0.3
                        elseif prop == "TextTransparency" then
                            obj.TextTransparency = blinkAlpha * 0.3 + 0.1
                        elseif prop == "ImageTransparency" then
                            obj.ImageTransparency = blinkAlpha * 0.3 + 0.1
                        end
                    end
                else
                    blinkObjects[obj] = nil
                end
            end
        end)
    end
    
    local function registerRainbowObject(obj, properties)
        rainbowObjects[obj] = properties
        startRainbowAnimation()
    end
    
    local function registerBlinkObject(obj, properties)
        blinkObjects[obj] = properties
        startRainbowAnimation()
    end
    
    function af:SetTheme(ah)
        local ai = ag[ah]
        if not ai then return end; for ab, ac in pairs(ai) do i[ab] = ac end; self.Config.MainColor = ai.Primary or
        self.Config.MainColor; for z, aj in ipairs(self.Windows) do if aj and aj.Window and aj.Window.Parent then
                local ak = aj.Window; ak.BackgroundTransparency = 1; local N = ak:FindFirstChild("GlassEffect")
                if N then N.BackgroundColor3 = i.Glass or i.Background else for z, al in ipairs(ak:GetChildren()) do if al:IsA("Frame") and al.Name ~= "TitleBar" then al.BackgroundColor3 =
                            i.Surface end end end; local am = ak:FindFirstChild("TitleBar")
                if am then
                    am.BackgroundColor3 = i.Primary; local an = am:FindFirstChild("TitleBottomCover")
                    if an then an.BackgroundColor3 = i.Primary end; local ao = am:FindFirstChild("Minimize")
                    if ao then ao.BackgroundColor3 = i.Minimize end; local ap = am:FindFirstChild("Close")
                    if ap then ap.BackgroundColor3 = i.Error end; local aq = am:FindFirstChild("Title")
                    if aq then aq.TextColor3 = Color3.new(1, 1, 1) end -- White text for contrast
                end; for z, ar in ipairs(ak:GetDescendants()) do if ar:IsA("TextButton") and ar.Name:match("^Tab_%d+") then
                        ar.BackgroundColor3 = i.Surface; for z, as in ipairs(ar:GetChildren()) do if as:IsA("TextLabel") then as.TextColor3 =
                                Color3.new(1, 1, 1) elseif as:IsA("ImageLabel") then as.ImageColor3 = Color3.new(1, 1, 1) end end
                    elseif ar:IsA("Frame") and ar.Name ~= "TitleBar" and ar.Name ~= "GlassEffect" then ar.BackgroundColor3 =
                        i.Surface end end
            end end; if self.NotificationSystem and self.NotificationSystem.Container then for z, at in ipairs(self.NotificationSystem.Container:GetChildren()) do if at:IsA("Frame") then
                    at.BackgroundColor3 = i.Surface; for z, al in ipairs(at:GetDescendants()) do
                        if al:IsA("TextLabel") then al.TextColor3 = al.Name == "Title" and Color3.new(1, 1, 1) or Color3.new(0.8, 0.8, 0.8) end; if al:IsA("ImageLabel") then al.ImageColor3 =
                            Color3.new(1, 1, 1) end
                    end
                end end end
    end; function af:CreateWindow(a1, au)
        a1 = a1 or "Rainbow Hub"
        au = au or {}
        local av = #self.Windows + 1; local aw = Instance.new("Frame")
        aw.Name = "RainbowWindow_" .. av; aw.Size = UDim2.new(0, s.MinSize.X, 0, s.MinSize.Y)
        aw.Position = UDim2.new(0, 50 + (av - 1) * 30, 0, 50 + (av - 1) * 30)
        aw.BackgroundTransparency = 1; aw.BorderSizePixel = 0; aw.Active = true; aw.Parent = _; local ax = m
        .CreateGlassEffect(aw, 0.3)
        m.CreateShadow(aw, 8, 4)
        
        -- Add rainbow glow effect
        local glowFrame = Instance.new("Frame")
        glowFrame.Name = "RainbowGlow"
        glowFrame.Size = UDim2.new(1, 6, 1, 6)
        glowFrame.Position = UDim2.new(0, -3, 0, -3)
        glowFrame.BackgroundTransparency = 0.7
        glowFrame.BorderSizePixel = 0
        glowFrame.ZIndex = -1
        glowFrame.Parent = aw
        
        local glowCorner = Instance.new("UICorner")
        glowCorner.CornerRadius = UDim.new(0, 14)
        glowCorner.Parent = glowFrame
        
        registerRainbowObject(glowFrame, {BackgroundColor3 = true})
        registerBlinkObject(glowFrame, {BackgroundTransparency = true})
        
        local am = Instance.new("Frame")
        am.Name = "TitleBar"
        am.Size = UDim2.new(1, 0, 0, 50)
        am.BackgroundColor3 = i.Primary; am.BackgroundTransparency = 0.2; am.BorderSizePixel = 0; am.Parent = aw; local ay =
        Instance.new("UICorner")
        ay.CornerRadius = UDim.new(0, 12)
        ay.Parent = am; local an = Instance.new("Frame")
        an.Name = "TitleBottomCover"
        an.Size = UDim2.new(1, 0, 0, 12)
        an.Position = UDim2.new(0, 0, 1, -12)
        an.BackgroundColor3 = i.Primary; an.BackgroundTransparency = 0.2; an.BorderSizePixel = 0; an.Parent = am; local a6 =
        Instance.new("TextLabel")
        a6.Name = "Title"
        a6.Size = UDim2.new(1, -100, 1, 0)
        a6.Position = UDim2.new(0, 20, 0, 0)
        a6.BackgroundTransparency = 1; a6.Text = a1; a6.TextColor3 = Color3.new(1, 1, 1); -- White text
        a6.TextSize = 18; a6.TextXAlignment = Enum.TextXAlignment.Left; a6.Font = Enum.Font.GothamBold; a6.Parent = am
        
        -- Add white highlight to title with blinking
        local titleHighlight = Instance.new("TextLabel")
        titleHighlight.Size = UDim2.new(1, -100, 1, 0)
        titleHighlight.Position = UDim2.new(0, 20, 0, 0)
        titleHighlight.BackgroundTransparency = 1
        titleHighlight.Text = a1
        titleHighlight.TextColor3 = Color3.new(1, 1, 1)
        titleHighlight.TextSize = 18
        titleHighlight.TextXAlignment = Enum.TextXAlignment.Left
        titleHighlight.Font = Enum.Font.GothamBold
        titleHighlight.ZIndex = a6.ZIndex - 1
        titleHighlight.Parent = am
        
        registerRainbowObject(titleHighlight, {TextColor3 = true})
        registerBlinkObject(titleHighlight, {TextTransparency = true})
        
        local az = Instance.new("TextButton")
        az.Name = "Minimize"
        az.Size = UDim2.new(0, 30, 0, 30)
        az.Position = UDim2.new(1, -75, 0, 10)
        az.BackgroundColor3 = i.Minimize; az.BackgroundTransparency = 0.3; az.BorderSizePixel = 0; az.Text = ""
        az.Parent = am; local aA = Instance.new("UICorner")
        aA.CornerRadius = UDim.new(0, 8)
        aA.Parent = az; local aB; local aC = m.CreateIcon(az, "Minus", UDim2.new(0, 16, 0, 16), UDim2.new(0.5, -8, 0.5,
            -8))
        m.AddHoverEffect(az, { BackgroundTransparency = 0.1 }, { BackgroundTransparency = 0.3 })
        local a8 = Instance.new("TextButton")
        a8.Name = "Close"
        a8.Size = UDim2.new(0, 30, 0, 30)
        a8.Position = UDim2.new(1, -40, 0, 10)
        a8.BackgroundColor3 = i.Error; a8.BackgroundTransparency = 0.3; a8.BorderSizePixel = 0; a8.Text = ""
        a8.Parent = am; local aD = Instance.new("UICorner")
        aD.CornerRadius = UDim.new(0, 8)
        aD.Parent = a8; local a9 = m.CreateIcon(a8, "X", UDim2.new(0, 16, 0, 16), UDim2.new(0.5, -8, 0.5, -8))
        a9.ImageColor3 = Color3.new(1, 1, 1); m.AddHoverEffect(a8, { BackgroundTransparency = 0.1 }, { BackgroundTransparency = 0.3 })
        local aE = false; local aF = aw.Size; az.MouseButton1Click:Connect(function()
            m.CreateRipple(az, h.X, h.Y)
            aE = not aE; if aE then
                aF = aF or aw.Size; if aB then aB.Visible = false end; m.Tween(aw, k.Spring,
                    { Size = UDim2.new(0, s.MinSize.X, 0, 50) })
                if aC then m.Tween(aC, k.Fast, { Rotation = 180 }) end
            else
                m.Tween(aw, k.Spring, { Size = aF })
                if aB then aB.Visible = true end; if aC then m.Tween(aC, k.Fast, { Rotation = 0 }) end
            end
        end)
        a8.MouseButton1Click:Connect(function()
            m.CreateRipple(a8, h.X, h.Y)
            m.Tween(aw, k.SlideIn,
                { Position = UDim2.new(aw.Position.X.Scale, aw.Position.X.Offset, 0, -s.MinSize.Y), BackgroundTransparency = 1 },
                function()
                    pcall(function() for aG, aj in ipairs(af.Windows) do if aj and aj.Window then pcall(function() m
                                        .DestroyGlassEffect(aj.Window) end) end end end)
                    if rainbowConnection then
                        rainbowConnection:Disconnect()
                        rainbowConnection = nil
                    end
                    if af and af.ScreenGui then pcall(function() af.ScreenGui:Destroy() end) end; af.Windows = {}
                end)
        end)
        local aH = false; local aI = nil; local aJ = nil; am.InputBegan:Connect(function(ad) if ad.UserInputType == Enum.UserInputType.MouseButton1 or ad.UserInputType == Enum.UserInputType.Touch then
                aH = true; aI = ad.Position; aJ = aw.Position
            end end)
        c.InputChanged:Connect(function(ad) if (ad.UserInputType == Enum.UserInputType.MouseMovement or ad.UserInputType == Enum.UserInputType.Touch) and aH then
                local aK = ad.Position - aI; aw.Position = UDim2.new(aJ.X.Scale, aJ.X.Offset + aK.X, aJ.Y.Scale,
                    aJ.Y.Offset + aK.Y)
            end end)
        c.InputEnded:Connect(function(ad) if ad.UserInputType == Enum.UserInputType.MouseButton1 or ad.UserInputType == Enum.UserInputType.Touch then aH = false end end)
        aB = Instance.new("Frame")
        aB.Name = "Content"
        aB.Size = UDim2.new(1, -20, 1, -70)
        aB.Position = UDim2.new(0, 10, 0, 60)
        aB.BackgroundTransparency = 1; aB.ClipsDescendants = true; aB.Parent = aw; local aL = Instance.new(
        "UIListLayout")
        aL.SortOrder = Enum.SortOrder.LayoutOrder; aL.Padding = UDim.new(0, 10)
        aL.Parent = aB; local aM = Instance.new("ScrollingFrame")
        aM.Name = "TabContainer"
        aM.Size = UDim2.new(1, 0, 0, 35)
        aM.BackgroundTransparency = 1; aM.LayoutOrder = 1; aM.Parent = aB; aM.CanvasSize = UDim2.new(0, 0, 0, 0)
        aM.ScrollBarThickness = 6; aM.HorizontalScrollBarInset = Enum.ScrollBarInset.Always; aM.ScrollBarImageColor3 = i
        .Border; aM.ClipsDescendants = true; aM.ScrollingDirection = Enum.ScrollingDirection.X; local aN = Instance.new(
        "UIListLayout")
        aN.FillDirection = Enum.FillDirection.Horizontal; aN.SortOrder = Enum.SortOrder.LayoutOrder; aN.Padding = UDim
        .new(0, 5)
        aN.Parent = aM; aN:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() aM.CanvasSize = UDim2.new(
            0, aN.AbsoluteContentSize.X + 8, 0, 0) end)
        local aO = Instance.new("Frame")
        aO.Name = "TabContent"
        aO.Size = UDim2.new(1, 0, 1, -45)
        aO.BackgroundTransparency = 1; aO.LayoutOrder = 2; aO.Parent = aB; local aP = { Window = aw, Content = aO, Tabs = {}, ActiveTab = nil, IsMinimized = function() return
            aE end }
        function aP:CreateTab(aQ, I)
            aQ = aQ or "New Tab"
            local aR = #self.Tabs + 1; local aS = Instance.new("TextButton")
            aS.Name = "Tab_" .. aR; aS.Size = UDim2.new(0, 120, 1, 0)
            aS.BackgroundColor3 = i.Surface; aS.BackgroundTransparency = 0.3; aS.BorderSizePixel = 0; aS.Text = ""
            aS.LayoutOrder = aR; aS.Parent = aM; local aT = Instance.new("UICorner")
            aT.CornerRadius = UDim.new(0, 8)
            aT.Parent = aS; local aU = Instance.new("TextLabel")
            aU.Size = UDim2.new(1, -30, 1, 0)
            aU.Position = UDim2.new(0, I and 25 or 10, 0, 0)
            aU.BackgroundTransparency = 1; aU.Text = aQ; aU.TextColor3 = Color3.new(1, 1, 1); -- White text
            aU.TextSize = 14; aU.TextXAlignment = Enum.TextXAlignment.Left; aU.Font = Enum.Font.Gotham; aU.Parent = aS; local aV = nil; if I then
                aV = m.CreateIcon(aS, I, UDim2.new(0, 16, 0, 16), UDim2.new(0, 5, 0.5, -8))
                aV.ImageColor3 = Color3.new(1, 1, 1) -- White icon
            end; local aW = Instance.new("ScrollingFrame")
            aW.Name = "TabContent_" .. aR; aW.Size = UDim2.new(1, 0, 1, 0)
            aW.BackgroundTransparency = 1; aW.BorderSizePixel = 0; aW.ScrollBarThickness = 4; aW.ScrollBarImageColor3 = i
            .Border; aW.CanvasSize = UDim2.new(0, 0, 0, 0)
            aW.Visible = false; aW.Parent = aO; local aX = Instance.new("UIListLayout")
            aX.SortOrder = Enum.SortOrder.LayoutOrder; aX.Padding = UDim.new(0, 8)
            aX.Parent = aW; aX:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() aW.CanvasSize = UDim2
                .new(0, 0, 0, aX.AbsoluteContentSize.Y + 10) end)
            local aY = { Button = aS, Content = aW, Label = aU, Icon = aV, Active = false, Index = aR }
            m.AddHoverEffect(aS, { BackgroundTransparency = 0.1 }, { BackgroundTransparency = 0.3 })
            aS.MouseButton1Click:Connect(function()
                m.CreateRipple(aS, h.X, h.Y)
                self:SelectTab(aR)
            end)
            table.insert(self.Tabs, aY)
            if #self.Tabs == 1 then self:SelectTab(1) end; return self:CreateTabAPI(aY)
        end; function aP:SelectTab(aZ)
            if not self.Tabs[aZ] then return end; for aG, aY in ipairs(self.Tabs) do if aG == aZ then
                    aY.Active = true; aY.Content.Visible = true; m.Tween(aY.Button, k.Fast, { BackgroundTransparency = 0.1 })
                    m.Tween(aY.Label, k.Fast, { TextColor3 = Color3.new(1, 1, 1) }) -- White text
                    if aY.Icon then m.Tween(aY.Icon, k.Fast, { ImageColor3 = Color3.new(1, 1, 1) }) end -- White icon
                else
                    aY.Active = false; aY.Content.Visible = false; m.Tween(aY.Button, k.Fast,
                        { BackgroundTransparency = 0.3 })
                    m.Tween(aY.Label, k.Fast, { TextColor3 = Color3.new(0.8, 0.8, 0.8) }) -- Light gray text
                    if aY.Icon then m.Tween(aY.Icon, k.Fast, { ImageColor3 = Color3.new(0.8, 0.8, 0.8) }) end -- Light gray icon
                end end; self.ActiveTab = self.Tabs[aZ]
        end; function aP:CreateTabAPI(aY)
            local a_ = { Tab = aY, Elements = {} }
            function a_:AddLabel(b0)
                local b1 = Instance.new("TextLabel")
                b1.Size = UDim2.new(1, 0, 0, 25)
                b1.BackgroundTransparency = 1; b1.Text = b0 or "Label"
                b1.TextColor3 = Color3.new(1, 1, 1); -- White text
                b1.TextSize = 16; b1.TextXAlignment = Enum.TextXAlignment.Left; b1.Font = Enum
                .Font.Gotham; b1.Parent = aY.Content; table.insert(self.Elements, b1)
                
                -- Add rainbow blinking highlight
                local highlight = Instance.new("TextLabel")
                highlight.Size = UDim2.new(1, 0, 0, 25)
                highlight.Position = UDim2.new(0, 0, 0, 0)
                highlight.BackgroundTransparency = 1
                highlight.Text = b0 or "Label"
                highlight.TextColor3 = Color3.new(1, 1, 1)
                highlight.TextSize = 16
                highlight.TextXAlignment = Enum.TextXAlignment.Left
                highlight.Font = Enum.Font.Gotham
                highlight.ZIndex = b1.ZIndex - 1
                highlight.Parent = aY.Content
                
                registerRainbowObject(highlight, {TextColor3 = true})
                registerBlinkObject(highlight, {TextTransparency = true})
                
                return b1
            end; function a_:AddButton(b0, F)
                local S = Instance.new("TextButton")
                S.Size = UDim2.new(1, 0, 0, 35)
                S.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2); -- Dark background
                S.BackgroundTransparency = 0.2; S.BorderSizePixel = 0; S.Text = b0 or
                "Button"
                S.TextColor3 = Color3.new(1, 1, 1); -- White text
                S.TextSize = 16; S.Font = Enum.Font.GothamBold; S.Parent = aY.Content; local b2 =
                Instance.new("UICorner")
                b2.CornerRadius = UDim.new(0, 8)
                b2.Parent = S; m.AddHoverEffect(S, { BackgroundTransparency = 0.1 }, { BackgroundTransparency = 0.2 })
                
                -- Add rainbow blinking border
                local border = Instance.new("UIStroke")
                border.Color = Color3.new(1, 1, 1)
                border.Thickness = 2
                border.Transparency = 0.5
                border.Parent = S
                
                registerRainbowObject(border, {BorderColor3 = true})
                registerBlinkObject(border, {Transparency = true})
                
                S.MouseButton1Click:Connect(function()
                    m.CreateRipple(S, h.X, h.Y)
                    if F then F() end
                end)
                table.insert(self.Elements, S)
                return S
            end; function a_:AddToggle(b0, b3, F)
                local b4 = Instance.new("Frame")
                b4.Size = UDim2.new(1, 0, 0, 35)
                b4.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2); -- Dark background
                b4.BackgroundTransparency = 0.3; b4.BorderSizePixel = 0; b4.Parent = aY
                .Content; local b5 = Instance.new("UICorner")
                b5.CornerRadius = UDim.new(0, 8)
                b5.Parent = b4; local b6 = Instance.new("TextLabel")
                b6.Size = UDim2.new(1, -50, 1, 0)
                b6.Position = UDim2.new(0, 15, 0, 0)
                b6.BackgroundTransparency = 1; b6.Text = b0 or "Toggle"
                b6.TextColor3 = Color3.new(1, 1, 1); -- White text
                b6.TextSize = 16; b6.TextXAlignment = Enum.TextXAlignment.Left; b6.Font = Enum
                .Font.Gotham; b6.Parent = b4; local b7 = Instance.new("TextButton")
                b7.Size = UDim2.new(0, 30, 0, 18)
                b7.Position = UDim2.new(1, -40, 0.5, -9)
                b7.BackgroundColor3 = b3 and Color3.new(1, 1, 1) or Color3.new(0.3, 0.3, 0.3); -- White or dark
                b7.BackgroundTransparency = 0.2; b7.BorderSizePixel = 0; b7.Text =
                ""
                b7.Parent = b4; local b8 = Instance.new("UICorner")
                b8.CornerRadius = UDim.new(1, 0)
                b8.Parent = b7; local b9 = Instance.new("Frame")
                b9.Size = UDim2.new(0, 14, 0, 14)
                b9.Position = b3 and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
                b9.BackgroundColor3 = Color3.new(1, 1, 1); -- White
                b9.BorderSizePixel = 0; b9.Parent = b7; local ba = Instance.new("UICorner")
                ba.CornerRadius = UDim.new(1, 0)
                ba.Parent = b9; local bb = b3 or false; local function bc(bd)
                    bb = bd; m.Tween(b7, k.Fast, { BackgroundColor3 = bb and Color3.new(1, 1, 1) or Color3.new(0.3, 0.3, 0.3) })
                    m.Tween(b9, k.Spring, { Position = bb and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7) })
                    if F then F(bb) end
                end; b7.MouseButton1Click:Connect(function() bc(not bb) end)
                table.insert(self.Elements, b4)
                return { Set = bc, Get = function() return bb end }
            end; function a_:AddSlider(b0, be, bf, b3, F)
                be = be or 0; bf = bf or 100; b3 = b3 or be; local bg = Instance.new("Frame")
                bg.Size = UDim2.new(1, 0, 0, 50)
                bg.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2); -- Dark background
                bg.BackgroundTransparency = 0.3; bg.BorderSizePixel = 0; bg.Parent = aY
                .Content; local bh = Instance.new("UICorner")
                bh.CornerRadius = UDim.new(0, 8)
                bh.Parent = bg; local bi = Instance.new("TextLabel")
                bi.Size = UDim2.new(1, -60, 0, 25)
                bi.Position = UDim2.new(0, 15, 0, 0)
                bi.BackgroundTransparency = 1; bi.Text = b0 or "Slider"
                bi.TextColor3 = Color3.new(1, 1, 1); -- White text
                bi.TextSize = 16; bi.TextXAlignment = Enum.TextXAlignment.Left; bi.Font = Enum
                .Font.Gotham; bi.Parent = bg; local bj = Instance.new("TextLabel")
                bj.Size = UDim2.new(0, 50, 0, 25)
                bj.Position = UDim2.new(1, -60, 0, 0)
                bj.BackgroundTransparency = 1; bj.Text = tostring(b3)
                bj.TextColor3 = Color3.new(1, 1, 1); -- White text
                bj.TextSize = 14; bj.TextXAlignment = Enum.TextXAlignment.Right; bj.Font =
                Enum.Font.GothamMedium; bj.Parent = bg; local bk = Instance.new("Frame")
                bk.Size = UDim2.new(1, -30, 0, 4)
                bk.Position = UDim2.new(0, 15, 1, -15)
                bk.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1); -- Very dark
                bk.BorderSizePixel = 0; bk.Parent = bg; local bl = Instance.new(
                "UICorner")
                bl.CornerRadius = UDim.new(1, 0)
                bl.Parent = bk; local bm = Instance.new("Frame")
                bm.Size = UDim2.new((b3 - be) / (bf - be), 0, 1, 0)
                bm.BackgroundColor3 = Color3.new(1, 1, 1); -- White
                bm.BorderSizePixel = 0; bm.Parent = bk; local bn = Instance.new(
                "UICorner")
                bn.CornerRadius = UDim.new(1, 0)
                bn.Parent = bm; local bo = Instance.new("Frame")
                bo.Size = UDim2.new(0, 16, 0, 16)
                bo.Position = UDim2.new((b3 - be) / (bf - be), -8, 0.5, -8)
                bo.BackgroundColor3 = Color3.new(1, 1, 1); -- White
                bo.BorderSizePixel = 0; bo.Parent = bk; local ba = Instance.new("UICorner")
                ba.CornerRadius = UDim.new(1, 0)
                ba.Parent = bo; local bp = Instance.new("UIStroke")
                bp.Color = Color3.new(1, 1, 1); -- White
                bp.Thickness = 2; bp.Parent = bo; local bq = b3; local aH = false; local function br(
                    bs)
                    bs = n(bs, be, bf)
                    bq = bs; local bt = (bs - be) / (bf - be)
                    m.Tween(bm, k.Fast, { Size = UDim2.new(bt, 0, 1, 0) })
                    m.Tween(bo, k.Fast, { Position = UDim2.new(bt, -8, 0.5, -8) })
                    bj.Text = tostring(math.floor(bs))
                    if F then F(bs) end
                end; bk.InputBegan:Connect(function(ad) if ad.UserInputType == Enum.UserInputType.MouseButton1 or ad.UserInputType == Enum.UserInputType.Touch then
                        aH = true; local bt = n((h.X - bk.AbsolutePosition.X) / bk.AbsoluteSize.X, 0, 1)
                        br(be + (bf - be) * bt)
                    end end)
                c.InputChanged:Connect(function(ad) if (ad.UserInputType == Enum.UserInputType.MouseMovement or ad.UserInputType == Enum.UserInputType.Touch) and aH then
                        local bt = n((h.X - bk.AbsolutePosition.X) / bk.AbsoluteSize.X, 0, 1)
                        br(be + (bf - be) * bt)
                    end end)
                c.InputEnded:Connect(function(ad) if ad.UserInputType == Enum.UserInputType.MouseButton1 or ad.UserInputType == Enum.UserInputType.Touch then aH = false end end)
                table.insert(self.Elements, bg)
                return { Set = br, Get = function() return bq end }
            end; function a_:AddTextBox(b0, bu, F)
                local bv = Instance.new("Frame")
                bv.Size = UDim2.new(1, 0, 0, 35)
                bv.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2); -- Dark background
                bv.BackgroundTransparency = 0.3; bv.BorderSizePixel = 0; bv.Parent = aY
                .Content; local bw = Instance.new("UICorner")
                bw.CornerRadius = UDim.new(0, 8)
                bw.Parent = bv; local bx = Instance.new("TextBox")
                bx.Size = UDim2.new(1, -20, 1, 0)
                bx.Position = UDim2.new(0, 10, 0, 0)
                bx.BackgroundTransparency = 1; bx.Text = b0 or ""
                bx.PlaceholderText = bu or "Enter text..."
                bx.TextColor3 = Color3.new(1, 1, 1); -- White text
                bx.PlaceholderColor3 = Color3.new(0.6, 0.6, 0.6); -- Muted white
                bx.TextSize = 16; bx.TextXAlignment = Enum.TextXAlignment.Left; bx.Font = Enum
                .Font.Gotham; bx.ClearTextOnFocus = false; bx.Parent = bv; local P =
                Instance.new("UIStroke")
                P.Color = Color3.new(1, 1, 1); -- White border
                P.Thickness = 1; P.Transparency = 0.5; P.Parent = bv; bx.Focused:Connect(function() m
                        .Tween(P, k.Fast, { Color = Color3.new(1, 1, 1), Transparency = 0 }) end)
                bx.FocusLost:Connect(function(by)
                    m.Tween(P, k.Fast, { Color = Color3.new(1, 1, 1), Transparency = 0.5 })
                    if by and F then F(bx.Text) end
                end)
                table.insert(self.Elements, bv)
                return bx
            end; function a_:AddDropdown(b0, au, F)
                au = au or {}
                local bz = Instance.new("Frame")
                bz.Size = UDim2.new(1, 0, 0, 35)
                bz.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2); -- Dark background
                bz.BackgroundTransparency = 0.3; bz.BorderSizePixel = 0; bz.ClipsDescendants = false; bz.Parent =
                aY.Content; local bA = Instance.new("UICorner")
                bA.CornerRadius = UDim.new(0, 8)
                bA.Parent = bz; local bB = Instance.new("TextButton")
                bB.Size = UDim2.new(1, 0, 1, 0)
                bB.BackgroundTransparency = 1; bB.Text = ""
                bB.Parent = bz; local bC = Instance.new("TextLabel")
                bC.Size = UDim2.new(1, -40, 1, 0)
                bC.Position = UDim2.new(0, 15, 0, 0)
                bC.BackgroundTransparency = 1; bC.Text = b0 or "Select option..."
                bC.TextColor3 = Color3.new(1, 1, 1); -- White text
                bC.TextSize = 16; bC.TextXAlignment = Enum.TextXAlignment.Left; bC.Font = Enum
                .Font.Gotham; bC.Parent = bz; local bD = m.CreateIcon(bz, "ChevronDown", UDim2.new(0, 16, 0, 16),
                    UDim2.new(1, -30, 0.5, -8))
                local bE = Instance.new("Frame")
                bE.Name = "DropdownContainer"
                bE.Size = UDim2.new(0, bz.AbsoluteSize.X, 0, math.min(#au * 35, 140))
                bE.BackgroundTransparency = 1; bE.Visible = false; bE.ZIndex = 9999; bE.Parent = _; bE.ClipsDescendants = false; local bF =
                Instance.new("Frame")
                bF.Size = UDim2.new(1, 0, 1, 0)
                bF.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1); -- Very dark
                bF.BackgroundTransparency = 0.05; bF.BorderSizePixel = 0; bF.Parent =
                bE; bF.ZIndex = 10000; local bG = Instance.new("Frame")
                bG.Size = UDim2.new(1, 8, 1, 8)
                bG.Position = UDim2.new(0, -4, 0, -4)
                bG.BackgroundColor3 = Color3.new(0, 0, 0)
                bG.BackgroundTransparency = 0.8; bG.ZIndex = bF.ZIndex - 1; bG.Parent = bE; local bH = Instance.new(
                "UICorner")
                bH.CornerRadius = UDim.new(0, 12)
                bH.Parent = bG; local bI = Instance.new("ScrollingFrame")
                bI.Size = UDim2.new(1, 0, 1, 0)
                bI.BackgroundTransparency = 1; bI.BorderSizePixel = 0; bI.ScrollBarThickness = 4; bI.ScrollBarImageColor3 =
                i.Border; bI.CanvasSize = UDim2.new(0, 0, 0, #au * 35)
                bI.ScrollingDirection = Enum.ScrollingDirection.Y; bI.Parent = bF; bI.ZIndex = 10001; local bJ = Instance
                .new("UIListLayout")
                bJ.SortOrder = Enum.SortOrder.LayoutOrder; bJ.Parent = bI; local bK = false; local bL = nil; local function bM()
                    local bN = bz.AbsolutePosition; local bO = bz.AbsoluteSize; local bP = bN.X; local bQ = bN.Y + bO.Y +
                    5; bE.Position = UDim2.new(0, bP, 0, bQ)
                    bE.Size = UDim2.new(0, bz.AbsoluteSize.X, 0, math.min(#au * 35, 140))
                end; d.RenderStepped:Connect(function() if bE.Visible then bM() end end)
                for aG, bR in ipairs(au) do
                    local bS = Instance.new("TextButton")
                    bS.Size = UDim2.new(1, 0, 0, 35)
                    bS.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2); -- Dark background
                    bS.BackgroundTransparency = 0.9; bS.Text = bR; bS.TextColor3 = Color3.new(1, 1, 1); -- White text
                    bS.TextSize = 14; bS.TextXAlignment = Enum.TextXAlignment.Left; bS.Font = Enum.Font.Gotham; bS.LayoutOrder =
                    aG; bS.BorderSizePixel = 0; bS.Parent = bI; bS.ZIndex = 10002; local bT = Instance.new("UICorner")
                    bT.CornerRadius = UDim.new(0, 6)
                    bT.Parent = bS; local bU = Instance.new("UIPadding")
                    bU.PaddingLeft = UDim.new(0, 15)
                    bU.PaddingRight = UDim.new(0, 15)
                    bU.Parent = bS; m.AddHoverEffect(bS,
                        { BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.7, TextColor3 = Color3.new(0, 0, 0) },
                        { BackgroundColor3 = Color3.new(0.2, 0.2, 0.2), BackgroundTransparency = 0.9, TextColor3 = Color3.new(1, 1, 1) })
                    bS.MouseButton1Click:Connect(function()
                        bL = bR; bC.Text = bR; bK = false; bE.Visible = false; m.Tween(bD, k.Fast, { Rotation = 0 })
                        if F then F(bR) end
                    end)
                end; bB.MouseButton1Click:Connect(function()
                    bK = not bK; bE.Visible = bK; m.Tween(bD, k.Fast, { Rotation = bK and 180 or 0 })
                    if bK then
                        bM()
                        bE.Size = UDim2.new(0, bz.AbsoluteSize.X, 0, 0)
                        m.Tween(bE, k.Spring, { Size = UDim2.new(0, bz.AbsoluteSize.X, 0, math.min(#au * 35, 140)) })
                    end
                end)
                local function bV() if bK then
                        bK = false; bE.Visible = false; m.Tween(bD, k.Fast, { Rotation = 0 })
                    end end; c.InputBegan:Connect(function(ad, ae) if not ae and (ad.UserInputType == Enum.UserInputType.MouseButton1 or ad.UserInputType == Enum.UserInputType.Touch) then if bK then
                            local bW = Vector2.new(h.X, h.Y)
                            local bX = bz.AbsolutePosition; local bY = bz.AbsoluteSize; local bZ = bE.AbsolutePosition; local b_ =
                            bE.AbsoluteSize; local c0 = bW.X < bX.X or bW.X > bX.X + bY.X or bW.Y < bX.Y or
                            bW.Y > bX.Y + bY.Y; local c1 = bW.X < bZ.X or bW.X > bZ.X + b_.X or bW.Y < bZ.Y or
                            bW.Y > bZ.Y + b_.Y; if c0 and c1 then bV() end
                        end end end)
                table.insert(self.Elements, bz)
                return { Set = function(bR)
                    bL = bR; bC.Text = bR
                end, Get = function() return bL end, Close = bV }
            end; return a_
        end; aw.Position = UDim2.new(0, 50 + (av - 1) * 30, 0, -s.MinSize.Y)
        m.Tween(aw, k.SlideIn, { Position = UDim2.new(0, 50 + (av - 1) * 30, 0, 50 + (av - 1) * 30) })
        table.insert(self.Windows, aP)
        return aP
    end; return af
end; 



return a
