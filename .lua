if _G.MainScriptLoaded then
     warn("🚫 Main script already loaded. Preventing duplicate execution.")
     return
 end
 _G.MainScriptLoaded = true

 local whitelist = { 4649811121,
 } 

 local player = game.Players.LocalPlayer
 local playerId = player.UserId

 print("👤 Player ID detected:", playerId)

 local isWhitelisted = false
 for _, id in ipairs(whitelist) do
     if id == playerId then
         isWhitelisted = true
         break
     end
 end

 if not isWhitelisted then
     warn("❌ Access denied for ID:", playerId)
     player:Kick("🚫 You are not allowed to use this script")
     return
 end

local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
-- 🏠 Creation
local Window = Library:CreateWindow{
    Title = "H3ll Paid",
    SubTitle = "By Xxdarkiller",
    TabWidth = 125,
    Size = UDim2.fromOffset(830, 525),
    Resize = true,
    MinSize = Vector2.new(470, 380),
    Acrylic = true,
    Theme = "DuoTone Dark Sea",
    MinimizeKey = Enum.KeyCode.RightControl
}local Tabs = {
	Main = Window:CreateTab{
		Title = "Main",
		Icon = "phosphor-house-bold"
	},
	AutoBuy = Window:CreateTab{
		Title = "Auto Buy",
		Icon = "phosphor-shopping-cart-bold"
	},
	AutoStuff = Window:CreateTab{
		Title = "Auto Stuff",
		Icon = "phosphor-robot-bold"
	},
	AutoFarm = Window:CreateTab{
		Title = "Auto Farm",
		Icon = "phosphor-robot-bold"
	},
	Rebirth = Window:CreateTab{
		Title = "Rebirth",
		Icon = "phosphor-arrows-clockwise-bold"
	},
	Killer = Window:CreateTab{
		Title = "Killer",
		Icon = "phosphor-sword-bold"
	},
	Crystals = Window:CreateTab{
		Title = "Crystals",
		Icon = "phosphor-diamond-bold"
	},
	Teleport = Window:CreateTab{
		Title = "Teleport",
		Icon = "phosphor-dog-bold"
	},
	Stats = Window:CreateTab{
		Title = "Stats",
		Icon = "phosphor-sparkle-bold"
	},
	Misc = Window:CreateTab{
		Title = "Misc",
		Icon = "phosphor-map-pin-bold"
	},
	Settings = Window:CreateTab{
		Title = "Settings",
		Icon = "phosphor-sliders-bold"
	}
}

local Options = Library.Options  
local MainSection = Tabs.Main:CreateSection("Basic Controls")
local selectedSize = "2"

local Input = MainSection:AddInput("SizeChanger", {
    Title = "Size Changer",
    Description = "Enter Size",
    Default = "2",
    Placeholder = "Type here...",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        selectedSize = Value
        if _G.AutoSize then
            game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", tonumber(selectedSize))
        end
    end
})

local Toggle = Tabs.Main:CreateToggle("AutoSize", {
	Title = "Auto Set Size",
	Description = "Auto Set ur Choosed Size",
	Default = false,
	Callback = function(Value)
		_G.AutoSize = Value
		while _G.AutoSize do
			game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", tonumber(selectedSize))
			task.wait(0.1)
		end
	end
})

local selectedSpeed = "125"
local Input = Tabs.Main:CreateInput("SpeedChanger", {
	Title = "Speed Changer",
	Description = "Enter Speed",
	Default = "125",
	Placeholder = "Enter Speed",
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		selectedSpeed = Value
		if _G.AutoSpeed then
			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(selectedSpeed)
			end
		end
	end
})

local Toggle = Tabs.Main:CreateToggle("AutoSpeed", {
	Title = "Auto Set Speed",
	Description = "Auto Set ur Choosed Speed",
	Default = false,
	Callback = function(Value)
		_G.AutoSpeed = Value
		while _G.AutoSpeed do
			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(selectedSpeed)
			end
			task.wait()
		end
	end
})

Tabs.Main:CreateButton{
	Title = "Free AutoLift Gamepass",
	Callback = function()
		local gamepassFolder = game:GetService("ReplicatedStorage").gamepassIds
		local player = game:GetService("Players").LocalPlayer
		for _, gamepass in pairs(gamepassFolder:GetChildren()) do
			local value = Instance.new("IntValue")
			value.Name = gamepass.Name
			value.Value = gamepass.Value
			value.Parent = player.ownedGamepasses
		end
	end
}

local Toggle = Tabs.Main:CreateToggle("WalkOnWater", {
	Title = "Walk on Water",
	Description = "",
	Default = false,
	Callback = function(Value)
		if Value then
			createParts()
		else
			makePartsWalkthrough()
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("Weight", {
	Title = "Auto Weight",
	Description = "Auto Lift Weight",
	Default = false,
	Callback = function(Value)
		_G.AutoWeight = Value
		if Value then
			local weightTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight")
			if weightTool then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(weightTool)
			end
		else
			local character = game.Players.LocalPlayer.Character
			local equipped = character:FindFirstChild("Weight")
			if equipped then
				equipped.Parent = game.Players.LocalPlayer.Backpack
			end
		end
		while _G.AutoWeight do
			game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
			task.wait(0)
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("Pushups", {
	Title = "Auto Pushups",
	Description = "Auto Lift Pushups",
	Default = false,
	Callback = function(Value)
		_G.AutoPushups = Value
		if Value then
			local pushupsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Pushups")
			if pushupsTool then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(pushupsTool)
			end
		else
			local character = game.Players.LocalPlayer.Character
			local equipped = character:FindFirstChild("Pushups")
			if equipped then
				equipped.Parent = game.Players.LocalPlayer.Backpack
			end
		end
		while _G.AutoPushups do
			game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
			task.wait(0)
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("Handstands", {
	Title = "Auto Handstands",
	Description = "Auto Lift Handstands",
	Default = false,
	Callback = function(Value)
		_G.AutoHandstands = Value
		if Value then
			local handstandsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Handstands")
			if handstandsTool then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(handstandsTool)
			end
		else
			local character = game.Players.LocalPlayer.Character
			local equipped = character:FindFirstChild("Handstands")
			if equipped then
				equipped.Parent = game.Players.LocalPlayer.Backpack
			end
		end
		while _G.AutoHandstands do
			game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
			task.wait(0)
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("Situps", {
	Title = "Auto Situps",
	Description = "Auto Lift Situps",
	Default = false,
	Callback = function(Value)
		_G.AutoSitups = Value
		if Value then
			local situpsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Situps")
			if situpsTool then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(situpsTool)
			end
		else
			local character = game.Players.LocalPlayer.Character
			local equipped = character:FindFirstChild("Situps")
			if equipped then
				equipped.Parent = game.Players.LocalPlayer.Backpack
			end
		end
		while _G.AutoSitups do
			game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
			task.wait(0)
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("Punch", {
	Title = "Auto Punch",
	Description = "Auto Punch",
	Default = false,
	Callback = function(Value)
		_G.fastHitActive = Value
		if Value then
			local function equipAndModifyPunch()
				while _G.fastHitActive do
					local player = game.Players.LocalPlayer
					local punch = player.Backpack:FindFirstChild("Punch")
					if punch then
						punch.Parent = player.Character
						if punch:FindFirstChild("attackTime") then
							punch.attackTime.Value = 0
						end
					end
					wait(0)
				end
			end
			local function rapidPunch()
				while _G.fastHitActive do
					local player = game.Players.LocalPlayer
					player.muscleEvent:FireServer("punch", "rightHand")
					player.muscleEvent:FireServer("punch", "leftHand")
					local character = player.Character
					if character then
						local punchTool = character:FindFirstChild("Punch")
						if punchTool then
							punchTool:Activate()
						end
					end
					wait(0)
				end
			end
			coroutine.wrap(equipAndModifyPunch)()
			coroutine.wrap(rapidPunch)()
		else
			local character = game.Players.LocalPlayer.Character
			local equipped = character:FindFirstChild("Punch")
			if equipped then
				equipped.Parent = game.Players.LocalPlayer.Backpack
			end
		end
	end
})
local Toggle = Tabs.AutoFarm:CreateToggle("ToolSpeed", {
	Title = "Fast Tools",
	Description = "Fast Tools..., What u didn't get.",
	Default = false,
	Callback = function(Value)
		_G.FastTools = Value
		local defaultSpeeds = {
			{
				"Punch",
				"attackTime",
				Value and 0 or 0.35
			},
			{
				"Ground Slam",
				"attackTime",
				Value and 0 or 6
			},
			{
				"Stomp",
				"attackTime",
				Value and 0 or 7
			},
			{
				"Handstands",
				"repTime",
				Value and 0 or 1
			},
			{
				"Pushups",
				"repTime",
				Value and 0 or 1
			},
			{
				"Weight",
				"repTime",
				Value and 0 or 1
			},
			{
				"Situps",
				"repTime",
				Value and 0 or 1
			}
		}
		local player = game.Players.LocalPlayer
		local backpack = player:WaitForChild("Backpack")
		for _, toolInfo in ipairs(defaultSpeeds) do
			local tool = backpack:FindFirstChild(toolInfo[1])
			if tool and tool:FindFirstChild(toolInfo[2]) then
				tool[toolInfo[2]].Value = toolInfo[3]
			end
			local equippedTool = player.Character and player.Character:FindFirstChild(toolInfo[1])
			if equippedTool and equippedTool:FindFirstChild(toolInfo[2]) then
				equippedTool[toolInfo[2]].Value = toolInfo[3]
			end
		end
	end
})

local RockSection = Tabs.AutoFarm:CreateSection("Rock Farm")
local selectrock = ""
local Toggle = Tabs.AutoFarm:CreateToggle("TinyIslandRock", {
	Title = "Farm Tiny Island Rock",
	Description = "Farm rocks at Tiny Island",
	Default = false,
	Callback = function(Value)
		selectrock = "Tiny Island Rock"
		getgenv().autoFarm = Value
		while getgenv().autoFarm do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 0 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 0 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("StarterIslandRock", {
	Title = "Farm Starter Island Rock",
	Description = "Farm rocks at Starter Island",
	Default = false,
	Callback = function(Value)
		selectrock = "Starter Island Rock"
		getgenv().autoFarm = Value
		while getgenv().autoFarm do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 100 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 100 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("LegendBeachRock", {
	Title = "Farm Legend Beach Rock",
	Description = "Farm rocks at Legend Beach",
	Default = false,
	Callback = function(Value)
		selectrock = "Legend Beach Rock"
		getgenv().autoFarm = Value
		while getgenv().autoFarm do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 5000 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 5000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

function gettool()
	for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
		end
	end
	game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
	game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

local Toggle = Tabs.AutoFarm:CreateToggle("FrostGymRock", {
	Title = "Farm Frost Gym Rock",
	Description = "Farm rocks at Frost Gym",
	Default = false,
	Callback = function(Value)
		selectrock = "Frost Gym Rock"
		getgenv().autoFarm = Value
		while getgenv().autoFarm do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 150000 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 150000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("MythicalGymRock", {
	Title = "Farm Mythical Gym Rock",
	Description = "Farm rocks at Mythical Gym",
	Default = false,
	Callback = function(Value)
		selectrock = "Mythical Gym Rock"
		getgenv().autoFarm = Value
		while getgenv().autoFarm do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 400000 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 400000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("EternalGymRock", {
	Title = "Farm Eternal Gym Rock",
	Description = "Farm rocks at Eternal Gym",
	Default = false,
	Callback = function(Value)
		selectrock = "Eternal Gym Rock"
		getgenv().autoFarm = Value
		while getgenv().autoFarm do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 750000 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 750000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("LegendGymRock", {
	Title = "Farm Legend Gym Rock",
	Description = "Farm rocks at Legend Gym",
	Default = false,
	Callback = function(Value)
		selectrock = "Legend Gym Rock"
		getgenv().autoFarm = Value
		while getgenv().autoFarm do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 1000000 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 1000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("MuscleKingGymRock", {
	Title = "Farm Muscle King Gym Rock",
	Description = "Farm rocks at Muscle King Gym",
	Default = false,
	Callback = function(Value)
		selectrock = "Muscle King Gym Rock"
		getgenv().autoFarm = Value
		while getgenv().autoFarm do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 5000000 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 5000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("AncientJungleRock", {
	Title = "Farm Ancient Jungle Rock",
	Description = "Farm rocks at Ancient Jungle",
	Default = false,
	Callback = function(Value)
		selectrock = "Ancient Jungle Rock"
		getgenv().autoFarm = Value
		while getgenv().autoFarm do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 10000000 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 10000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Section = Tabs.Rebirth:CreateSection("AutoRebirth")

local targetRebirthValue = 1
local initialRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value

local Paragraph = Tabs.Rebirth:CreateParagraph("RebirthStats", {
	Title = "Rebirth Statistics",
	Content = "Loading stats...",
	TitleAlignment = "Left",
	ContentAlignment = Enum.TextXAlignment.Left
})

local function updateStats()
	local currentRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
	local gained = currentRebirths - initialRebirths
	Paragraph:SetContent(string.format("Target Rebirth: %d\nCurrent Rebirths: %d\nRebirths Gained: %d", targetRebirthValue, currentRebirths, gained))
end

game.Players.LocalPlayer.leaderstats.Rebirths.Changed:Connect(updateStats)
updateStats()

local targetInput = Tabs.Rebirth:CreateInput("TargetRebirth", {
	Title = "Target Rebirth Amount",
	Description = "Enter your target rebirth goal",
	Default = "1",
	Placeholder = "Enter amount...",
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		targetRebirthValue = tonumber(Value) or 1
		updateStats()
	end
})

local targetRebirthLoop = nil
local targetToggle = Tabs.Rebirth:CreateToggle("AutoRebirthTarget", {
	Title = "Auto Rebirth (Target)",
	Description = "Automatically rebirth until target is reached",
	Default = false,
	Callback = function(Value)
		if Value then
			targetRebirthLoop = task.spawn(function()
				while task.wait(0.1) do
					if game.Players.LocalPlayer.leaderstats.Rebirths.Value >= targetRebirthValue then
						targetToggle:SetValue(false)
						break
					end
					game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
				end
			end)
		else
			if targetRebirthLoop then
				task.cancel(targetRebirthLoop)
				targetRebirthLoop = nil
			end
		end
	end
})

local infiniteRebirthLoop = nil
local infiniteToggle = Tabs.Rebirth:CreateToggle("AutoRebirthInfinite", {
	Title = "Auto Rebirth (Infinite)",
	Description = "Continuously rebirth without stopping",
	Default = false,
	Callback = function(Value)
		if Value then
			infiniteRebirthLoop = task.spawn(function()
				while task.wait(0.1) do
					game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
				end
			end)
		else
			if infiniteRebirthLoop then
				task.cancel(infiniteRebirthLoop)
				infiniteRebirthLoop = nil
			end
		end
	end
})

local autoSizeLoop = nil
local sizeToggle = Tabs.Rebirth:CreateToggle("AutoSize", {
	Title = "Auto Size 1",
	Description = "Sets character size to 1 continuously",
	Default = false,
	Callback = function(Value)
		if Value then
			autoSizeLoop = task.spawn(function()
				while task.wait(0) do
					game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
				end
			end)
		else
			if autoSizeLoop then
				task.cancel(autoSizeLoop)
				autoSizeLoop = nil
			end
		end
	end
})

local teleportLoop = nil
local kingTeleportToggle = Tabs.Rebirth:CreateToggle("KingTeleport", {
	Title = "Auto Teleport to King",
	Description = "Continuously teleport to Muscle King",
	Default = false,
	Callback = function(Value)
		if Value then
			teleportLoop = task.spawn(function()
				while task.wait(0) do
					if game.Players.LocalPlayer.Character then
						game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-8646, 17, -5738))
					end
				end
			end)
		else
			if teleportLoop then
				task.cancel(teleportLoop)
				teleportLoop = nil
			end
		end
	end
})

local Toggle = Tabs.Rebirth:CreateToggle("FrameToggle", {
	Title = "Hide All Frames",
	Description = "Toggle ON to hide all game frames",
	Default = false,
	Callback = function(Value)
		local rSto = game:GetService("ReplicatedStorage")
		for _, obj in pairs(rSto:GetChildren()) do
			if obj.Name:match("Frame$") then
				obj.Visible = not Value
			end
		end
	end
})

local Section = Tabs.Killer:CreateSection("Auto Kill")
local Players = game:GetService("Players")

local function checkCharacter()
    if not game.Players.LocalPlayer.Character then
        repeat
            task.wait()
        until game.Players.LocalPlayer.Character
    end
    return game.Players.LocalPlayer.Character
end

local function killPlayer(target)
    local character = checkCharacter()
    if character and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        if character:FindFirstChild("LeftHand") then
            firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 0)
            firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 1)
            gettool()
        end
    end
end

Tabs.Killer:AddToggle("Kill v2 Player", {
    Title = "Start Killing",
    Default = false,
    Callback = function(v)
        getgenv().killallv2 = v
        task.spawn(function()
            while getgenv().killallv2 do
                for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game.Players.LocalPlayer then
                        if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                            killPlayer(player)
                        end
                    end
                end
                task.wait()
            end
        end)
    end
})
local PlayerDropdown = Tabs.Killer:CreateDropdown("PlayerList", {
	Title = "Select Target",
	Description = "Choose player to target",
	Values = {},
	Multi = false,
	Default = nil,
	Callback = function(Value)
		local username = string.match(Value, "(.+) |")
		targetPlayer = username
		print("Target set to:", targetPlayer)
	end
})

local function updatePlayerList()
	local playerInfo = {}
	for _, player in pairs(game:GetService("Players"):GetPlayers()) do
		if player ~= game.Players.LocalPlayer then
			local displayText = player.Name .. " | " .. player.DisplayName
			table.insert(playerInfo, displayText)
		end
	end
	PlayerDropdown:SetValues(playerInfo)
end

task.spawn(function()
	while true do
		updatePlayerList()
		task.wait(0)
	end
end)

game:GetService("Players").PlayerAdded:Connect(updatePlayerList)
game:GetService("Players").PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

local Dropdown1 = Tabs.Crystals:CreateDropdown("Crystals1", {
	Title = "Select Crystal",
	Description = "Click one to Auto",
	Values = {
		"Blue Crystal",
		"Green Crystal",
		"Frost Crystal",
		"Mythical Crystal",
		"Inferno Crystal"
	},
	Multi = false,
	Default = 1,
	Callback = function(Value)
		selectedCrystal1 = Value
	end
})

local Toggle1 = Tabs.Crystals:CreateToggle("AutoOpen1", {
	Title = "Auto Open Crystal",
	Description = "Automatically opens selected crystal",
	Default = false,
	Callback = function(Value)
		_G.AutoOpen1 = Value
		while _G.AutoOpen1 do
			game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", selectedCrystal1)
			task.wait(1)
		end
	end
})

local selectedCrystal2 = "Legend Crystal"

local Dropdown2 = Tabs.Crystals:CreateDropdown("Crystals2", {
	Title = "Select Crystal",
	Description = "Click one to Auto",
	Values = {
		"Legend Crystal",
		"Muscle Elite Crystal",
		"Galaxy Oracle Crystal",
		"Jungle Crystal"
	},
	Multi = false,
	Default = 1,
	Callback = function(Value)
		selectedCrystal2 = Value
	end
})

local Toggle2 = Tabs.Crystals:CreateToggle("AutoOpen2", {
	Title = "Auto Open Crystal",
	Description = "Automatically opens selected crystal",
	Default = false,
	Callback = function(Value)
		_G.AutoOpen2 = Value
		while _G.AutoOpen2 do
			game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", selectedCrystal2)
			task.wait(1)
		end
	end
})

Tabs.Teleport:CreateButton{
	Title = "Spawn",
	Description = "Teleport to Spawn Area",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(2, 8, 115)
	end
}

Tabs.Teleport:CreateButton{
	Title = "Secret",
	Description = "Teleport to Secret Area",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(1947, 2, 6191)
	end
}

Tabs.Teleport:CreateButton{
	Title = "Tiny",
	Description = "Teleport to Tiny Area",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(-34, 7, 1903)
	end
}

Tabs.Teleport:CreateButton{
	Title = "Frozen",
	Description = "Teleport to Frozen",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(- 2600.00244, 3.67686558, - 403.884369, 0.0873617008, 1.0482899e-09, 0.99617666, 3.07204253e-08, 1, - 3.7464023e-09, - 0.99617666, 3.09302628e-08, 0.0873617008)
	end
}

Tabs.Teleport:CreateButton{
	Title = "Mythical",
	Description = "Teleport to Mythical",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(2255, 7, 1071)
	end
}

Tabs.Teleport:CreateButton{
	Title = "Inferno",
	Description = "Teleport to Inferno",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(-6768, 7, -1287)
	end
}

Tabs.Teleport:CreateButton{
	Title = "Legend",
	Description = "Teleport to Legend",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(4604, 991, -3887)
	end
}

Tabs.Teleport:CreateButton{
	Title = "Muscle King",
	Description = "Teleport to Muscle King",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(-8646, 17, -5738)
	end
}

Tabs.Teleport:CreateButton{
	Title = "Jungle",
	Description = "Teleport to Jungle",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(-8659, 6, 2384)
	end
}

Tabs.Teleport:CreateButton{
	Title = "Lava Brawl",
	Description = "Teleport to Lava Brawl",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(4471, 119, -8836)
	end
}

Tabs.Teleport:CreateButton{
	Title = "Desert Brawl",
	Description = "Teleport to Desert Brawl",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(960, 17, -7398)
	end
}

Tabs.Teleport:CreateButton{
	Title = "Beach Brawl",
	Description = "Teleport to Beach Brawl",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(-1849, 20, -6335)
	end
}

local IntSection = Tabs.Stats:CreateSection("Player Stats")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer

local startTime = 0
local sessionStartTime = os.time()
local timerRunning = false

local strengthGained = 0
local lastStrengthValue = nil
local rebirthsGained = 0
local lastRebirthsValue = nil
local killsGained = 0
local lastKillsValue = nil
local brawlsGained = 0
local lastBrawlsValue = nil
local goodKarmaGained = 0
local lastGoodKarmaValue = nil
local evilKarmaGained = 0
local lastEvilKarmaValue = nil
local durabilityGained = 0
local lastDurabilityValue = nil
local agilityGained = 0
local lastAgilityValue = nil
local muscleKingTimeGained = 0
local lastMuscleKingTimeValue = nil

local TimerParagraph = Tabs.Stats:CreateParagraph("SessionTimer", {
	Title = "⏱️ Session Time",
	Content = "0d 0h 0m 0s",
	TitleAlignment = "Left",
	ContentAlignment = Enum.TextXAlignment.Left
})

local CustomTimerParagraph = Tabs.Stats:CreateParagraph("CustomTimer", {
	Title = "⏱️ Custom Timer",
	Content = "Timer not started",
	TitleAlignment = "Left",
	ContentAlignment = Enum.TextXAlignment.Left
})

local LeaderParagraph = Tabs.Stats:CreateParagraph("LeaderStats", {
	Title = "📊 Leaderboard Stats",
	Content = "Loading stats...",
	TitleAlignment = "Left",
	ContentAlignment = Enum.TextXAlignment.Left
})

local IntParagraph = Tabs.Stats:CreateParagraph("IntStats", {
	Title = "💪 Player Stats",
	Content = "Loading stats...",
	TitleAlignment = "Left",
	ContentAlignment = Enum.TextXAlignment.Left
})

Tabs.Stats:CreateButton{
	Title = "Start/Stop Timer",
	Description = "Track your training sessions",
	Callback = function()
		if not timerRunning then
			startTime = os.time()
			timerRunning = true
			CustomTimerParagraph:SetContent("Timer running...")
		else
			timerRunning = false
			CustomTimerParagraph:SetContent("Timer stopped")
		end
	end
}

local function formatNumber(number)
	local formatted = tostring(math.floor(number))
	local k
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if k == 0 then
			break
		end
	end
	return formatted
end

local function formatTime(seconds)
	local days = math.floor(seconds / 86400)
	local hours = math.floor((seconds % 86400) / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local secs = seconds % 60
	return string.format("%dd %dh %dm %ds", days, hours, minutes, secs)
end

local function debugPrint(message, value)
	print(string.format("[DEBUG] %s: %s", message, tostring(value)))
end

repeat
	task.wait()
until game:IsLoaded()
debugPrint("")

if not player.Character then
	player.CharacterAdded:Wait()
end
debugPrint("Character Loaded", "Success")

repeat
	task.wait()
until player:FindFirstChild("leaderstats") and player:FindFirstChild("goodKarma")
debugPrint("")

RunService.RenderStepped:Connect(function()
	local sessionTime = os.time() - sessionStartTime
	TimerParagraph:SetContent(formatTime(sessionTime))
	if timerRunning then
		local elapsed = os.time() - startTime
		CustomTimerParagraph:SetContent(formatTime(elapsed))
	end
	local currentStrength = player.leaderstats.Strength.Value
	local currentRebirths = player.leaderstats.Rebirths.Value
	local currentKills = player.leaderstats.Kills.Value
	local currentBrawls = player.leaderstats.Brawls.Value
	local currentGoodKarma = player.goodKarma.Value
	local currentEvilKarma = player.evilKarma.Value
	local currentDurability = player.Durability.Value
	local currentAgility = player.Agility.Value
	local currentMuscleKingTime = player.muscleKingTime.Value
	if lastStrengthValue == nil then
		lastStrengthValue = currentStrength
	elseif currentStrength > lastStrengthValue then
		strengthGained = strengthGained + (currentStrength - lastStrengthValue)
	end
	lastStrengthValue = currentStrength
	if lastRebirthsValue == nil then
		lastRebirthsValue = currentRebirths
	elseif currentRebirths > lastRebirthsValue then
		rebirthsGained = rebirthsGained + (currentRebirths - lastRebirthsValue)
	end
	lastRebirthsValue = currentRebirths
	if lastKillsValue == nil then
		lastKillsValue = currentKills
	elseif currentKills > lastKillsValue then
		killsGained = killsGained + (currentKills - lastKillsValue)
	end
	lastKillsValue = currentKills
	if lastBrawlsValue == nil then
		lastBrawlsValue = currentBrawls
	elseif currentBrawls > lastBrawlsValue then
		brawlsGained = brawlsGained + (currentBrawls - lastBrawlsValue)
	end
	lastBrawlsValue = currentBrawls
	if lastGoodKarmaValue == nil then
		lastGoodKarmaValue = currentGoodKarma
	elseif currentGoodKarma > lastGoodKarmaValue then
		goodKarmaGained = goodKarmaGained + (currentGoodKarma - lastGoodKarmaValue)
	end
	lastGoodKarmaValue = currentGoodKarma
	if lastEvilKarmaValue == nil then
		lastEvilKarmaValue = currentEvilKarma
	elseif currentEvilKarma > lastEvilKarmaValue then
		evilKarmaGained = evilKarmaGained + (currentEvilKarma - lastEvilKarmaValue)
	end
	lastEvilKarmaValue = currentEvilKarma
	if lastDurabilityValue == nil then
		lastDurabilityValue = currentDurability
	elseif currentDurability > lastDurabilityValue then
		durabilityGained = durabilityGained + (currentDurability - lastDurabilityValue)
	end
	lastDurabilityValue = currentDurability
	if lastAgilityValue == nil then
		lastAgilityValue = currentAgility
	elseif currentAgility > lastAgilityValue then
		agilityGained = agilityGained + (currentAgility - lastAgilityValue)
	end
	lastAgilityValue = currentAgility
	if lastMuscleKingTimeValue == nil then
		lastMuscleKingTimeValue = currentMuscleKingTime
	elseif currentMuscleKingTime > lastMuscleKingTimeValue then
		muscleKingTimeGained = muscleKingTimeGained + (currentMuscleKingTime - lastMuscleKingTimeValue)
	end
	lastMuscleKingTimeValue = currentMuscleKingTime
	LeaderParagraph:SetContent(string.format("Strength: %s     Strength Gained: %s\nRebirths: %s     Rebirths Gained: %s\nKills: %s     Kills Gained: %s\nBrawls: %s     Brawls Gained: %s", formatNumber(currentStrength), formatNumber(strengthGained), formatNumber(currentRebirths), formatNumber(rebirthsGained), formatNumber(currentKills), formatNumber(killsGained), formatNumber(currentBrawls), formatNumber(brawlsGained)))
	IntParagraph:SetContent(string.format("Good Karma: %s     Gained: %s\nEvil Karma: %s     Gained: %s\nDurability: %s     Gained: %s\nAgility: %s     Gained: %s\nMuscle King Time: %s     Gained: %s", formatNumber(currentGoodKarma), formatNumber(goodKarmaGained), formatNumber(currentEvilKarma), formatNumber(evilKarmaGained), formatNumber(currentDurability), formatNumber(durabilityGained), formatNumber(currentAgility), formatNumber(agilityGained), formatNumber(currentMuscleKingTime), formatNumber(muscleKingTimeGained)))
end)

local leaderStats = {
	"Strength",
	"Rebirths",
	"Kills",
	"Brawls"
}

local intStats = {
	"Agility",
	"Durability",
	"Gems",
	"evilKarma",
	"goodKarma",
	"muscleKingTime"
}


local Toggle = Tabs.Misc:CreateToggle("Rejoin", {
	Title = "Auto Rejoin",
	Description = "Auto's Rejoin for u",
	Default = false,
	Callback = function(Value)
		_G.AutoRejoin = Value
		while _G.AutoRejoin do
			if game:GetService("CoreGui").RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt") then
				game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
			end
			task.wait(1)
		end
	end
})

Tabs.Misc:CreateButton{
	Title = "Less Lag",
	Description = "Optimize game performance",
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
				if v:IsA("Texture") then
					v:Destroy()
				end
			end
		end
		settings().Rendering.QualityLevel = 1
	end
}

Tabs.Misc:CreateButton{
	Title = "Rejoin",
	Description = "Instantly rejoin the same server",
	Callback = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
	end
}

Tabs.Misc:CreateButton{
	Title = "ServerHop",
	Description = "Join a different server",
	Callback = function()
		local PlaceID = game.PlaceId
		local AllIDs = {}
		local foundAnything = ""
		local actualHour = os.date("!*t").hour
		local Deleted = false
		local function TPReturner()
			local Site;
			if foundAnything == "" then
				Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
			else
				Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
			end
			local ID = ""
			if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
				foundAnything = Site.nextPageCursor
			end
			local num = 0;
			for i, v in pairs(Site.data) do
				local Possible = true
				ID = tostring(v.id)
				if tonumber(v.maxPlayers) > tonumber(v.playing) then
					for _, Existing in pairs(AllIDs) do
						if num ~= 0 then
							if ID == tostring(Existing) then
								Possible = false
							end
						else
							if tonumber(actualHour) ~= tonumber(Existing) then
								local delFile = pcall(function()
									AllIDs = {}
									table.insert(AllIDs, actualHour)
								end)
							end
						end
						num = num + 1
					end
					if Possible == true then
						table.insert(AllIDs, ID)
						task.wait()
						pcall(function()
							game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
						end)
						task.wait(4)
					end
				end
			end
		end
		TPReturner()
	end
}

Tabs.Misc:CreateButton{
	Title = "Join Small Server",
	Description = "Find lowest player count server",
	Callback = function()
		local PlaceID = game.PlaceId
		local function GetSmallServer()
			local AllServers = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
			local LowestPlayers = math.huge
			local ServerID
			for _, server in pairs(AllServers.data) do
				if server.playing < LowestPlayers and server.playing > 0 then
					LowestPlayers = server.playing
					ServerID = server.id
				end
			end
			if ServerID then
				game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ServerID, game.Players.LocalPlayer)
			end
		end
		GetSmallServer()
	end
}

Window:SelectTab(1)

Library:Notify{
	Title = "Muscle Legends Script",
	Content = "Ui!",
	Duration = 0.01
}

SaveManager:LoadAutoloadConfig()

local TrackingParagraph = Tabs.Stats:CreateParagraph("TrackingStats", {
	Title = "Player Tracking Stats",
	Content = "No player selected",
	TitleAlignment = "Left",
	ContentAlignment = Enum.TextXAlignment.Left
})

local PlayerInput = Tabs.Stats:CreateInput("PlayerTracker", {
	Title = "Track Player Stats",
	Description = "Enter username or display name",
	Default = "",
	Placeholder = "Enter player name...",
	Numeric = false,
	Finished = true,
	Callback = function(Value)
		targetPlayer = Value
	end
})

Tabs.Stats:CreateButton{
	Title = "Track Player",
	Description = "Start tracking selected player's stats",
	Callback = function()
		local foundPlayer = nil
		for _, player in pairs(game.Players:GetPlayers()) do
			local nameLower = player.Name:lower()
			local displayLower = player.DisplayName:lower()
			local searchLower = targetPlayer:lower()
			if nameLower:find(searchLower) or displayLower:find(searchLower) then
				foundPlayer = player
				break
			end
		end
		if foundPlayer then
			local content = string.format("Strength: %s\nRebirths: %s\nKills: %s\nBrawls: %s\nGood Karma: %s\nEvil Karma: %s\nDurability: %s\nAgility: %s", formatNumber(foundPlayer.leaderstats.Strength.Value), formatNumber(foundPlayer.leaderstats.Rebirths.Value), formatNumber(foundPlayer.leaderstats.Kills.Value), formatNumber(foundPlayer.leaderstats.Brawls.Value), formatNumber(foundPlayer.goodKarma.Value), formatNumber(foundPlayer.evilKarma.Value), formatNumber(foundPlayer.Durability.Value), formatNumber(foundPlayer.Agility.Value))
			TrackingParagraph:SetContent(content)
			TrackingParagraph:SetTitle("📊 Tracking: " .. foundPlayer.Name)
		end
	end
}

local Toggle = Tabs.Settings:CreateToggle("ToggleName", {
	Title = "Lock Pos",
	Description = "This Freezes u",
	Default = false,
	Callback = function(Value)
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
			end
		end
	end
})

local Toggle = Tabs.Settings:CreateToggle("NoClip", {
	Title = "NoClip",
	Description = "Be able to walk through anything",
	Default = false,
	Callback = function(Value)
		local RunService = game:GetService("RunService")
		local Players = game:GetService("Players")
		local LocalPlayer = Players.LocalPlayer
		if Value then
			getgenv().noclipConnection = RunService.Stepped:Connect(function()
				for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end)
		else
			if getgenv().noclipConnection then
				getgenv().noclipConnection:Disconnect()
			end
		end
	end
})

local Toggle = Tabs.Settings:CreateToggle("InfiniteJump", {
	Title = "Infinite Jump",
	Description = "Jump Infinite",
	Default = false,
	Callback = function(Value)
		_G.InfiniteJump = Value
		local Player = game:GetService('Players').LocalPlayer
		local UserInputService = game:GetService('UserInputService')
		UserInputService.JumpRequest:Connect(function()
			if _G.InfiniteJump then
				Player.Character:FindFirstChildOfClass('Humanoid'):ChangeState('Jumping')
			end
		end)
	end
})

local Toggle = Tabs.Settings:CreateToggle("AntiPortal", {
	Title = "Remove Portals",
	Description = "Removes all portal",
	Default = false,
	Callback = function(Value)
		if Value then
			for _, portal in pairs(game:GetDescendants()) do
				if portal.Name == "RobloxForwardPortals" then
					portal:Destroy()
				end
			end
			game.DescendantAdded:Connect(function(descendant)
				if descendant.Name == "RobloxForwardPortals" then
					descendant:Destroy()
				end
			end)
		end
	end
})

local Toggle = Tabs.Settings:CreateToggle("BackgroundMusic", {
	Title = "Music",
	Description = "Toggle background music",
	Default = false,
	Callback = function(Value)
		if Value then
			local sound = Instance.new("Sound")
			sound.Name = "BackgroundMusic"
			sound.SoundId = "rbxassetid://5410083226"
			sound.Volume = 1
			sound.Looped = true
			sound.Parent = game.Workspace
			sound:Play()
		else
			if game.Workspace:FindFirstChild("BackgroundMusic") then
				game.Workspace.BackgroundMusic:Destroy()
			end
		end
	end
})

local Dropdown = Tabs.Settings:CreateDropdown("TimeControl", {
	Title = "Time Changer",
	Description = "Change time of day",
	Values = {
		"Morning",
		"Day",
		"Night"
	},
	Multi = false,
	Default = "Day",
	Callback = function(Val... (Tiempo restante: 26 KB)
