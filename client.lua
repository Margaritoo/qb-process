local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, recipe in ipairs(Config.CraftingRecipes) do
            if IsPlayerNearLocation(playerCoords, recipe.processingLocation) then
                DrawText3D(recipe.processingLocation.x, recipe.processingLocation.y, recipe.processingLocation.z, "[Press ~b~E~w~] Craft " .. recipe.itemName)
                
                if IsControlJustPressed(0, 38) then 
                    TriggerServerEvent('itemProcessing:craftItem', recipe.itemName)
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)

    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('itemProcessing:craftResult')
AddEventHandler('itemProcessing:craftResult', function(result)
    if result == "success" then
        TriggerEvent('chat:addMessage', {
            color = { 255, 255, 255 },
            multiline = true,
            args = { "[Crafting]", "Done Crafting" }
        })
    elseif result == "insufficient" then
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0 },
            multiline = true,
            args = { "[Crafting]", "You don't have the ingredients" }
        })
    elseif result == "not_near_location" then
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0 },
            multiline = true,
            args = { "[Crafting]", "You are not near the crafting location" }
        })
    end
end)
