local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('itemProcessing:craftItem')
AddEventHandler('itemProcessing:craftItem', function(itemName)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src) 

    if xPlayer ~= nil and xPlayer.PlayerData.job.name == 'snack' then
        local recipe = FindCraftingRecipe(itemName)

        if recipe then
            local playerCoords = GetEntityCoords(GetPlayerPed(src))
            local processingLocation = recipe.processingLocation
            if IsPlayerNearLocation(playerCoords, processingLocation) then

                local hasRequiredItems = true
                for _, requiredItem in ipairs(recipe.requiredItems) do
                    if not xPlayer.Functions.GetItemByName(requiredItem.itemName) or xPlayer.Functions.GetItemByName(requiredItem.itemName).amount < requiredItem.amount then
                        hasRequiredItems = false
                        break
                    end
                end

                if hasRequiredItems then
                    for _, requiredItem in ipairs(recipe.requiredItems) do
                        xPlayer.Functions.RemoveItem(requiredItem.itemName, requiredItem.amount)
                    end

                    xPlayer.Functions.AddItem(itemName, 1)

                    TriggerClientEvent('itemProcessing:craftResult', src, "success")
                else
                    TriggerClientEvent('itemProcessing:craftResult', src, "insufficient")
                end
            else
                TriggerClientEvent('itemProcessing:craftResult', src, "not_near_location")
            end
        else
            print("Crafting recipe not found for item: " .. itemName)
        end
    else
        print(("Player %s attempted to craft without the 'snack' job!"):format(src))
    end
end)

function FindCraftingRecipe(itemName)
    for _, recipe in ipairs(Config.CraftingRecipes) do
        if recipe.itemName == itemName then
            return recipe
        end
    end
    return nil
end

function IsPlayerNearLocation(playerCoords, locationCoords)
    local distance = GetDistanceBetweenCoords(playerCoords, locationCoords, true)
    return distance < 2.0
end
