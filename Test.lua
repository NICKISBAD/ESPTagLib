

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
    box.Parent = _G.Settings.Part
end

-- 2D Outline (Outer)
if _G.Settings._2D_Outline.Enabled then
    local outlineOuter = Instance.new("BoxHandleAdornment")
    outlineOuter.Size = _G.Settings.Part.Size + Vector3.new(0.5, 0.5, 0.5)
    outlineOuter.Color3 = _G.Settings._2D_Outline.Color
    outlineOuter.Transparency = 0.5
    outlineOuter.AlwaysOnTop = true
    outlineOuter.Adornee = _G.Settings.Part
    outlineOuter.Parent = _G.Settings.Part
end

-- 2D Outline (Inner - Box)
if _G.Settings._2D_Outline.Enabled then
    local outlineInnerBox = Instance.new("BoxHandleAdornment")
    outlineInnerBox.Size = _G.Settings.Part.Size + Vector3.new(0.3, 0.3, 0.3)
    outlineInnerBox.Color3 = Color3.new(0.7, 1, 0.7) -- Light-ish green
    outlineInnerBox.Transparency = 0.5
    outlineInnerBox.AlwaysOnTop = true
    outlineInnerBox.Adornee = _G.Settings.Part
    outlineInnerBox.Parent = _G.Settings.Part
end

-- Chams
if _G.Settings.Chams.Enabled then
    local chams = Instance.new("Cham")
    chams.Color3 = _G.Settings.Chams.Color
    chams.Transparency = 0.5
    chams.Adornee = _G.Settings.Part
    chams.Parent = _G.Settings.Part
end

-- Highlight
if _G.Settings.Highlight.Enabled then
    _G.Settings.Part.BrickColor = BrickColor.new(_G.Settings.Highlight.Color)
end

-- Tracers
if _G.Settings.Tracers.Enabled then
    local line = Instance.new("LineHandleAdornment")
    line.Adornee = _G.Settings.Part
    line.Color3 = _G.Settings.Tracers.Color
    line.Thickness = 2
    line.Transparency = 0.5
    line.ZIndex = 2
    line.Parent = _G.Settings.Part
end

-- Distance
if _G.Settings.Distance.Enabled then
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Text = "Distance: "
    distanceLabel.TextColor3 = _G.Settings.Distance.Color
    distanceLabel.TextStrokeTransparency = 0
    distanceLabel.TextStrokeColor3 = _G.Settings.BoxOutlineColor
    distanceLabel.Position = UDim2.new(0, 0, 0, 50)
    distanceLabel.Parent = _G.Settings.Part
end

-- Name
if _G.Settings.Name.Enabled then
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Text = "PlayerName" -- Replace with actual player name
    nameLabel.TextColor3 = _G.Settings.Name.Color
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = _G.Settings.BoxOutlineColor
    nameLabel.Position = UDim2.new(0, 0, 0, 30)
    nameLabel.Parent = _G.Settings.Part
end

-- Health
if _G.Settings.Health.Enabled then
    local healthLabel = Instance.new("TextLabel")
    healthLabel.Text = "Health: 100%" -- Replace with actual health value
    healthLabel.TextColor3 = _G.Settings.Health.Color
    healthLabel.TextStrokeTransparency = 0
    healthLabel.TextStrokeColor3 = _G.Settings.BoxOutlineColor
    healthLabel.Position = UDim2.new(0, 0, 0, 70)
    healthLabel.Parent = _G.Settings.Part
end

-- Walkspeed
if _G.Settings.Walkspeed.Enabled then
    local walkspeedLabel = Instance.new("TextLabel")
    walkspeedLabel.Text = "Walkspeed: 16" -- Replace with actual walkspeed value
    walkspeedLabel.TextColor3 = _G.Settings.Walkspeed.Color
    walkspeedLabel.TextStrokeTransparency = 0
    walkspeedLabel.TextStrokeColor3 = _G.Settings.BoxOutlineColor
    walkspeedLabel.Position = UDim2.new(0, 0, 0, 90)
    walkspeedLabel.Parent = _G.Settings.Part
end
