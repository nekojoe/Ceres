--- STEAMODDED HEADER
--- MOD_NAME: Ceres
--- MOD_ID: ceres
--- MOD_PREFIX: cere
--- MOD_AUTHOR: [nekojoe]
--- MOD_DESCRIPTION: please read the read me
--- BADGE_COLOUR: 13afce
--- PRIORITY: 999999999999999999
--- DEPENDENCIES: [Eris]
--- VERSION: 1.0a

----------------------------------------------
---------------- MOD CODE --------------------
local nativefs = require("nativefs")
local lovely = require("lovely")
local prefix = 'cere'

local mod_icon = SMODS.Atlas({
    key = "modicon",
    path = "cere_icon.png",
    px = 32,
    py = 32
})

Ceres = {}
Ceres.DEFAULT_CONFIG = {
    jokers = {
        rarities = {
            common = { enabled = true },
            uncommon = { enabled = true },
            rare = { enabled = true },
            legendary = { enabled = true },
            divine = { enabled = true },
        },
        enabled = true,
    },
    card_modifiers = {
        editions = { enabled = true },
        enhancements = { enabled = false },
        seals = { enabled = true },
        enabled = true
    },
    suits = { enabled = false },
    consumables = {
        reversed_tarots = { enabled = true },
        vouchers = { enabled = true },
        enabled = true,
    },
    perks = { enabled = true },
    run_modifiers = {
        blinds = { enabled = true },
        stakes = { enabled = true },
        decks = { enabled = true },
        enabled = true,
    },
    misc = {
        unlock_all = { enabled = true }, -- has to be until i get round to unlock checks
        discover_all = { enabled = false },
    }
}
Ceres.MOD_PATH = lovely.mod_dir .. '/Ceres/'
-- TODO actually seperate them better
-- have Eris manage all the diff card effects etc
Ceres.COMPAT = Eris.COMPAT

-- colours
Ceres.C = {
    devil = HEX('333333'),
    dark_red = HEX('B60000'),
    new_moon = HEX('2c485dcc'),
    divine = G.C.DARK_EDITION,
    eternal = G.C.ETERNAL,
    the_bill = HEX('EDCE7B'),
    the_fall = HEX('eb7a34'),
    the_french = HEX('E5E5E5'),
}
-- adding Ceres colours to Eris to save hooking to
-- the loc and badge colour funcs again
for key, colour in pairs(Ceres.C) do
    Eris.C[prefix..tostring(key)] = colour
end

-- files for loading
Eris.FUNCS.load_config(Ceres)

Ceres.ITEMS = {
    card_modifiers = {
        'editions',
        'enhancements',
        'seals',
    },
    consumables = {
        'spectrals',
        'reversed_tarots',
        'vouchers',
    },
    jokers = {
        'common',
        'uncommon',
        'rare',
        'legendary',
        'divine',
    },
    perks = {
        'perk_boosters',
        'perks',
    },
    run_modifiers = {
        'blinds',
        'decks',
        'stakes',
    },
    suits = {
        'suits',
    },
    'ui',
}

Eris.FUNCS.read_files(Ceres)

-- custom rarity based on Cryptid, which was based on Relic-Jokers

G.C.RARITY['cere_divine'] = Ceres.C['divine']

local insert_pool_ref = SMODS.insert_pool
function SMODS.insert_pool(pool, center, replace)
    if pool == nil then pool = {} end
    insert_pool_ref(pool, center, replace)
end

SMODS.current_mod.config_tab = function()
    local ref_table = Ceres.CONFIG
    local _buttons = {
        {label = 'Jokers', toggle_ref = ref_table.jokers, button_ref = 'cere_change_page', ref_page = 'jokers_rarities'},
        {label = 'Consumables', toggle_ref = ref_table.consumables, button_ref = 'cere_change_page', ref_page = 'consumables'},
        {label = 'Card Modifiers', toggle_ref = ref_table.card_modifiers, button_ref = 'cere_change_page', ref_page = 'card_modifiers'},
        {label = 'Run Modifiers', toggle_ref = ref_table.run_modifiers, button_ref = 'cere_change_page', ref_page = 'run_modifiers'},
		{label = 'Suits', toggle_ref = ref_table.suits, remove_enable = true,},
        {label = 'Miscellaneous', button_ref = 'cere_change_page', ref_page = 'misc', remove_enable = true,},
    }
    return {
        n = G.UIT.ROOT,
        config = {
            emboss = 0.05,
            r = 0.1,
            minh = 8,
            minw = 7.3,
            align = 'cm',
            padding = 0.2,
            colour = G.C.BLACK,
        },
        nodes = Eris.FUNCS.create_buttons(_buttons, false, 'cere_save_config'),
    }
end

function SMODS.current_mod.reset_game_globals()
    G.GAME.cere_clock_card = pick_from_deck('clock')
    G.GAME.cere_yumeko_suit = pick_from_deck('yumeko').suit
    G.GAME.cere_insurance_card = pick_from_deck('fraud')
end

----------------------------------------------
---------------- MOD CODE END ----------------