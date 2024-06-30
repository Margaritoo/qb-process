Config = {}

Config.CraftingRecipes = {
    {
        itemName = "Item A",
        requiredItems = {
            { itemName = "Item B", amount = 1 },
            { itemName = "Item C", amount = 2 },
        },
        processingLocation = vector3(123.45, 678.9, 100.0),
    },
    {
        itemName = "Item X",
        requiredItems = {
            { itemName = "Item Y", amount = 3 },
            { itemName = "Item Z", amount = 1 },
        },
        processingLocation = vector3(234.56, 789.1, 200.0),
    },
}
