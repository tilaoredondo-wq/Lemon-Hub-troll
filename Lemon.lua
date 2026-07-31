--[[ 
    LEMON TROLL 🍋 - Script para Roblox Studio (Layout Horizontal)
    Menu Flutuante com ESP Tracers, Lista Avançada de Ferramentas com Refresh, Torso Skybox e Teleporte
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

-- Menu Principal Horizontal (Frame Deitado)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 520, 0, 210) -- Dimensionado na horizontal
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -105)
mainFrame.BackgroundColor3 = COR_FUNDO
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui

local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 10)
cornerMain.Parent = mainFrame

-- Barra de Título Topo
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "Lemon troll 🍋"
title.TextColor3 = COR_ACENTO
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
title.Parent = mainFrame

local cornerTitle = Instance.new("UICorner")
cornerTitle.CornerRadius = UDim.new(0, 10)
cornerTitle.Parent = title

-- Botão Fechar (X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 5)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeButton.Parent = mainFrame

local cornerClose = Instance.new("UICorner")
cornerClose.CornerRadius = UDim.new(0, 6)
cornerClose.Parent = closeButton

-- Layout de Colunas Horizontais
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -45)
contentFrame.Position = UDim2.new(0, 10, 0, 40)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local horizontalLayout = Instance.new("UIListLayout")
horizontalLayout.Parent = contentFrame
horizontalLayout.FillDirection = Enum.FillDirection.Horizontal
horizontalLayout.Padding = UDim.new(0, 10)
horizontalLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Coluna 1: Controles de Jogador
local col1 = Instance.new("Frame")
col1.Size = UDim2.new(0, 155, 1, 0)
col1.BackgroundTransparency = 1
col1.Parent = contentFrame

local layoutCol1 = Instance.new("UIListLayout")
layoutCol1.Parent = col1
layoutCol1.Padding = UDim.new(0, 5)

-- Coluna 2: Teleporte e Visual
local col2 = Instance.new("Frame")
col2.Size = UDim2.new(0, 155, 1, 0)
col2.BackgroundTransparency = 1
col2.Parent = contentFrame

local layoutCol2 = Instance.new("UIListLayout")
layoutCol2.Parent = col2
layoutCol2.Padding = UDim.new(0, 5)

-- Coluna 3: Gerenciador de Ferramentas
local col3 = Instance.new("Frame")
col3.Size = UDim2.new(0, 160, 1, 0)
col3.BackgroundTransparency = 1
col3.Parent = contentFrame

local layoutCol3 = Instance.new("UIListLayout")
layoutCol3.Parent = col3
layoutCol3.Padding = UDim.new(0, 5)

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

closeButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	openButton.Visible = true
end)

openButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	openButton.Visible = false
end)

-- 3. CRIAR BOTÕES
local function criarBotao(texto, parentFrame, altura)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, altura or 32)
	btn.BackgroundColor3 = COR_BOTAO
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 12
	btn.Font = Enum.Font.Gotham
	btn.Text = texto
	btn.Parent = parentFrame
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn
	return btn
end

-- Botões Coluna 1
local speedBtn = criarBotao("Speed: OFF", col1)
local jumpBtn = criarBotao("Jump: OFF", col1)
local noclipBtn = criarBotao("Noclip: OFF", col1)

-- Elementos Coluna 2
local nameInput = Instance.new("TextBox")
nameInput.Size = UDim2.new(1, 0, 0, 32)
nameInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
nameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
nameInput.PlaceholderText = "Nome Jogador..."
nameInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
nameInput.Font = Enum.Font.Gotham
nameInput.TextSize = 12
nameInput.Text = ""
nameInput.Parent = col2

local cornerInput = Instance.new("UICorner")
cornerInput.CornerRadius = UDim.new(0, 6)
cornerInput.Parent = nameInput

local tpBtn = criarBotao("⚡ Teleport", col2, 32)
tpBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)

local espBtn = criarBotao("ESP Tracers: OFF", col2)
local torsoSkyBtn = criarBotao("Torso Skybox: OFF", col2)

-- Elementos Coluna 3 (Lista de Ferramentas)
local selectedTool = nil

local toolHeader = Instance.new("Frame")
toolHeader.Size = UDim2.new(1, 0, 0, 25)
toolHeader.BackgroundTransparency = 1
toolHeader.Parent = col3

local toolTitle = Instance.new("TextLabel")
toolTitle.Size = UDim2.new(0.7, 0, 1, 0)
toolTitle.Text = " Ferramentas"
toolTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
toolTitle.Font = Enum.Font.GothamBold
toolTitle.TextSize = 11
toolTitle.TextXAlignment = Enum.TextXAlignment.Left
toolTitle.BackgroundTransparency = 1
toolTitle.Parent = toolHeader

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0.3, 0, 1, 0)
refreshBtn.Text = "🔄"
refreshBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.TextSize = 12
refreshBtn.Parent = toolHeader

local cornerRefresh = Instance.new("UICorner")
cornerRefresh.CornerRadius = UDim.new(0, 4)
cornerRefresh.Parent = refreshBtn

local toolScrollList = Instance.new("ScrollingFrame")
toolScrollList.Size = UDim2.new(1, 0, 0, 95)
toolScrollList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toolScrollList.BorderSizePixel = 0
toolScrollList.CanvasSize = UDim2.new(0, 0, 0, 0)
toolScrollList.ScrollBarThickness = 4
toolScrollList.Parent = col3

local cornerToolScroll = Instance.new("UICorner")
cornerToolScroll.CornerRadius = UDim.new(0, 6)
cornerToolScroll.Parent = toolScrollList

local toolListLayout = Instance.new("UIListLayout")
toolListLayout.Parent = toolScrollList
toolListLayout.Padding = UDim.new(0, 3)
toolListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
toolListLayout.SortOrder = Enum.SortOrder.Name

local getToolBtn = criarBotao("🎒 Pegar Item", col3, 30)
getToolBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 75)

-- 4. LÓGICA DE BUSCA DE FERRAMENTAS & REFRESH
local function buscarTodasFerramentas()
	for _, child in pairs(toolScrollList:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	
	selectedTool = nil
	local ferramentasEncontradas = {}

	-- Varredura no Workspace, ReplicatedStorage, Lighting e mochilas de jogadores
	local locais = {
		game:GetService("Workspace"),
		game:GetService("ReplicatedStorage"),
		game:GetService("Lighting"),
		game:GetService("StarterPack")
	}

	for _, localBusca in pairs(locais) do
		pcall(function()
			for _, obj in pairs(localBusca:GetDescendants()) do
				if obj:IsA("Tool") and not ferramentasEncontradas[obj.Name] then
					ferramentasEncontradas[obj.Name] = obj
				end
			end
		end)
	end

	-- Gera os botões para cada ferramenta localizada
	for name, obj in pairs(ferramentasEncontradas) do
		local btnTool = Instance.new("TextButton")
		btnTool.Size = UDim2.new(0.92, 0, 0, 24)
		btnTool.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		btnTool.TextColor3 = Color3.fromRGB(255, 255, 255)
		btnTool.Font = Enum.Font.Gotham
		btnTool.TextSize = 11
		btnTool.Text = name
		btnTool.Parent = toolScrollList

		local cornerBtn = Instance.new("UICorner")
		cornerBtn.CornerRadius = UDim.new(0, 4)
		cornerBtn.Parent = btnTool

		btnTool.MouseButton1Click:Connect(function()
			for _, other in pairs(toolScrollList:GetChildren()) do
				if other:IsA("TextButton") then
					other.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
					other.TextColor3 = Color3.fromRGB(255, 255, 255)
				end
			end
			selectedTool = obj
			btnTool.BackgroundColor3 = COR_ACENTO
			btnTool.TextColor3 = Color3.fromRGB(0, 0, 0)
		end)
	end

	toolScrollList.CanvasSize = UDim2.new(0, 0, 0, toolListLayout.AbsoluteContentSize.Y + 10)
end

refreshBtn.MouseButton1Click:Connect(buscarTodasFerramentas)
task.spawn(buscarTodasFerramentas)

getToolBtn.MouseButton1Click:Connect(function()
	if selectedTool and player:FindFirstChildOfClass("Backpack") then
		local clonedTool = selectedTool:Clone()
		clonedTool.Parent = player:FindFirstChildOfClass("Backpack")
	end
end)

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

-- 5. TELEPORTE POR TEXTO
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

-- 6. LÓGICA DE ESP, TRACERS E TORSO SKYBOX
local highlights = {}
local nameGuis = {}
local beams = {}

local function limparESP()
	for _, hl in pairs(highlights) do if hl then hl:Destroy() end end
	for _, gui in pairs(nameGuis) do if gui then gui:Destroy() end end
	for _, data in pairs(beams) do 
		if data.a0 then data.a0:Destroy() end
		if data.a1 then data.a1:Destroy() end
		if data.beam then data.beam:Destroy() end 
	end
	highlights = {}
	nameGuis = {}
	beams = {}
end

RunService.RenderStepped:Connect(function()
	local char = player.Character
	
	-- Speed
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = speedAtivo and 100 or 16 end
	end
	
	-- ESP, Tracers & Nomes
	if espAtivo then
		for _, target in pairs(Players:GetPlayers()) do
			if target ~= player and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
				local tChar = target.Character
				local head = tChar:FindFirstChild("Head")
				
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
				
				-- Nome DisplayName
				if head and not head:FindFirstChild("LemonNameGui") then
					local bbGui = Instance.new("BillboardGui")
					bbGui.Name = "LemonNameGui"
					bbGui.Adornee = head
					bbGui.Size = UDim2.new(0, 200, 0, 50)
					bbGui.StudsOffset = Vector3.new(0, 2.5, 0)
					bbGui.AlwaysOnTop = true
					
					local nameLbl = Instance.new("TextLabel")
					nameLbl.Size = UDim2.new(1, 0, 1, 0)
					nameLbl.BackgroundTransparency = 1
					nameLbl.Text = target.DisplayName
					nameLbl.TextColor3 = COR_ACENTO
					nameLbl.TextStrokeTransparency = 0
					nameLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
					nameLbl.Font = Enum.Font.GothamBold
					nameLbl.TextSize = 14
					nameLbl.Parent = bbGui
					
					bbGui.Parent = head
					table.insert(nameGuis, bbGui)
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
		if #highlights > 0 or #beams > 0 or #nameGuis > 0 then
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
						decal.Texture = "rbxassetid://15933990"
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
