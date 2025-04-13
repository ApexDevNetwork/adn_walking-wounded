--[[local hurt = false
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if GetEntityHealth(GetPlayerPed(-1)) <= 159 then
            setHurt()
        elseif hurt and GetEntityHealth(GetPlayerPed(-1)) > 160 then
            setNotHurt()
        end
    end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end

function setNotHurt()
    hurt = false
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
end]]

local hurt = false
local injuredAnimSet = "move_m@injured"

CreateThread(function()
    RequestAnimSet(injuredAnimSet)
    while not HasAnimSetLoaded(injuredAnimSet) do
        Wait(10)
    end

    while true do
        local playerPed = PlayerPedId()
        local health = GetEntityHealth(playerPed)

        if not hurt and health > 100 and health <= 159 then
            setHurt(playerPed)
        elseif hurt and health > 160 then
            setNotHurt(playerPed)
        end

        Wait(500) -- Comprobación más ligera
    end
end)

function setHurt(ped)
    hurt = true
    SetPedMovementClipset(ped, injuredAnimSet, true)
end

function setNotHurt(ped)
    hurt = false
    ResetPedMovementClipset(ped, 0.0)
    ResetPedWeaponMovementClipset(ped)
    ResetPedStrafeClipset(ped)
end
