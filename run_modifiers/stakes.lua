-- atlas for stakes

local stake_atlas = SMODS.Atlas{
    key = 'stake_atlas',
    path = 'stakes.png',
    px = 29,
    py = 29,
    atlas_table = 'ASSET_ATLAS',
}

-- atlas for stickers

local sticker_atlas = SMODS.Atlas{
    key = 'sticker_atlas',
    path = 'stickers.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

-- stakes

local steel = Ceres.CONFIG.run_modifiers.stakes.enabled and SMODS.Stake{
	key = "steel",
	pos = {
        x = 0,
        y = 0
    },
    sticker_pos = {
        x = 0,
        y = 0
    },
    atlas = "stake_atlas",
    sticker_atlas = 'sticker_atlas',
    applied_stakes = {"gold"},
    unlocked_stake = "cere_carbide",
	loc_txt = {
        description = {
            name = "Steel Stake",
            text = {
                "{C:red}-1{} consumable slot",
            }
        },
        sticker = {
            name = 'Steel Sticker',
            text = {
                "Used this Joker",
                "to win on {C:attention}Steel",
                "{C:attention}Stake{} difficulty"
            }
        },
    },
    colour = HEX("8E989E"),
    shiny = true,

    modifiers = function()
        G.GAME.starting_params.consumable_slots = G.GAME.starting_params.consumable_slots - 1
    end,
}

local carbide = Ceres.CONFIG.run_modifiers.stakes.enabled and SMODS.Stake{
	key = "carbide",
	pos = {
        x = 1,
        y = 0
    },
    sticker_pos = {
        x = 1,
        y = 0
    },
    atlas = "stake_atlas",
    sticker_atlas = 'sticker_atlas',
    applied_stakes = {"cere_steel"},
    unlocked_stake = "cere_tungsten",
	loc_txt = {
        description = {
            name = "Carbide Stake",
            text = {
                "Shop can have {C:attention}Defective{} Jokers",
                "{C:inactive,s:0.8}({C:green,s:0.8}1 in 3{C:inactive,s:0.8} chance to do nothing)",
            }
        },
        sticker = {
            name = 'Carbide Sticker',
            text = {
                "Used this Joker",
                "to win on {C:attention}Carbide",
                "{C:attention}Stake{} difficulty"
            }
        },
    },
    colour = HEX("262F35"),
    shiny = true,

    modifiers = function()
        G.GAME.modifiers.eris_enable_defective_in_shop = true
    end,
}

local tungsten = Ceres.CONFIG.run_modifiers.stakes.enabled and SMODS.Stake{
	key = "tungsten",
	pos = {
        x = 2,
        y = 0
    },
    sticker_pos = {
        x = 2,
        y = 0
    },
    atlas = "stake_atlas",
    sticker_atlas = 'sticker_atlas',
    applied_stakes = {"cere_carbide"},
    unlocked_stake = "cere_titanium",
	loc_txt = {
        description = {
            name = "Tungsten Stake",
            text = {
                "{C:red}-1{} hand size",
            }
        },
        sticker = {
            name = 'Tungsten Sticker',
            text = {
                "Used this Joker",
                "to win on {C:attention}Tungsten",
                "{C:attention}Stake{} difficulty"
            }
        },
    },
    colour = HEX("7A714B"),
    shiny = true,

    modifiers = function()
        G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size - 1
    end,
}

local titanium = Ceres.CONFIG.run_modifiers.stakes.enabled and SMODS.Stake{
	key = "titanium",
	pos = {
        x = 3,
        y = 0
    },
    sticker_pos = {
        x = 3,
        y = 0
    },
    atlas = "stake_atlas",
    sticker_atlas = 'sticker_atlas',
    applied_stakes = {"cere_tungsten"},
	loc_txt = {
        description = {
            name = "Titanium Stake",
            text = {
                "{C:red}-1{} Joker slot",
            }
        },
        sticker = {
            name = 'Titanium Sticker',
            text = {
                "Used this Joker",
                "to win on {C:attention}Titanium",
                "{C:attention}Stake{} difficulty"
            }
        },
    },
    colour = HEX("c0c0c0"),
    shiny = true,

    modifiers = function()
        G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots - 1
    end,
}



