--[[ 
    LEMON TROLL 🍋 - Script para Roblox Studio
    Menu Flutuante com ESP Tracers, Torso Skybox e Teleporte por Nome
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- Cores do Design
local COR_FUNDO = Color3.fromRGB(25, 25, 25)
local COR_ACENTO = Color3.fromRGB(255, 230, 0) -- Amarelo Limão
local COR_BOTAO = Color3.fromRGB(45, 45, 45)

-- 1. CRIAÇÃO DA INTERFACE (GUI)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LemonTrollGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Botão para Reabrir (Limão)
local openButton = Instance.new("ImageButton")
openButton.Name = "LemonOpenButton"
openButton.Size = UDim2.new(0, 60, 0, 60)
openButton.Position = UDim2.new(0.02, 0, 0.45, 0)
openButton.Image = "rbxassetid://6034287525" -- ID do limão
openButton.BackgroundColor3 = COR_ACENTO
openButton.BackgroundTransparency = 0
openButton.Visible = false

local cornerOpen = Instance.new("UICorner")
cornerOpen.CornerRadius = UDim.new(1, 0)
cornerOpen.Parent = openButton
openButton.Parent = screenGui

-- Menu Principal (Frame)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 240, 0, 380)
mainFrame.Position = UDim2.new(0.5, -120, 0.5, -190)
mainFrame.BackgroundColor3 = COR_FUNDO
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui

local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 10)
cornerMain.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Lemon troll 🍋"
title.TextColor3 = COR_ACENTO
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
title.Parent = mainFrame

local cornerTitle = Instance.new("UICorner")
cornerTitle.CornerRadius = UDim.new(0, 10)
cornerTitle.Parent = title

-- Botão Fechar (X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeButton.Parent = mainFrame

local cornerClose = Instance.new("UICorner")
cornerClose.CornerRadius = UDim.new(0, 6)
cornerClose.Parent = closeButton

-- Layout dos Botões Internos
local container = Instance.new("Frame")
container.Size = UDim2.new(1, 0, 1, -45)
container.Position = UDim2.new(0, 0, 0, 45)
container.BackgroundTransparency = 1
container.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Parent = container
layout.Padding = UDim.new(0, 6)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- 2. FUNÇÃO PARA ARRASTAR O MENU
local dragging, dragInput, dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Abrir e Fechar Menu
closeButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	openButton.Visible = true
end)

openButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	openButton.Visible = false
end)

-- 3. CRIAÇÃO DOS BOTÕES E ELEMENTOS
local function criarBotao(texto, tamanhoY)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 200, 0, tamanhoY or 35)
	btn.BackgroundColor3 = COR_BOTAO
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 13
	btn.Font = Enum.Font.Gotham
	btn.Text = texto
	btn.Parent = container
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = btn
	return btn
end

local speedBtn = criarBotao("Speed: OFF")
local jumpBtn = criarBotao("Jump: OFF")
local noclipBtn = criarBotao("Noclip: OFF")

-- Caixa de Texto para Nome do Jogador
local nameInput = Instance.new("TextBox")
nameInput.Size = UDim2.new(0, 200, 0, 35)
nameInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
nameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
nameInput.PlaceholderText = "Nome do Jogador..."
nameInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
nameInput.Font = Enum.Font.Gotham
nameInput.TextSize = 13
nameInput.Text = ""
nameInput.Parent = container

local cornerInput = Instance.new("UICorner")
cornerInput.CornerRadius = UDim.new(0, 8)
cornerInput.Parent = nameInput

local tpBtn = criarBotao("⚡ Teleport to Player", 35)
tpBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)

local espBtn = criarBotao("ESP Tracers: OFF")
local torsoSkyBtn = criarBotao("Torso Skybox: OFF")

-- Estados das Funções
local speedAtivo, jumpAtivo, noclipAtivo = false, false, false
local espAtivo, torsoSkyAtivo = false, false

speedBtn.MouseButton1Click:Connect(function()
	speedAtivo = not speedAtivo
	speedBtn.Text = speedAtivo and "Speed: ON" or "Speed: OFF"
	speedBtn.TextColor3 = speedAtivo and COR_ACENTO or Color3.fromRGB(255, 255, 255)
end)

jumpBtn.MouseButton1Click:Connect(function()
	jumpAtivo = not jumpAtivo
	jumpBtn.Text = jumpAtivo and "Jump: ON" or "Jump: OFF"
	jumpBtn.TextColor3 = jumpAtivo and COR_ACENTO or Color3.fromRGB(255, 255, 255)
end)

noclipBtn.MouseButton1Click:Connect(function()
	noclipAtivo = not noclipAtivo
	noclipBtn.Text = noclipAtivo and "Noclip: ON" or "Noclip: OFF"
	noclipBtn.TextColor3 = noclipAtivo and COR_ACENTO or Color3.fromRGB(255, 255, 255)
end)

espBtn.MouseButton1Click:Connect(function()
	espAtivo = not espAtivo
	espBtn.Text = espAtivo and "ESP Tracers: ON" or "ESP Tracers: OFF"
	espBtn.TextColor3 = espAtivo and COR_ACENTO or Color3.fromRGB(255, 255, 255)
end)

torsoSkyBtn.MouseButton1Click:Connect(function()
	torsoSkyAtivo = not torsoSkyAtivo
	torsoSkyBtn.Text = torsoSkyAtivo and "Torso Skybox: ON" or "Torso Skybox: OFF"
	torsoSkyBtn.TextColor3 = torsoSkyAtivo and COR_ACENTO or Color3.fromRGB(255, 255, 255)
end)

-- 4. TELEPORTE POR CAIXA DE TEXTO
tpBtn.MouseButton1Click:Connect(function()
	local text = string.lower(nameInput.Text)
	if text == "" then return end
	
	for _, targetPlayer in pairs(Players:GetPlayers()) do
		if targetPlayer ~= player then
			local name = string.lower(targetPlayer.Name)
			local displayName = string.lower(targetPlayer.DisplayName)
			
			if string.find(name, text) or string.find(displayName, text) then
				if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
					local myChar = player.Character
					if myChar and myChar:FindFirstChild("HumanoidRootPart") then
						myChar.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
					end
				end
				break
			end
		end
	end
end)

-- 5. LÓGICA DE ESP, TRACERS E TORSO SKYBOX
local highlights = {}
local beams = {}

local function limparESP()
	for _, hl in pairs(highlights) do if hl then hl:Destroy() end end
	for _, data in pairs(beams) do 
		if data.a0 then data.a0:Destroy() end
		if data.a1 then data.a1:Destroy() end
		if data.beam then data.beam:Destroy() end 
	end
	highlights = {}
	beams = {}
end

RunService.RenderStepped:Connect(function()
	local char = player.Character
	
	-- Speed
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = speedAtivo and 100 or 16 end
	end
	
	-- ESP & Tracers
	if espAtivo then
		for _, target in pairs(Players:GetPlayers()) do
			if target ~= player and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
				local tChar = target.Character
				
				-- Destaque/Silhouette
				if not tChar:FindFirstChild("LemonESP") then
					local hl = Instance.new("Highlight")
					hl.Name = "LemonESP"
					hl.FillColor = COR_ACENTO
					hl.OutlineColor = Color3.fromRGB(255, 255, 255)
					hl.FillTransparency = 0.5
					hl.Parent = tChar
					table.insert(highlights, hl)
				end
				
				-- Linha Tracer
				if char and char:FindFirstChild("HumanoidRootPart") and not tChar:FindFirstChild("LemonTracer") then
					local a0 = Instance.new("Attachment", char.HumanoidRootPart)
					local a1 = Instance.new("Attachment", tChar.HumanoidRootPart)
					local beam = Instance.new("Beam")
					beam.Name = "LemonTracer"
					beam.Attachment0 = a0
					beam.Attachment1 = a1
					beam.Color = ColorSequence.new(COR_ACENTO)
					beam.Width0 = 0.15
					beam.Width1 = 0.15
					beam.FaceCamera = true
					beam.Parent = tChar
					table.insert(beams, {beam = beam, a0 = a0, a1 = a1})
				end
			end
		end
	else
		if #highlights > 0 or #beams > 0 then
			limparESP()
		end
	end
	
	-- Torso Skybox
	if char then
		local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
		if torso then
			local skyTag = torso:FindFirstChild("LemonSkybox")
			if torsoSkyAtivo then
				if not skyTag then
					skyTag = Instance.new("Folder")
					skyTag.Name = "LemonSkybox"
					skyTag.Parent = torso
					
					local faces = Enum.NormalId:GetEnumItems()
					for _, face in pairs(faces) do
						local decal = Instance.new("Decal")
						decal.Name = "SkyDecal"
						decal.Face = face
						decal.Texture = "rbxassetid://15933990" -- Id da textura de céu/espaço
						decal.Parent = torso
					end
				end
			else
				if skyTag then
					skyTag:Destroy()
					for _, child in pairs(torso:GetChildren()) do
						if child.Name == "SkyDecal" then
							child:Destroy()
						end
					end
				end
			end
		end
	end
end)

-- Noclip
RunService.Stepped:Connect(function()
	if noclipAtivo and player.Character then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

-- Pulo Infinito
UserInputService.JumpRequest:Connect(function()
	if jumpAtivo and player.Character then
		local hum = player.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)
