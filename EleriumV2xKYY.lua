--[[
    Elerium V2: Usage
]] -- Create the main window


local EleriumV2_UI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Kyypie69/Library.UI/refs/heads/main/KYY.luau"))()

local c2 = a.new({
    MainColor = Color3.fromRGB(138, 43, 226),
    ToggleKey = Enum.KeyCode.Insert,
    MinSize = Vector2.new(400, 350)
})

local aw = c2:CreateWindow("Elerium V2", {})

local c3 = aw:CreateTab("Home", "Home")

local c4 = aw:CreateTab("Settings", "Settings")

c3:AddLabel("Welcome to Elerium V2!")

local S = c3:AddButton("Test Notification", function()
    c2:Notify("Success!", "Button clicked successfully!", "Success", 3)
end)

local c5 = c3:AddDropdown("Example Dropdown...", {"example1", "example2", "example3"}, function(c6)
    c2:Notify("Dropdown", "Selected option: " .. c6, "Info", 2)
end)
local c7 = c3:AddToggle("toggle example", false, function(bd)
    c2:Notify("Toggle", "Feature " .. (bd and "enabled" or "disabled"), bd and "Success" or "Warning", 2)
end)
local c8 = c3:AddSlider("Slider example", 0, 100, 50, function(bs)
    print("Slider value set to:", bs)
end)
local bx = c3:AddTextBox("", "Enter txt...", function(b0)
    if b0 ~= "" then
        c2:Notify("Hello!", "Nice to meet you, " .. b0 .. "!", "Info", 4)
    end
end)
c4:AddLabel("Settings Panel")
c4:AddButton("Reset All", function()
    c2:Notify("Reset", "All settings have been reset!", "Warning", 3)
end)
local c9 = c4:AddToggle("Auto Save", true, function(bd)
    print("Auto save:", bd)
end)
