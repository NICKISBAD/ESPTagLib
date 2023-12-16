-- Destroy existing ESP elements if DestroyESP is true
if _G.DestroyESP then
    for _, obj in pairs(_G.Settings.Part:GetChildren()) do
        if obj:IsA("Adornment") or obj:IsA("TextLabel") then
            obj:Destroy()
        end
    end
end

-- Box
if _G.Settings.Boxes.Enabled then
    local box = Instance.new("BoxHandleAdornment")
    box.Size = _G.Settings.Part.Size + Vector3.new(0, 0.5, 0)
    box.Color3 = _G.Settings.Boxes.Color
    box.Transparency = 0.5
    box.AlwaysOnTop = true
    box.Adornee = _G.Settings.Part
    box.Parent = _G.MasterSwitch and _G.Settings.Part or nil
end

-- ... (Same code for other ESP elements)

-- Walkspeed
if _G.Settings.Walkspeed.Enabled then
    local walkspeedLabel = Instance.new("TextLabel")
    walkspeedLabel.Text = "Walkspeed: " .. math.floor(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed)
    walkspeedLabel.TextColor3 = _G.Settings.Walkspeed.Color
    walkspeedLabel.TextStrokeTransparency = 0
    walkspeedLabel.TextStrokeColor3 = _G.Settings.BoxOutlineColor
    walkspeedLabel.Position = UDim2.new(0, 0, 0, 90) -- Adjust position as needed
    walkspeedLabel.Parent = _G.MasterSwitch and _G.Settings.Part or nil
end

-- ... (Same code for other ESP elements)

-- Update labels on a timer
while wait(1) do
    if _G.Settings.Walkspeed.Enabled then
        walkspeedLabel.Text = "Walkspeed: " .. math.floor(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed)
    end

    if _G.Settings.Health.Enabled then
        local health = math.floor(game.Players.LocalPlayer.Character.Humanoid.Health)
        healthLabel.Text = "Health: " .. health .. "%"

        -- Change health label color based on health status
        if health > 75 then
            healthLabel.TextColor3 = _G.Settings.Health.HighColor
        elseif health > 25 then
            healthLabel.TextColor3 = _G.Settings.Health.Color
        else
            healthLabel.TextColor3 = _G.Settings.Health.LowColor
        end
    end

    if _G.Settings.Jumppower.Enabled then
        jumppowerLabel.Text = "Jumppower: " .. math.floor(game.Players.LocalPlayer.Character.Humanoid.JumpPower)
    end

    -- Add other stat updates here
end
