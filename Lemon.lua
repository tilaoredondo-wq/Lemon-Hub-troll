--[[ 
    LEMON HUB - Script para Roblox Studio
    Menu Flutuante e Móvel com Imagem de Limão
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
screenGui.Name = "LemonHubGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Botão para Reabrir (Limão)
local openButton = Instance.new("ImageButton")
openButton.Name = "LemonOpenButton"
openButton.Size = UDim2.new(0, 60, 0, 60)
openButton.Position = UDim2.new(0.02, 0, 0.45, 0)
openButton.Image = "rbxassetid://6034287525" -- ID da imagem do limão
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
mainFrame.Size = UDim2.new(0, 240, 0, 220) -- Tamanho inicial menor sem a lista visível
mainFrame.Position = UDim2.new(0.5, -120, 0.5, -110)
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
title.Text = "LEMON HUB 🍋"
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

-- 2. FUNÇÃO PARA MOVER/ARRASTAR O MENU NA TELA
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

-- 3. ABRIR E FECHAR MENU
closeButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	openButton.Visible = true
end)

openButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	openButton.Visible = false
end)

-- 4. CRIAR BOTÕES DAS FUNÇÕES PRINCIPAIS
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
local playerListToggleBtn = criarBotao("Players List: OFF")

-- Estados das Funções
local speedAtivo, jumpAtivo, noclipAtivo, listAtiva = false, false, false, false

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

-- 5. LISTA DE JOGADORES E TELEPORTE
local jogadorSelecionado = nil

-- Container da Seção de Jogadores (escondida por padrão)
local playerListFrame = Instance.new("Frame")
playerListFrame.Size = UDim2.new(0, 200, 0, 220)
playerListFrame.BackgroundTransparency = 1
playerListFrame.Visible = false
playerListFrame.Parent = container

local listContainerLayout = Instance.new("UIListLayout")
listContainerLayout.Parent = playerListFrame
listContainerLayout.Padding = UDim.new(0, 6)
listContainerLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ScrollingFrame para os jogadores
local scrollList = Instance.new("ScrollingFrame")
scrollList.Size = UDim2.new(0, 200, 0, 130)
scrollList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
scrollList.BorderSizePixel = 0
scrollList.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollList.ScrollBarThickness = 4
scrollList.Parent = playerListFrame

local cornerScroll = Instance.new("UICorner")
cornerScroll.CornerRadius = UDim.new(0, 6)
cornerScroll.Parent = scrollList

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = scrollList
listLayout.Padding = UDim.new(0, 4)
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.SortOrder = Enum.SortOrder.Name

local function atualizarLista()
	for _, child in pairs(scrollList:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	
	jogadorSelecionado = nil

	for _, targetPlayer in pairs(Players:GetPlayers()) do
		if targetPlayer ~= player then
			local btnPlr = Instance.new("TextButton")
			btnPlr.Size = UDim2.new(0, 180, 0, 28)
			btnPlr.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			btnPlr.TextColor3 = Color3.fromRGB(255, 255, 255)
			btnPlr.Font = Enum.Font.Gotham
			btnPlr.TextSize = 12
			btnPlr.Text = targetPlayer.DisplayName .. " (@" .. targetPlayer.Name .. ")"
			btnPlr.Parent = scrollList

			local cornerBtn = Instance.new("UICorner")
			cornerBtn.CornerRadius = UDim.new(0, 4)
			cornerBtn.Parent = btnPlr

			btnPlr.MouseButton1Click:Connect(function()
				for _, other in pairs(scrollList:GetChildren()) do
					if other:IsA("TextButton") then
						other.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
						other.TextColor3 = Color3.fromRGB(255, 255, 255)
					end
				end
				jogadorSelecionado = targetPlayer
				btnPlr.BackgroundColor3 = COR_ACENTO
				btnPlr.TextColor3 = Color3.fromRGB(0, 0, 0)
			end)
		end
	end

	scrollList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
end

-- Botões Refresh e Teleport
local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0, 200, 0, 32)
refreshBtn.BackgroundColor3 = COR_BOTAO
refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshBtn.TextSize = 13
refreshBtn.Font = Enum.Font.Gotham
refreshBtn.Text = "🔄 Refresh List"
refreshBtn.Parent = playerListFrame

local cornerRefresh = Instance.new("UICorner")
cornerRefresh.CornerRadius = UDim.new(0, 8)
cornerRefresh.Parent = refreshBtn

local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0, 200, 0, 32)
tpBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.TextSize = 13
tpBtn.Font = Enum.Font.Gotham
tpBtn.Text = "⚡ Teleport to Player"
tpBtn.Parent = playerListFrame

local cornerTp = Instance.new("UICorner")
cornerTp.CornerRadius = UDim.new(0, 8)
cornerTp.Parent = tpBtn

-- Evento do Botão Toggle para abrir/fechar a lista
playerListToggleBtn.MouseButton1Click:Connect(function()
	listAtiva = not listAtiva
	playerListToggleBtn.Text = listAtiva and "Players List: ON" or "Players List: OFF"
	playerListToggleBtn.TextColor3 = listAtiva and COR_ACENTO or Color3.fromRGB(255, 255, 255)
	
	playerListFrame.Visible = listAtiva
	if listAtiva then
		mainFrame.Size = UDim2.new(0, 240, 0, 440)
		atualizarLista()
	else
		mainFrame.Size = UDim2.new(0, 240, 0, 220)
	end
end)

refreshBtn.MouseButton1Click:Connect(function()
	atualizarLista()
end)

tpBtn.MouseButton1Click:Connect(function()
	if jogadorSelecionado and jogadorSelecionado.Character and jogadorSelecionado.Character:FindFirstChild("HumanoidRootPart") then
		local myChar = player.Character
		if myChar and myChar:FindFirstChild("HumanoidRootPart") then
			myChar.HumanoidRootPart.CFrame = jogadorSelecionado.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
		end
	end
end)

-- 6. LOOP CONTINUO DE SPEED E NOCLIP
RunService.Stepped:Connect(function()
	if noclipAtivo and player.Character then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

RunService.RenderStepped:Connect(function()
	local char = player.Character
	if not char then return end
	
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = speedAtivo and 100 or 16
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
