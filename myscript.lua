local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🕵️ GHOST HUB | RARE PRECISION",
    LoadingTitle = "Initializing Stealth Bypass...",
    ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Rare Hunter", 4483362458)

local targetPlayerName = ""
local playerList = {}

local VirtualUser = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local PlayerDropdown = MainTab:CreateDropdown({
    Name = "1. Select Target Player",
    Options = {"Refresh List First"},
    CurrentOption = {"Select Player"},
    Callback = function(Option)
        targetPlayerName = Option[1]
        Rayfield:Notify({Title = "Target Locked", Content = "Ready na i-scan ang base ni " .. targetPlayerName})
    end,
})

MainTab:CreateButton({
    Name = "🔄 Refresh Player List",
    Callback = function()
        playerList = {}
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then table.insert(playerList, p.Name) end
        end
        PlayerDropdown:Refresh(playerList, true)
    end,
})

MainTab:CreateSection("Target's Rare Brainrots")

MainTab:CreateButton({
    Name = "🔍 Scan & Show Rare Items",
    Callback = function()
        if targetPlayerName == "" then return end
        
        local targetBase = workspace.Plots:FindFirstChild(targetPlayerName)
        if targetBase and targetBase:FindFirstChild("Drops") then
            for _, item in pairs(targetBase.Drops:GetChildren()) do
                local mutation = item:GetAttribute("Mutation") or "Normal"
                local trait = item:GetAttribute("Trait") or "None"
                
                MainTab:CreateButton({
                    Name = "GET: " .. item.Name .. " [" .. mutation .. " | " .. trait .. "]",
                    Callback = function()
                        local myBase = workspace.Plots:FindFirstChild(game.Players.LocalPlayer.Name)
                        if not myBase then return end
                        
                        local targetPos = myBase.PrimaryPart.Position + Vector3.new(0, 5, 0)
                        
                        if item:IsA("Model") then 
                            item:SetPrimaryPartCFrame(CFrame.new(targetPos))
                        else 
                            item.CFrame = CFrame.new(targetPos) 
                        end
                        
                        Rayfield:Notify({Title = "SUCCESS!", Content = "Nakuha na ang Rare!"})
                        
                        task.wait(0.3)
                        game:Shutdown()
                    end,
                })
            end
        end
    end,
})
