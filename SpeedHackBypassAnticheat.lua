local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local bodyVelocity = nil
local userInputService = game:GetService("UserInputService")

-- Функция для включения спидхака
local function speedHack(speed)
    -- Создаём BodyVelocity, если его ещё нет
    if not bodyVelocity then
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)  -- Огромная сила для движения
        bodyVelocity.Velocity = humanoidRootPart.CFrame.LookVector * speed  -- Направление и скорость
        bodyVelocity.Parent = humanoidRootPart  -- Присоединяем к HumanoidRootPart
    else
        -- Если BodyVelocity уже есть, обновляем его скорость
        bodyVelocity.Velocity = humanoidRootPart.CFrame.LookVector * speed
    end
end

-- Функция для выключения спидхака
local function disableSpeedHack()
    if bodyVelocity then
        bodyVelocity:Destroy()  -- Удаляем BodyVelocity, чтобы остановить ускорение
        bodyVelocity = nil
    end
end

-- Отслеживание нажатия клавиши X
userInputService.InputBegan:Connect(function(input, gameProcessed)
    -- Игнорировать, если действие уже обрабатывается игрой (например, при открытии инвентаря)
    if gameProcessed then return end

    -- Проверяем, если нажата клавиша X
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.X then
        speedHack(100)  -- Включаем спидхак с заданной скоростью
    end
end)

-- Отслеживание отпускания клавиши X
userInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.X then
        disableSpeedHack()  -- Отключаем спидхак
    end
end)
