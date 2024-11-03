local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local runSpeed = 16 -- Базовая желаемая скорость, можно менять на желаемое значение

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Устанавливаем базовую скорость
    humanoid.WalkSpeed = runSpeed
    
    -- Отслеживаем нажатие клавиш для направления движения
    game:GetService("RunService").RenderStepped:Connect(function()
        local direction = Vector3.new()

        -- Получаем направление движения по текущему вводу
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + Vector3.new(0, 0, -1) -- Вперёд
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction + Vector3.new(0, 0, 1) -- Назад
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction + Vector3.new(-1, 0, 0) -- Влево
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + Vector3.new(1, 0, 0) -- Вправо
        end

        -- Если направление не нулевое, то обновляем CFrame персонажа с учётом ориентации
        if direction.magnitude > 0 then
            direction = direction.unit * runSpeed * 0.1
            local moveDirection = humanoidRootPart.CFrame:VectorToWorldSpace(direction)
            humanoidRootPart.CFrame = humanoidRootPart.CFrame + moveDirection
        end
    end)
end

-- Подключаемся к CharacterAdded, чтобы применять изменения при каждом появлении персонажа
player.CharacterAdded:Connect(onCharacterAdded)

-- Применяем изменения к текущему персонажу, если он уже существует
if player.Character then
    onCharacterAdded(player.Character)
end
