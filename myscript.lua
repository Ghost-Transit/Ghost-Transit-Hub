task.wait(math.random(3, 6))

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local function CheckForAdmins()
    for _, player in pairs(game.Players:GetChildren()) do
        if player:GetRankInGroup(1) > 100 or player.AccountAge < 1 then 
            game:GetService("TeleportService"):Teleport(game.PlaceId)
        end
    end
end
CheckForAdmins()

local Config = {
    BaseFolderName = "Plots",
    ItemFolderName = "Drops",
    TargetMutation = "Diamond",
    HopDelay = 1.5
}

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
    Name = "🕵️ GHOST HUB | ANTI-DETECTION",
    LoadingTitle = "Ghost Protocol v2...",
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
                        task.wait(0.1)
                    end
                end
            end
        end
    end
    
    task.wait(Config.HopDelay)
    TeleportService:Teleport(game.PlaceId)
end

MainTab:CreateButton({
    Name = "SAFE EXECUTE: SNATCH & HOP",
    Callback = function()
        SnatchAndRun()
    end,
})
