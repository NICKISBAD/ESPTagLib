-- Initialize function()

local ESPLib = {}

function ESPLib:CreateESPTag(params)
    local RunService = game:GetService("RunService")
    local player = game.Players.LocalPlayer
    local camera = game:GetService("Workspace").CurrentCamera

    local Text = params.Text
    local Part = params.Part
    local TextSize = params.TextSize
    local TextColor = params.TextColor
    local BoxColor = params.BoxColor
    local TracerColor = params.TracerColor or Color3.new(255, 255, 255)  -- Default tracer color is white
    local TrailMode = params.TrailMode or false -- Default to regular tracer mode
    local TrailColor = params.TrailColor or {Color3.new(255, 0, 0)} -- Default trail color is red
    local TrailWidth = params.TrailWidth or {2} -- Default trail width is 2

    if #TrailColor < 2 then
        TrailColor[2] = TrailColor[1] -- Duplicate the color if only one is provided
    end

    if #TrailWidth < 2 then
        TrailWidth[2] = TrailWidth[1] -- Duplicate the width if only one is provided
    end

    local esp = Instance.new("BillboardGui")
    esp.Name = "esp"
    esp.Size = UDim2.new(0, 200, 0, 50)
    esp.StudsOffset = Vector3.new(0, Part.Size.Y + 2, 0) -- Adjusted offset for the label above the head
    esp.Adornee = Part
    esp.Parent = Part
    esp.AlwaysOnTop = true

    local esplabelfr = Instance.new("TextLabel")
    esplabelfr.Name = "esplabelfr"
    esplabelfr.Size = UDim2.new(1, 0, 0, 70)
    esplabelfr.BackgroundColor3 = Color3.new(0, 0, 0)
    esplabelfr.TextColor3 = TextColor or Color3.fromRGB(255, 255, 255)
    esplabelfr.BackgroundTransparency = 1
    esplabelfr.TextStrokeTransparency = 0
    esplabelfr.TextStrokeColor3 = Color3.new(0, 0, 0)
    esplabelfr.TextSize = TextSize
    esplabelfr.TextScaled = false
    esplabelfr.Font = "Arcade"
    esplabelfr.Parent = esp

    local box = Instance.new("BoxHandleAdornment")
    box.Name = "box"
    box.Size = Part.Size + Vector3.new(0.5, 0.5, 0.5)
    box.Adornee = Part
    box.AlwaysOnTop = true
    box.Transparency = 0.6
    box.Color3 = BoxColor or Color3.new(0, 0, 255)
    box.ZIndex = 0
    box.Parent = Part

    local tracerLine = Drawing.new("Line")
    tracerLine.Visible = false

    local trail = Instance.new("Trail")
    trail.Attachment0 = Part.Position
    trail.Attachment1 = Part.Position
    trail.Enabled = false
    trail.Color = ColorSequence.new(TrailColor[1], TrailColor[2])
    trail.Width = NumberSequence.new(TrailWidth[1], TrailWidth[2])
    trail.Parent = Part

    local function updateesplabelfr()
        if not Part or not Part:IsA("BasePart") or not Part.Parent then
            -- Part no longer exists, delete ESP elements
            esp:Destroy()
            tracerLine:Remove()
            trail:Destroy()
            return
        end

        local playerPosition = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if playerPosition then
            local distance = (playerPosition.Position - Part.Position).Magnitude
            esplabelfr.Text = string.format(Text .. ": %.2f", distance)

            local headPosition = Part.Position + Vector3.new(0, Part.Size.Y / 2, 0)
            local screenPosition, onScreen = camera:WorldToScreenPoint(headPosition)

            if onScreen or playerPosition.Position.Y > Part.Position.Y then
                esp.Adornee = Part
                esp.Enabled = true
                box.Adornee = Part
                box.Visible = true

                -- Update tracer line points
                local tracerStart = camera:WorldToViewportPoint(player.Character.Head.Position)
                local tracerEnd = camera:WorldToViewportPoint(Part.Position)
                tracerLine.From = Vector2.new(tracerStart.X, tracerStart.Y)
                tracerLine.To = Vector2.new(tracerEnd.X, tracerEnd.Y)
                tracerLine.Color = TracerColor
                tracerLine.Thickness = 2 -- Adjust the thickness of the line (increased from 1)
                tracerLine.Visible = not TrailMode

                -- Update trail
                trail.Attachment1 = Part.Position
                trail.Enabled = TrailMode
                trail.Color = ColorSequence.new(TrailColor[1], TrailColor[2])
                trail.Width = NumberSequence.new(TrailWidth[1], TrailWidth[2])
            else
                esp.Enabled = false
                box.Visible = false
                tracerLine.Visible = false
                trail.Enabled = false
            end
        else
            esp.Enabled = false
            box.Visible = false
            tracerLine.Visible = false
            trail.Enabled = false
        end
    end

    RunService.RenderStepped:Connect(updateesplabelfr)
end


-- Usage

ESPLib:CreateESPTag({
    Text = "example",
    Part = workspace.Part, -- Replace 'Part' with the actual reference to your part
    TextSize = 5,
    TextColor = Color3.new(255, 255, 255),
    BoxColor = Color3.new(0, 0, 255),
    TrailMode = true, -- Set to true for trail mode, false for regular tracer mode
    TrailColor = {Color3.new(0, 255, 0), Color3.new(0, 0, 255)}, -- Set the trail color sequence
    TrailWidth = {2, 4} -- Set the trail width sequence
})
