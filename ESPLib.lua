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
    local Mode = params.Mode or "tracer"
    local TracerColor = params.TracerColor or Color3.new(255, 255, 255)
    local TracerWidth = params.TracerWidth or 2
    local TrailColor = params.TrailColor or Color3.new(255, 255, 255)
    local TrailWidth = params.TrailWidth or 2

    local esp = Instance.new("BillboardGui")
    esp.Name = "esp"
    esp.Size = UDim2.new(0, 200, 0, 50)
    esp.StudsOffset = Vector3.new(0, Part.Size.Y + 2, 0)
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

    local trailLine = Instance.new("Trail")
    trailLine.Attachment0 = player.Character:WaitForChild("HumanoidRootPart").CFrame
    trailLine.Attachment1 = Part.CFrame
    trailLine.Color = TrailColor
    trailLine.LightEmission = 1
    trailLine.Transparency = NumberSequence.new(0, 0.5)
    trailLine.TextureMode = Enum.TextureMode.Wrap
    trailLine.TextureLength = 1
    trailLine.TextureSpeed = 0.5
    trailLine.WidthScale = TrailWidth
    trailLine.Lifetime = 1

    local function updateesplabelfr()
        if not Part or not Part:IsA("BasePart") or not Part.Parent then
            esp:Destroy()
            tracerLine:Remove()
            trailLine:Destroy()
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

                if Mode == "tracer" then
                    local tracerStart = camera:WorldToViewportPoint(player.Character.Head.Position)
                    local tracerEnd = camera:WorldToViewportPoint(headPosition)
                    tracerLine.From = Vector2.new(tracerStart.X, tracerStart.Y)
                    tracerLine.To = Vector2.new(tracerEnd.X, tracerEnd.Y)
                    tracerLine.Color = TracerColor
                    tracerLine.Thickness = TracerWidth
                    tracerLine.Visible = true
                elseif Mode == "trail" then
                    trailLine.Attachment0 = player.Character:WaitForChild("HumanoidRootPart").CFrame
                    trailLine.Attachment1 = Part.CFrame
                    trailLine.Color = TrailColor
                    trailLine.WidthScale = TrailWidth
                    trailLine.Visible = true
                end
            else
                esp.Enabled = false
                box.Visible = false
                tracerLine.Visible = false
                trailLine.Visible = false
            end
        else
            esp.Enabled = false
            box.Visible = false
            tracerLine.Visible = false
            trailLine.Visible = false
        end
    end

    RunService.RenderStepped:Connect(updateesplabelfr)
end
