-- PAINEL LUCAS - Script Local
-- by ChatGPT (feito pra uso autorizado)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local cam = workspace.CurrentCamera

-- CONFIG
local savedPos = nil
local floatSpeed = 2
local movingToSaved = false
local floatHeight = 3

-- NOVO: VOAR
local flying = false
local flySpeed = 2

--====================== CRIAR GUI ============================

local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "LUCAS"

local toggle = Instance.new("TextButton", ScreenGui)
toggle.Size = UDim2.new(0, 80, 0, 35)
toggle.Position = UDim2.new(0, 10, 0.8, 0)
toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Text = "Abrir"
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 18

local main = Instance.new("Frame", ScreenGui)
main.Size = UDim2.new(0, 250, 0, 240)
main.Position = UDim2.new(0.05, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.Active = true
main.Draggable = true
main.BorderSizePixel = 0
main.Visible = false

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "PAINEL LUCAS"
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

-- Botão salvar local
local saveBtn = Instance.new("TextButton", main)
saveBtn.Position = UDim2.new(0, 10, 0, 40)
saveBtn.Size = UDim2.new(0, 100, 0, 35)
saveBtn.Text = "Salvar Local"
saveBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
saveBtn.TextColor3 = Color3.new(1,1,1)

-- Botão ir ao local
local goBtn = Instance.new("TextButton", main)
goBtn.Position = UDim2.new(0, 130, 0, 40)
goBtn.Size = UDim2.new(0, 100, 0, 35)
goBtn.Text = "Ir ao Local"
goBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
goBtn.TextColor3 = Color3.new(1,1,1)

-- Velocidade
local speedLabel = Instance.new("TextLabel", main)
speedLabel.Position = UDim2.new(0, 10, 0, 90)
speedLabel.Size = UDim2.new(0, 230, 0, 25)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Velocidade: "..floatSpeed
speedLabel.TextColor3 = Color3.new(1,1,1)

local minusBtn = Instance.new("TextButton", main)
minusBtn.Position = UDim2.new(0, 10, 0, 120)
minusBtn.Size = UDim2.new(0, 40, 0, 30)
minusBtn.Text = "-"
minusBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
minusBtn.TextColor3 = Color3.new(1,1,1)

local plusBtn = Instance.new("TextButton", main)
plusBtn.Position = UDim2.new(0, 200, 0, 120)
plusBtn.Size = UDim2.new(0, 40, 0, 30)
plusBtn.Text = "+"
plusBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
plusBtn.TextColor3 = Color3.new(1,1,1)

-- ===================== NOVO: BOTÃO DE VOAR =====================

local flyBtn = Instance.new("TextButton", main)
flyBtn.Position = UDim2.new(0, 10, 0, 160)
flyBtn.Size = UDim2.new(0, 220, 0, 35)
flyBtn.Text = "Ativar Voo"
flyBtn.BackgroundColor3 = Color3.fromRGB(200, 120, 0)
flyBtn.TextColor3 = Color3.new(1,1,1)

--====================== FUNÇÕES ============================

saveBtn.MouseButton1Click:Connect(function()
    savedPos = hrp.Position
    saveBtn.Text = "Salvo!"
    task.wait(0.7)
    saveBtn.Text = "Salvar Local"
end)

goBtn.MouseButton1Click:Connect(function()
    if savedPos then
        movingToSaved = true
    end
end)

plusBtn.MouseButton1Click:Connect(function()
    floatSpeed = floatSpeed + 1
    speedLabel.Text = "Velocidade: "..floatSpeed
end)

minusBtn.MouseButton1Click:Connect(function()
    floatSpeed = math.max(1, floatSpeed - 1)
    speedLabel.Text = "Velocidade: "..floatSpeed
end)

-- ===================== VOAR =====================

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    flyBtn.Text = flying and "Desativar Voo" or "Ativar Voo"
end)

RunService.RenderStepped:Connect(function()
    -- movimento flutuante
    if movingToSaved and savedPos then
        local target = Vector3.new(savedPos.X, savedPos.Y + floatHeight, savedPos.Z)
        local dir = (target - hrp.Position).Unit
        local dist = (target - hrp.Position).Magnitude

        if dist > 1 then
            hrp.Velocity = dir * floatSpeed * 10
        else
            hrp.Velocity = Vector3.new(0, 0, 0)
            movingToSaved = false
        end
    end

    -- NOVO: VOAR
    if flying then
        local look = cam.CFrame.LookVector
        hrp.Velocity = look * (flySpeed * 20)
    end
end)

--====================== ABRIR/FECHAR ============================

local aberto = false
toggle.MouseButton1Click:Connect(function()
    aberto = not aberto
    main.Visible = aberto
    toggle.Text = aberto and "Fechar" or "Abrir"
end)
