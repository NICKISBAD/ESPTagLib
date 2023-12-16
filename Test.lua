-- Destroy existing ESP elements if DestroyESP is true
if _G.DestroyESP then
    for _, obj in pairs(_G.Settings.Part:GetChildren()) do
        if obj:IsA("Adornment") or obj:IsA("TextLabel") then
            obj:Destroy()
        end
    end
end

-- Check if the part has a Humanoid
local humanoid = _G.Settings.Part:FindFirstChildOfClass("Humanoid")

if humanoid then
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

    -- 2D Outline (Outer)
    if _G.Settings._2D_Outline.Enabled then
        local outlineOuter = Instance.new("BoxHandleAdornment")
        outlineOuter.Size = _G.Settings.Part.Size + Vector3.new(0.5, 0.5, 0.5)
        outlineOuter.Color3 = _G.Settings._2D_Outline.Color
        outlineOuter.Transparency = 0.5
        outlineOuter.AlwaysOnTop = true
        outlineOuter.Adornee = _G.Settings.Part
        outlineOuter.Parent = _G.MasterSwitch and _G.Settings.Part or nil
    end

    -- 2D Outline (Inner - Box)
    if _G.Settings._2D_Outline.Enabled then
        local outlineInnerBox = Instance.new("BoxHandleAdornment")
        outlineInnerBox.Size = _G.Settings.Part.Size + Vector3.new(0.3, 0.3, 0.3)
        outlineInnerBox.Color3 = Color3.new(0.7, 1, 0.7) -- Light-ish green
        outlineInnerBox.Transparency = 0.5
        outlineInnerBox.AlwaysOnTop = true
        outlineInnerBox.Adornee = _G.Settings.Part
        outlineInnerBox.Parent = _G.MasterSwitch and _G.Settings.Part or nil
    end

    -- Walkspeed
    if _G.Settings.Walkspeed.Enabled then
        local walkspeedLabel = Instance.new("TextLabel")
        walkspeedLabel.Text = "Walkspeed: " .. math.floor(humanoid.WalkSpeed)
        walkspeedLabel.TextColor3 = _G.Settings.Walkspeed.Color
        walkspeedLabel.TextStrokeTransparency = 0
        walkspeedLabel.TextStrokeColor3 = _G.Settings.BoxOutlineColor
        walkspeedLabel.Position = UDim2.new(0, 0, 0, 90) -- Adjust position as needed
        walkspeedLabel.Parent = _G.MasterSwitch and _G.Settings.Part or nil
    end

    -- Update labels on a timer
    spawn(function()
        while wait(1) do
            if _G.Settings.Walkspeed.Enabled then
                walkspeedLabel.Text = "Walkspeed: " .. math.floor(humanoid.WalkSpeed)
            end

            if _G.Settings.Health.Enabled then
                local health = math.floor(humanoid.Health)
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
                jumppowerLabel.Text = "Jumppower: " .. math.floor(humanoid.JumpPower)
            end

            -- Add other stat updates here
        end
    end)
else
    warn("The part does not have a Humanoid. Health and stats won't be displayed.")
end
