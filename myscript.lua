local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Config = {
    BaseFolderName = "Plots",
    ItemFolderName = "Drops",
    TargetMutation = "Diamond",
    HopDelay = 0.08
}

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
    Name = "🕵️ SERIAL KILLER | PURE THIEF EDITION",
    LoadingTitle = "Ghost Protocol Activating...",
    LoadingSubtitle = "by Gemini AI",
    ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Main Snatcher", 4483362458)

local function SnatchAndRun()
    local myBase = workspace[Config.BaseFolderName]:FindFirstChild(LocalPlayer.Name)
    
    if not myBase then
        Rayfield:Notify({Title = "Error", Content = "Base not found!"})
        return
    end

    for _, base in pairs(workspace[Config.BaseFolderName]:GetChildren()) do
        if base.Name ~= LocalPlayer.Name then
            local items = base:FindFirstChild(Config.ItemFolderName)
            
            if items then
                for _, item in pairs(items:GetChildren()) do
                    if item:IsA("BasePart") or item:IsA("Model") then
                        local targetPos = myBase.PrimaryPart.Position + Vector3.new(0, 5, 0)
                        
                        if item:IsA("Model") then
                            item:SetPrimaryPartCFrame(CFrame.new(targetPos))
                        else
                            item.CFrame = CFrame.new(targetPos)
                        end

                        task.wait(Config.HopDelay)
                        
                        local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
                        for _, s in pairs(Servers.data) do
                            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                                TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id)
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end

MainTab:CreateButton({
    Name = "EXECUTE: SILENT SNATCH & HOP",
    Callback = function()
        Rayfield:Notify({Title = "Vanish Mode", Content = "Executing Snatch..."})
        SnatchAndRun()
    end,
})

task.spawn(function()
    while task.wait(5) do
        for _, player in pairs(Players:GetPlayers()) do
            if player:GetRankInGroup(1) > 100 then
                TeleportService:Teleport(game.PlaceId)
            end
        end
    end

end)
