local lastCamRot = nil
local identicalMouseFrames = 0
local lastDelta = nil
local silentClickCount = 0

-- CPU and RAM Usage Monitoring
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)  -- Check every second

        local cpuUsage = GetProcessCpuUsage()  -- (Hypothetical function, replace with actual API)
        local ramUsage = GetProcessMemoryUsage()  -- (Hypothetical function, replace with actual API)

        if cpuUsage > Config.Tolerances.MaxCpuUsage or ramUsage > Config.Tolerances.MaxRamUsage then
            TriggerServerEvent("ac:flag", "High CPU/RAM Usage", cpuUsage, ramUsage)
        end
    end
end)

-- External Process Detection
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)  -- Check every 5 seconds

        local externalProcesses = GetExternalProcesses()  -- Hypothetical function

        for _, process in ipairs(externalProcesses) do
            for _, suspiciousProcess in ipairs(Config.SuspiciousProcesses) do
                if process == suspiciousProcess then
                    TriggerServerEvent("ac:flag", "External Process Detected", process)
                end
            end
        end
    end
end)

-- DLL Injection Detection
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)  -- Check every 10 seconds

        local loadedModules = GetLoadedModules()  -- Hypothetical function to get loaded modules

        for _, module in ipairs(loadedModules) do
            if not IsModuleLegit(module) then
                TriggerServerEvent("ac:flag", "Suspicious DLL Loaded", module)
            end
        end
    end
end)

-- AI Behavior Monitoring (Mouse and Camera Movement)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped, false) and not IsPauseMenuActive() then
            local camRot = GetGameplayCamRot(2)

            if lastCamRot then
                local delta = {
                    x = math.floor((camRot.x - lastCamRot.x) * 1000) / 1000,
                    y = math.floor((camRot.y - lastCamRot.y) * 1000) / 1000,
                    z = math.floor((camRot.z - lastCamRot.z) * 1000) / 1000
                }

                if lastDelta and delta.x == lastDelta.x and delta.y == lastDelta.y and delta.z == lastDelta.z then
                    identicalMouseFrames = identicalMouseFrames + 1
                else
                    identicalMouseFrames = 0
                end

                if identicalMouseFrames >= Config.Tolerances.MaxIdenticalMouseFrames then
                    TriggerServerEvent("ac:flag", "AI Mouse Movement (Cheat Detected)", delta)
                    identicalMouseFrames = 0
                end

                lastDelta = delta
            end

            lastCamRot = camRot
        end
    end
end)

-- Detecting Suspicious Silent Clicks (Triggerbot/Macro Detection)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if IsPedShooting(PlayerPedId()) then
            local camRot = GetGameplayCamRot(2)
            if lastCamRot and camRot.x == lastCamRot.x and camRot.y == lastCamRot.y then
                silentClickCount = silentClickCount + 1
                if silentClickCount >= Config.Tolerances.MaxSilentClicks then
                    TriggerServerEvent("ac:flag", "Silent Clicks (Triggerbot)", silentClickCount)
                    silentClickCount = 0
                end
            else
                silentClickCount = 0
            end
        end
    end
end)
