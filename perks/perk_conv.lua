local perk_conv_atlas = SMODS.Atlas{
    key = 'perk_conv',
    path = 'perk_conv.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

local perk_conv = Ceres.SETTINGS.card_effects.perks.enabled and Ceres.DEV and SMODS.ConsumableType{
    key = 'perk_conv',
    primary_colour = G.C.SET.Tarot,
    secondary_colour = G.C.SECONDARY_SET.Tarot,
    loc_txt = {
        name = 'Perk Conv',
        collection = 'Perk Conv',
        undiscovered = {
            name = 'Not Discovered',
            text = {
                'Purchase or use',
                'this card in an',
                'unseeded run to',
                'learn what it does',
            },
        },
    },
    collection_rows = { 5, 6 },
}

local undiscoverd_atlas = SMODS.UndiscoveredSprite{
    atlas = 'perk_conv',
    key = 'perk_conv',
    pos = {
        x = 0,
        y = 0,
    },
}

local perk_conv1 = Ceres.SETTINGS.card_effects.perks.enabled and Ceres.DEV and SMODS.Consumable{
    key = 'perk_conv1',
    set = 'perk_conv',
    config = {
        max_highlighted = 1,
    },
    atlas = 'perk_conv',
    pos = {
        x = 0,
        y = 0,
    },
    discovered = true,

    use = function()
        for _, card in pairs(G.hand.highlighted) do
            card:set_ability(G.P_CENTERS['pk_cere_prototype'])
        end
    end,
}

local perk_conv2 = Ceres.SETTINGS.card_effects.perks.enabled and Ceres.DEV and SMODS.Consumable{
    key = 'perk_conv2',
    set = 'perk_conv',
    config = {
        max_highlighted = 1,
    },
    atlas = 'perk_conv',
    pos = {
        x = 1,
        y = 0,
    },
    discovered = true,

    use = function()
        for _, card in pairs(G.hand.highlighted) do
            card:set_ability(G.P_CENTERS['pk_cere_dirty_napkin'])
        end
    end,
}

local perk_conv3 = Ceres.SETTINGS.card_effects.perks.enabled and Ceres.DEV and SMODS.Consumable{
    key = 'perk_conv3',
    set = 'perk_conv',
    config = {
        max_highlighted = 1,
    },
    atlas = 'perk_conv',
    pos = {
        x = 2,
        y = 0,
    },
    discovered = true,

    use = function()
        for _, card in pairs(G.hand.highlighted) do
            card:set_ability(G.P_CENTERS['pk_cere_reward_card'])
        end
    end,
}

local perk_conv4 = Ceres.SETTINGS.card_effects.perks.enabled and Ceres.DEV and SMODS.Consumable{
    key = 'perk_conv4',
    set = 'perk_conv',
    config = {
        max_highlighted = 1,
    },
    atlas = 'perk_conv',
    pos = {
        x = 3,
        y = 0,
    },
    discovered = true,

    use = function()
        for _, card in pairs(G.hand.highlighted) do
            card:set_ability(G.P_CENTERS['pk_cere_business_card'])
        end
    end,
}

local perk_conv5 = Ceres.SETTINGS.card_effects.perks.enabled and Ceres.DEV and SMODS.Consumable{
    key = 'perk_conv5',
    set = 'perk_conv',
    config = {
        max_highlighted = 1,
    },
    atlas = 'perk_conv',
    pos = {
        x = 4,
        y = 0,
    },
    discovered = true,

    use = function()
        for _, card in pairs(G.hand.highlighted) do
            card:set_ability(G.P_CENTERS['pk_cere_trading_card'])
        end
    end,
}

local perk_conv6 = Ceres.SETTINGS.card_effects.perks.enabled and Ceres.DEV and SMODS.Consumable{
    key = 'perk_conv6',
    set = 'perk_conv',
    config = {
        max_highlighted = 1,
    },
    atlas = 'perk_conv',
    pos = {
        x = 0,
        y = 1,
    },
    discovered = true,

    use = function()
        for _, card in pairs(G.hand.highlighted) do
            card:set_ability(G.P_CENTERS['pk_cere_plus_two'])
        end
    end,
}