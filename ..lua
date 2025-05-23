local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library//main/Library", true))()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
 
local window = library:AddWindow("Legends Of Speed Script| Encrypted V2", {
    main_color = Color3.fromRGB(255, 0, 0), -- Custom emerald green color
    min_size = Vector2.new(700, 900),
    can_resize = true,
})
 
local mainTab = window:AddTab("Main")
local serverTab = window:AddTab("Server")
local performanceTab = window:AddTab("Performance")
local rebirth = window:AddTab("Rebirth")
local pets = window:AddTab("Pets")
 
mainTab:Show()
 
mainTab:AddLabel("Main Features")
 
mainTab:AddTextBox("Unlimited Speed", function(bool)
    if bool then
local player = game.Players.LocalPlayer
local character = player.Character
character.Humanoid.WalkSpeed = 1000 -- adjust the speed value as needed



mainTab:AddSwitch("Farm Orb")
while true do
    for _, orb in pairs(game:GetService("Workspace").Orbs:GetChildren()) do
        if orb:FindFirstChild("TouchInterest") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = orb.CFrame
            wait(0.1)
        end
    end
end

               
mainTab:AddSwitch("Auto Farm")
while true do
    game:GetService("ReplicatedStorage").CollectCoin:FireServer()
    wait(0.1)
end
 
 
serverTab:AddLabel("Server Options")
 
serverTab:AddButton("Rejoin Server", function()
    local ts = game:GetService("TeleportService")
    local p = game:GetService("Players").LocalPlayer
    ts:Teleport(game.PlaceId, p)
end)
 
local joinLowPlayerServerSwitch = serverTab:AddSwitch("Join Low Player Server", function(bool)
    if bool then
        local module = loadstring(game:HttpGet("https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua"))()
        module:Teleport(game.PlaceId, "Lowest")
    end
end)
 
serverTab:AddButton("Full Optimization", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = false
        end
    end
 
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    lighting.FogEnd = 9e9
    lighting.Brightness = 0
 
    settings().Rendering.QualityLevel = 1
 
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            if v.Parent and (v.Parent:FindFirstChild("Humanoid") or v.Parent.Parent:FindFirstChild("Humanoid")) then
            else
                v.Reflectance = 0
            end
        end
    end
 
    for _, v in pairs(lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled = false
        end
    end
 
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Optimization",
        Text = "Full optimization applied!",
        Duration = 5
    })
end)

          
 
performanceTab:AddLabel("Performance Options")
 
performanceTab:AddButton("Remove Textures", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        end
    end
 
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Performance",
        Text = "Textures removed!",
        Duration = 5
    })
end)
 
performanceTab:AddButton("Reduce Graphics", function()
    settings().Rendering.QualityLevel = 1
 
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Performance",
        Text = "Graphics reduced!",
        Duration = 5
    })
end)
 
performanceTab:AddButton("Disable Shadows", function()
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
 
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Performance",
        Text = "Shadows disabled!",
        Duration = 5
    })
end)
 
performanceTab:AddButton("Disable Effects", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = false
        end
    end
 
    local lighting = game:GetService("Lighting")
    for _, v in pairs(lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled = false
        end
    end
 
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Performance",
        Text = "Effects disabled!",
        Duration = 5
    })
end)
 
performanceTab:AddButton("Simplify Materials", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            if v.Parent and (v.Parent:FindFirstChild("Humanoid") or v.Parent.Parent:FindFirstChild("Humanoid")) then
            else
                v.Reflectance = 0
            end
        end
    end
 
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Performance",
        Text = "Materials simplified!",
        Duration = 5
    })
end)
 
performanceTab:AddButton("Remove Fog", function()
    local lighting = game:GetService("Lighting")
    lighting.FogEnd = 9e9
 
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Performance",
        Text = "Fog removed!",
        Duration = 5
    })
end)
 
performanceTab:AddButton("Full Optimization", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = false
        end
    end
 
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    lighting.FogEnd = 9e9
    lighting.Brightness = 0
 
    settings().Rendering.QualityLevel = 1
 
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            if v.Parent and (v.Parent:FindFirstChild("Humanoid") or v.Parent.Parent:FindFirstChild("Humanoid")) then
            else
                v.Reflectance = 0
            end
        end
    end
 
    for _, v in pairs(lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled = false
        end
    end
 
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Performance",
        Text = "Full optimization applied!",
 
 
rebirth:AddLabel("Rebirth Farm Settings")

-- Instant rebirths
while true do
    game:GetService("ReplicatedStorage").Rebirth:FireServer()
    wait(0.1)
end

          
-- Variable to store the position lock connection
local positionLockConnection = nil
 
-- Function to lock player position
local function lockPlayerPosition(position)
    if positionLockConnection then
        positionLockConnection:Disconnect()
    end
 
    positionLockConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = position
        end
    end)
end
 
-- Function to unlock player position
local function unlockPlayerPosition()
    if positionLockConnection then
        positionLockConnection:Disconnect()
        positionLockConnection = nil
    end
end
 
-- Add position lock toggle
rebirth:AddSwitch("Lock Position", function(bool)
    if bool then
        -- Get current position and lock it
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local currentPosition = player.Character.HumanoidRootPart.CFrame
            lockPlayerPosition(currentPosition)
        end
    else
        -- Unlock position
        unlockPlayerPosition()
    end
end)



Pets:AddLabel("Coming Soon")

Pets:AddLabel("Script By F-518")

