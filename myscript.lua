local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🕵️ GHOST HUB | RARE PRECISION v3",
    LoadingTitle = "Securing Live Data...",
    ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Rare Hunter", 4483362458)

local targetPlayerName = ""
local currentButtons = {}

local PlayerDropdown = MainTab:CreateDropdown({
    Name = "1. Select Target Player",
    Options = {"Refresh List to Start"},
    CurrentOption = {"Select Player"},
    Callback = function(Option)
        targetPlayerName = Option[1]
    end,
})

MainTab:CreateButton({
    Name = "🔄 Refresh Player List (ACCURATE)",
    Callback = function()
        local activePlayers = {}
        for _, p in pairs(game:GetService("Players"):GetPlayers()) do
            if p ~= game.Players.LocalPlayer then 
                table.insert(activePlayers, p.Name) 
            end
        end
        PlayerDropdown:Refresh(activePlayers, true)
        Rayfield:Notify({Title = "Sync Success", Content = "Live players only."})
    end,
})

local ItemSection = MainTab:CreateSection("Target's Rare Brainrots")

MainTab:CreateButton({
    Name = "🔍 Scan & List Accurate Items",
    Callback = function()
        if #currentButtons > 0 then
            for _, btn in pairs(currentButtons) do
                btn:Destroy()
            end
            currentButtons = {}
        end

        if targetPlayerName == "" or not game.Players:FindFirstChild(targetPlayerName) then 
            Rayfield:Notify({Title = "Error", Content = "Target not in server!"})
            return 
        end
        
        local targetBase = workspace.Plots:FindFirstChild(targetPlayerName)
        if targetBase and targetBase:FindFirstChild("Drops") then
            local foundItems = targetBase.Drops:GetChildren()
            
            if #foundItems == 0 then
                Rayfield:Notify({Title = "Empty", Content = "No items found in base."})
                return
            end

            for _, item in pairs(foundItems) do
                local mutation = item:GetAttribute("Mutation") or "Normal"
                local trait = item:GetAttribute("Trait") or "None"
                
                local b = MainTab:CreateButton({
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
                        
                        task.wait(0.3)
                        game:Shutdown()
                    end,
                })
                table.insert(currentButtons, b)
            end
            Rayfield:Notify({Title = "Scan Complete", Content = "Found " .. #foundItems .. " items."})
        end
    end,
})
