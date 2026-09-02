local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local TargetParent = (gethui and gethui()) or CoreGui:FindFirstChild("RobloxGui") or LocalPlayer:WaitForChild("PlayerGui")

-- حذف الواجهة القديمة إذا كانت موجودة
if TargetParent:FindFirstChild("JsoomHubGui") then
    TargetParent:FindFirstChild("JsoomHubGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JsoomHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = TargetParent

----------------------------------------------------
-- 1. شاشة التحميل (Loading Screen)
----------------------------------------------------
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.Position = UDim2.new(0, 0, 0, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoadingFrame.ZIndex = 100
LoadingFrame.Parent = ScreenGui

local LoadingText = Instance.new("TextLabel")
LoadingText.Name = "LoadingText"
LoadingText.Size = UDim2.new(0.9, 0, 0.9, 0)
LoadingText.Position = UDim2.new(0.05, 0, 0.05, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "تيل بكل واحد ما سوا فولو"
LoadingText.TextColor3 = Color3.fromRGB(255, 0, 0)
LoadingText.TextScaled = true
LoadingText.Font = Enum.Font.SourceSansBold
LoadingText.ZIndex = 101
LoadingText.Parent = LoadingFrame

local SizeConstraint = Instance.new("UITextSizeConstraint")
SizeConstraint.MaxTextSize = 48
SizeConstraint.MinTextSize = 24
SizeConstraint.Parent = LoadingText

----------------------------------------------------
-- 2. القائمة الرئيسية (Main UI)
----------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 480)
MainFrame.Position = UDim2.new(0.5, -160, 0.4, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Visible = false -- ستظهر بعد شاشة التحميل
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(0.75, 0, 0, 40)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "[سكربت خصيصا لاحين جسوم بالعالم]"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

-- زر الإخفاء الصغير أعلى اليمين (-)
local HideMiniButton = Instance.new("TextButton")
HideMiniButton.Name = "HideMiniButton"
HideMiniButton.Size = UDim2.new(0, 28, 0, 28)
HideMiniButton.Position = UDim2.new(1, -34, 0, 6)
HideMiniButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
HideMiniButton.Text = "-"
HideMiniButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideMiniButton.TextSize = 20
HideMiniButton.Font = Enum.Font.SourceSansBold
HideMiniButton.Parent = MainFrame

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 6)
MiniCorner.Parent = HideMiniButton

----------------------------------------------------
-- 3. زر الـ Toggle العائم (JASIME HUB)
----------------------------------------------------
local FloatingToggle = Instance.new("TextButton")
FloatingToggle.Name = "FloatingToggle"
FloatingToggle.Size = UDim2.new(0, 120, 0, 40)
FloatingToggle.Position = UDim2.new(0, 15, 0.4, 0)
FloatingToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FloatingToggle.Text = "JASIME HUB"
FloatingToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingToggle.TextSize = 15
FloatingToggle.Font = Enum.Font.SourceSansBold
FloatingToggle.Visible = false
FloatingToggle.Active = true
FloatingToggle.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = FloatingToggle

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(255, 0, 0)
ToggleStroke.Thickness = 1.5
ToggleStroke.Parent = FloatingToggle

----------------------------------------------------
-- إنشاء الأزرار داخل الواجهة
----------------------------------------------------
local function createButton(name, text, color, posY)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0.88, 0, 0, 36)
    btn.Position = UDim2.new(0.06, 0, 0, posY)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    return btn
end

local ToggleButton      = createButton("ToggleButton", "الضغط السريع (بدون انتظار): إيقاف", Color3.fromRGB(180, 40, 40), 42)
local SpamButton        = createButton("SpamButton", "تكرار الضغط (Steal فقط): إيقاف", Color3.fromRGB(180, 40, 40), 85)
local ESPButton         = createButton("ESPButton", "كشف هيكل اللاعب والسلاح (3D): إيقاف", Color3.fromRGB(180, 40, 40), 128)
local TracerButton      = createButton("TracerButton", "خطوط تتبع رينبو: إيقاف", Color3.fromRGB(180, 40, 40), 171)
local AntiRagdollButton = createButton("AntiRagdollButton", "منع السقوط (Anti-Ragdoll): إيقاف", Color3.fromRGB(180, 40, 40), 214)
local AntiLagButton     = createButton("AntiLagButton", "تسريع اللعبة (Anti-Lag): إيقاف", Color3.fromRGB(180, 40, 40), 257)
local TPStealMenuBtn    = createButton("TPStealMenuBtn", "قائمة السرقة التلقائية (TP Steal)", Color3.fromRGB(230, 120, 0), 300)
local UnderButton       = createButton("UnderButton", "النزول تحت الأرض (Platform)", Color3.fromRGB(40, 90, 180), 343)
local SpawnButton       = createButton("SpawnButton", "الرجوع لنقطة الرسبون", Color3.fromRGB(140, 40, 180), 386)
local HideUIBtn         = createButton("HideUIBtn", "إخفاء القائمة", Color3.fromRGB(70, 70, 80), 429)

----------------------------------------------------
-- 4. نافذة قائمة أشكال وأسماء اللاعبين (Player Selection Panel)
----------------------------------------------------
local PlayerListFrame = Instance.new("Frame")
PlayerListFrame.Name = "PlayerListFrame"
PlayerListFrame.Size = UDim2.new(0, 260, 0, 320)
PlayerListFrame.Position = UDim2.new(0.5, 170, 0.4, -160)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.Visible = false
PlayerListFrame.Active = true
PlayerListFrame.Parent = ScreenGui

local PLCorner = Instance.new("UICorner")
PLCorner.CornerRadius = UDim.new(0, 10)
PLCorner.Parent = PlayerListFrame

local PLStroke = Instance.new("UIStroke")
PLStroke.Color = Color3.fromRGB(230, 120, 0)
PLStroke.Thickness = 2
PLStroke.Parent = PlayerListFrame

local PLTitle = Instance.new("TextLabel")
PLTitle.Name = "PLTitle"
PLTitle.Size = UDim2.new(1, -30, 0, 35)
PLTitle.Position = UDim2.new(0, 10, 0, 0)
PLTitle.BackgroundTransparency = 1
PLTitle.Text = "اختر لاعباً لسرقته لحظياً:"
PLTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PLTitle.TextSize = 13
PLTitle.Font = Enum.Font.SourceSansBold
PLTitle.TextXAlignment = Enum.TextXAlignment.Left
PLTitle.Parent = PlayerListFrame

local PLCloseBtn = Instance.new("TextButton")
PLCloseBtn.Name = "PLCloseBtn"
PLCloseBtn.Size = UDim2.new(0, 24, 0, 24)
PLCloseBtn.Position = UDim2.new(1, -28, 0, 6)
PLCloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
PLCloseBtn.Text = "X"
PLCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PLCloseBtn.TextSize = 12
PLCloseBtn.Font = Enum.Font.SourceSansBold
PLCloseBtn.Parent = PlayerListFrame

local PLCloseCorner = Instance.new("UICorner")
PLCloseCorner.CornerRadius = UDim.new(0, 6)
PLCloseCorner.Parent = PLCloseBtn

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(0.92, 0, 0.82, 0)
ScrollFrame.Position = UDim2.new(0.04, 0, 0.14, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 5
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Parent = PlayerListFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = ScrollFrame

----------------------------------------------------
-- نظام التحريك بالسحب (Drag System)
----------------------------------------------------
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

makeDraggable(MainFrame)
makeDraggable(FloatingToggle)
makeDraggable(PlayerListFrame)

----------------------------------------------------
-- منطق الإخفاء والإظهار
----------------------------------------------------
local function hideMainUI()
    MainFrame.Visible = false
    PlayerListFrame.Visible = false
    FloatingToggle.Visible = true
end

local function showMainUI()
    MainFrame.Visible = true
    FloatingToggle.Visible = false
end

HideMiniButton.MouseButton1Click:Connect(hideMainUI)
HideUIBtn.MouseButton1Click:Connect(hideMainUI)
FloatingToggle.MouseButton1Click:Connect(showMainUI)
PLCloseBtn.MouseButton1Click:Connect(function() PlayerListFrame.Visible = false end)

----------------------------------------------------
-- 1. منطق الضغط السريع بدون انتظار (Instant Hold)
----------------------------------------------------
local isEnabled = false
local originalDurations = {}

local function applyPromptLogic(prompt)
    if not originalDurations[prompt] then
        originalDurations[prompt] = prompt.HoldDuration
    end
    if isEnabled then
        prompt.HoldDuration = 0
    else
        prompt.HoldDuration = originalDurations[prompt] or prompt.HoldDuration
    end
end

ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
    if isEnabled then
        if fireproximityprompt then
            fireproximityprompt(prompt)
        else
            prompt.HoldDuration = 0
        end
    end
end)

Workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("ProximityPrompt") then
        task.wait(0.05)
        applyPromptLogic(descendant)
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    isEnabled = not isEnabled
    if isEnabled then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 180, 70)
        ToggleButton.Text = "الضغط السريع (بدون انتظار): تشغيل"
    else
        ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        ToggleButton.Text = "الضغط السريع (بدون انتظار): إيقاف"
    end
    
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            applyPromptLogic(v)
        end
    end
end)

----------------------------------------------------
-- 2. منطق تكرار الضغط السريع لـ Steal فقط
----------------------------------------------------
local isSpamming = false

SpamButton.MouseButton1Click:Connect(function()
    isSpamming = not isSpamming
    if isSpamming then
        SpamButton.BackgroundColor3 = Color3.fromRGB(40, 180, 70)
        SpamButton.Text = "تكرار الضغط (Steal فقط): تشغيل"
    else
        SpamButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        SpamButton.Text = "تكرار الضغط (Steal فقط): إيقاف"
    end
end)

task.spawn(function()
    while true do
        task.wait(0.05)
        if isSpamming then
            for _, prompt in ipairs(Workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                    local action = prompt.ActionText or ""
                    local object = prompt.ObjectText or ""
                    
                    if string.find(string.lower(action), "steal") or string.find(string.lower(object), "steal") then
                        if fireproximityprompt then
                            fireproximityprompt(prompt)
                        else
                            prompt.HoldDuration = 0
                            prompt:InputHoldBegin()
                            prompt:InputHoldEnd()
                        end
                    end
                end
            end
        end
    end
end)

----------------------------------------------------
-- 3. منطق كشف هيكل أجساد وأدوات اللاعبين (3D ESP Highlight)
----------------------------------------------------
local isESPEnabled = false
local espData = {}

local function removeESP(player)
    if espData[player] then
        if espData[player].CharHighlight then espData[player].CharHighlight:Destroy() end
        if espData[player].ToolHighlight then espData[player].ToolHighlight:Destroy() end
        if espData[player].Connections then
            for _, conn in ipairs(espData[player].Connections) do
                conn:Disconnect()
            end
        end
        espData[player] = nil
    end
end

local function createESP(player)
    if player == LocalPlayer then return end
    
    local function applyToChar(character)
        if not character then return end
        removeESP(player)
        
        local charHighlight = Instance.new("Highlight")
        charHighlight.Name = "JsoomBodyESP"
        charHighlight.FillColor = Color3.fromRGB(255, 0, 0)
        charHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        charHighlight.FillTransparency = 0.4
        charHighlight.OutlineTransparency = 0
        charHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        charHighlight.Adornee = character
        charHighlight.Parent = character
        
        local currentToolHighlight = nil
        local connections = {}
        
        local function updateToolHighlight()
            if currentToolHighlight then
                currentToolHighlight:Destroy()
                currentToolHighlight = nil
            end
            
            local tool = character:FindFirstChildOfClass("Tool")
            if tool then
                local toolHighlight = Instance.new("Highlight")
                toolHighlight.Name = "JsoomToolESP"
                toolHighlight.FillColor = Color3.fromRGB(255, 215, 0)
                toolHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                toolHighlight.FillTransparency = 0.1
                toolHighlight.OutlineTransparency = 0
                toolHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                toolHighlight.Adornee = tool
                toolHighlight.Parent = tool
                currentToolHighlight = toolHighlight
            end
        end
        
        updateToolHighlight()
        
        local childAdded = character.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                task.wait(0.05)
                updateToolHighlight()
            end
        end)
        
        local childRemoved = character.ChildRemoved:Connect(function(child)
            if child:IsA("Tool") then
                task.wait(0.05)
                updateToolHighlight()
            end
        end)
        
        table.insert(connections, childAdded)
        table.insert(connections, childRemoved)
        
        espData[player] = {
            CharHighlight = charHighlight,
            ToolHighlight = currentToolHighlight,
            Connections = connections
        }
    end

    if player.Character then
        applyToChar(player.Character)
    end
    
    local charAdded = player.CharacterAdded:Connect(applyToChar)
    if not espData[player] then
        espData[player] = { Connections = { charAdded } }
    else
        table.insert(espData[player].Connections, charAdded)
    end
end

ESPButton.MouseButton1Click:Connect(function()
    isESPEnabled = not isESPEnabled
    if isESPEnabled then
        ESPButton.BackgroundColor3 = Color3.fromRGB(40, 180, 70)
        ESPButton.Text = "كشف هيكل اللاعب والسلاح (3D): تشغيل"
        for _, plr in ipairs(Players:GetPlayers()) do
            createESP(plr)
        end
    else
        ESPButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        ESPButton.Text = "كشف هيكل اللاعب والسلاح (3D): إيقاف"
        for plr, _ in pairs(espData) do
            removeESP(plr)
        end
    end
end)

----------------------------------------------------
-- 4. منطق خطوط تتبع رينبو (Rainbow Tracers)
----------------------------------------------------
local isTracersEnabled = false
local tracers = {}

local function removeTracer(player)
    if tracers[player] then
        if tracers[player].Line then
            tracers[player].Line.Visible = false
            tracers[player].Line:Remove()
        end
        tracers[player] = nil
    end
end

local function createTracer(player)
    if player == LocalPlayer then return end
    if Drawing then
        local line = Drawing.new("Line")
        line.Thickness = 2
        line.Transparency = 1
        line.Visible = false
        tracers[player] = { Line = line }
    end
end

TracerButton.MouseButton1Click:Connect(function()
    isTracersEnabled = not isTracersEnabled
    if isTracersEnabled then
        TracerButton.BackgroundColor3 = Color3.fromRGB(40, 180, 70)
        TracerButton.Text = "خطوط تتبع رينبو: تشغيل"
        for _, plr in ipairs(Players:GetPlayers()) do
            createTracer(plr)
        end
    else
        TracerButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        TracerButton.Text = "خطوط تتبع رينبو: إيقاف"
        for plr, _ in pairs(tracers) do
            removeTracer(plr)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if not isTracersEnabled then return end
    
    local rainbowColor = Color3.fromHSV((tick() * 0.4) % 1, 1, 1)
    local bottomScreenPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if not tracers[plr] then
                createTracer(plr)
            end
            
            local data = tracers[plr]
            if data and data.Line then
                local character = plr.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local hrp = character.HumanoidRootPart
                    local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                    
                    if onScreen then
                        data.Line.From = bottomScreenPos
                        data.Line.To = Vector2.new(screenPos.X, screenPos.Y)
                        data.Line.Color = rainbowColor
                        data.Line.Visible = true
                    else
                        data.Line.Visible = false
                    end
                else
                    data.Line.Visible = false
                end
            end
        end
    end
end)

----------------------------------------------------
-- 5. منطق منع السقوط والتخدير (Anti-Ragdoll)
----------------------------------------------------
local isAntiRagdollEnabled = false

local function applyAntiRagdoll(character)
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    end
end

RunService.Stepped:Connect(function()
    if isAntiRagdollEnabled and LocalPlayer.Character then
        local character = LocalPlayer.Character
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if humanoid then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            
            if humanoid.PlatformStand then
                humanoid.PlatformStand = false
            end
            
            local currentState = humanoid:GetState()
            if currentState == Enum.HumanoidStateType.Ragdoll or currentState == Enum.HumanoidStateType.FallingDown then
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end
        
        for _, obj in ipairs(character:GetDescendants()) do
            if obj:IsA("Motor6D") and not obj.Enabled then
                obj.Enabled = true
            elseif obj:IsA("BallSocketConstraint") or obj:IsA("HingeConstraint") or (obj:IsA("Attachment") and string.find(string.lower(obj.Name), "ragdoll")) then
                obj:Destroy()
            end
        end
    end
end)

AntiRagdollButton.MouseButton1Click:Connect(function()
    isAntiRagdollEnabled = not isAntiRagdollEnabled
    if isAntiRagdollEnabled then
        AntiRagdollButton.BackgroundColor3 = Color3.fromRGB(40, 180, 70)
        AntiRagdollButton.Text = "منع السقوط (Anti-Ragdoll): تشغيل"
        if LocalPlayer.Character then
            applyAntiRagdoll(LocalPlayer.Character)
        end
    else
        AntiRagdollButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        AntiRagdollButton.Text = "منع السقوط (Anti-Ragdoll): إيقاف"
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    if isAntiRagdollEnabled then
        task.wait(0.1)
        applyAntiRagdoll(char)
    end
end)

----------------------------------------------------
-- 6. منطق تسريع اللعبة وتقليل اللاج (Anti-Lag)
----------------------------------------------------
local isAntiLagEnabled = false

local function applyAntiLagToObject(v)
    if v:IsA("BasePart") and not v:IsA("MeshPart") then
        v.Material = Enum.Material.SmoothPlastic
        v.CastShadow = false
    elseif v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Trail") or v:IsA("Beam") then
        v.Enabled = false
    elseif v:IsA("Explosion") then
        v.Visible = false
    end
end

local function enableAntiLag()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled = false
        end
    end
    
    for _, v in ipairs(Workspace:GetDescendants()) do
        applyAntiLagToObject(v)
    end
end

AntiLagButton.MouseButton1Click:Connect(function()
    isAntiLagEnabled = not isAntiLagEnabled
    if isAntiLagEnabled then
        AntiLagButton.BackgroundColor3 = Color3.fromRGB(40, 180, 70)
        AntiLagButton.Text = "تسريع اللعبة (Anti-Lag): تشغيل"
        enableAntiLag()
    else
        AntiLagButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        AntiLagButton.Text = "تسريع اللعبة (Anti-Lag): إيقاف"
    end
end)

Workspace.DescendantAdded:Connect(function(v)
    if isAntiLagEnabled then
        task.wait(0.01)
        applyAntiLagToObject(v)
    end
end)

----------------------------------------------------
-- 7. منطق قائمة أسماء اللاعبين والسرقة اللحظية (TP Steal Logic)
----------------------------------------------------
local function performTPSteal(targetPlayer)
    local myChar = LocalPlayer.Character
    local targetChar = targetPlayer.Character
    
    if myChar and myChar:FindFirstChild("HumanoidRootPart") and targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
        local myHRP = myChar.HumanoidRootPart
        local targetHRP = targetChar.HumanoidRootPart
        
        -- حفظ الموقع الأصلي للاعب
        local originalCFrame = myHRP.CFrame
        
        -- الانتقال اللحظي بجانب اللاعب المستهدف
        myHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 2)
        task.wait(0.05)
        
        -- التفاعل مع كافة أزرار السرقة
        for _, prompt in ipairs(Workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                if fireproximityprompt then
                    fireproximityprompt(prompt)
                else
                    prompt.HoldDuration = 0
                    prompt:InputHoldBegin()
                    prompt:InputHoldEnd()
                end
            end
        end
        
        task.wait(0.1)
        -- العودة اللحظية للموقع الأصلي
        myHRP.CFrame = originalCFrame
    end
end

local function refreshPlayerList()
    for _, child in ipairs(ScrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local count = 0
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            count = count + 1
            local pBtn = Instance.new("TextButton")
            pBtn.Name = plr.Name
            pBtn.Size = UDim2.new(1, -10, 0, 36)
            pBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
            pBtn.Text = plr.DisplayName .. " (@" .. plr.Name .. ")"
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.TextSize = 12
            pBtn.Font = Enum.Font.SourceSansBold
            pBtn.TextTruncate = Enum.TextTruncate.AtEnd
            pBtn.Parent = ScrollFrame
            
            local pCorner = Instance.new("UICorner")
            pCorner.CornerRadius = UDim.new(0, 6)
            pCorner.Parent = pBtn
            
            pBtn.MouseButton1Click:Connect(function()
                performTPSteal(plr)
            end)
        end
    end
    
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, count * 41)
end

TPStealMenuBtn.MouseButton1Click:Connect(function()
    PlayerListFrame.Visible = not PlayerListFrame.Visible
    if PlayerListFrame.Visible then
        refreshPlayerList()
    end
end)

Players.PlayerAdded:Connect(function(plr)
    if isESPEnabled then createESP(plr) end
    if isTracersEnabled then createTracer(plr) end
    if PlayerListFrame.Visible then refreshPlayerList() end
end)

Players.PlayerRemoving:Connect(function(plr)
    removeESP(plr)
    removeTracer(plr)
    if PlayerListFrame.Visible then refreshPlayerList() end
end)

----------------------------------------------------
-- 8. منطق الانتقالات (تحت الأرض والـ Spawn)
----------------------------------------------------
local safePlatform

UnderButton.MouseButton1Click:Connect(function()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        
        if not safePlatform or not safePlatform.Parent then
            safePlatform = Instance.new("Part")
            safePlatform.Name = "JsoomSafePlatform"
            safePlatform.Size = Vector3.new(20, 3, 20)
            safePlatform.Position = Vector3.new(hrp.Position.X, hrp.Position.Y - 80, hrp.Position.Z)
            safePlatform.Anchored = true
            safePlatform.CanCollide = true
            safePlatform.Material = Enum.Material.SmoothPlastic
            safePlatform.Color = Color3.fromRGB(0, 170, 255)
            safePlatform.Parent = Workspace
        end
        
        hrp.CFrame = safePlatform.CFrame * CFrame.new(0, 4, 0)
    end
end)

SpawnButton.MouseButton1Click:Connect(function()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        
        local spawnLoc = Workspace:FindFirstChildOfClass("SpawnLocation")
        if spawnLoc then
            hrp.CFrame = spawnLoc.CFrame * CFrame.new(0, 4, 0)
        else
            hrp.CFrame = CFrame.new(0, 50, 0)
        end
    end
end)

----------------------------------------------------
-- تشغيل المؤقت لمدة 3 ثواني لشاشة التحميل
----------------------------------------------------
task.spawn(function()
    task.wait(3)
    LoadingFrame:Destroy()
    MainFrame.Visible = true
end)
