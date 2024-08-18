--- STEAMODDED HEADER
--- MOD_NAME: Ceres
--- MOD_ID: ceres
--- MOD_PREFIX: cere
--- MOD_AUTHOR: [nekojoe]
--- MOD_DESCRIPTION: please read the read me
--- BADGE_COLOUR: 4584fa
--- PRIORITY: 10

----------------------------------------------
---------------- MOD CODE --------------------
local nativefs = require("nativefs")
local lovely = require("lovely")

Ceres = {}

Ceres.DEFAULT_SETTINGS = {
    jokers = {
        rarities = {
            common = { enabled = true },
            uncommon = { enabled = true },
            rare = { enabled = true },
            epic = { enabled = true },
            legendary = { enabled = true },
            divine = { enabled = true },
        },
        themed = {
            csm = { enabled = true },
            bleach = { enabled = true },
            enabled = true,
        },
        enabled = true,
    },
    card_effects = {
        editions = {
            colourblind = { enabled = true },
            sneaky = { enabled = true },
            enabled = true,
        },
        enhancements = {
            illusion = { enabled = true },
            cobalt = { enabled = true },
            enabled = true,
        },
        perks = {
            enabled = true,
        },
        enabled = true
    },
    suits = {
        crowns = { enabled = false },
        leaves = { enabled = false },
        coins = { enabled = false },
        enabled = false,
    },
    consumables = {
        reversed_tarots = { enabled = true },
        vouchers = { enabled = true },
        enabled = true,
    },
    blinds = {
        base_blinds = { enabled = true },
        devil_blinds = { enabled = true },
        enabled = true,
    },
    misc = {
        unlock_all = { enabled = true }, -- has to be until i get round to unlock checks
        discover_all = { enabled = false },
        redeem_all = { enabled = false },
    }
}
Ceres.MOD_PATH = lovely.mod_dir .. '/Ceres/'

local mod_icon = SMODS.Atlas({
    key = "modicon",
    path = "cere_icon.png",
    px = 32,
    py = 32
})

-- functions

Ceres.FUNCS = {}

-- functions for loading and saving settings
Ceres.FUNCS.load_settings = function()
    if nativefs.getInfo(Ceres.MOD_PATH .. '/user/settings.lua') then
        local settings = STR_UNPACK(nativefs.read(Ceres.MOD_PATH .. '/user/settings.lua'))
        if not settings then
            Ceres.SETTINGS = Ceres.FUNCS.copy(Ceres.DEFAULT_SETTINGS)
            Ceres.FUNCS.save_settings()
        else
            Ceres.SETTINGS = Ceres.FUNCS.copy(settings)
        end
    else
        Ceres.SETTINGS = Ceres.FUNCS.copy(Ceres.DEFAULT_SETTINGS)
        Ceres.FUNCS.save_settings()
    end
end

Ceres.FUNCS.save_settings = function()
    nativefs.write(Ceres.MOD_PATH .. '/user/settings.lua', STR_PACK(Ceres.SETTINGS))
end

-- function for rounding because ofc lua doesnt have one
Ceres.FUNCS.round = function(num, numDecimalPlaces)
    if type(num) == 'table' then
        return 0
    end
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num or 0))
end

-- function for copying tables, stolen from somewhere online i cant remember where sorry
Ceres.FUNCS.copy = function(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[Ceres.FUNCS.copy(k, s)] = Ceres.FUNCS.copy(v, s) end
    return res
end

Ceres.DEV = false

-- for testing
_RELEASE_MODE = not Ceres.DEV
function love.conf(t)
	t.console = true
end

-- colours
Ceres.C = {
    epic = HEX('8E6DFF'),
    devil = HEX('333333'),
    dark_red = HEX('B60000'),
    new_moon = HEX('2c485dcc'),
    divine = G.C.DARK_EDITION,
    the_bill = HEX('EDCE7B'),
    the_fall = HEX('eb7a34'),
    the_french = HEX('E5E5E5'),
}

-- for compat
Ceres.COMPAT = {
    talisman = (SMODS.Mods['Talisman'] or {}).can_load,
    cryptid = (SMODS.Mods['Cryptid'] or {}).can_load,
}

-- files for loading
Ceres.FUNCS.load_settings()

Ceres.ITEMS = {
    UI = {
        'UI/UI_definitions.lua',
        'UI/UI_functions.lua',
    },
    jokers = {
        'jokers/common.lua',
        'jokers/uncommon.lua',
        'jokers/rare.lua',
        'jokers/legendary.lua',
        'jokers/divine.lua',
    },
    consumables = {
        --'consumables/planets.lua', -- not needed as of now really
        'consumables/spectrals.lua',
        'consumables/reversed_tarots.lua',
    },
    blinds = {
        'blinds/base_blinds.lua',
        'blinds/devil_blinds.lua',
    },
    editions = {
        'editions/colourblind.lua',
        'editions/sneaky.lua',
    },
    enhancements = {
        'enhancements/enhancements.lua',
    },
    suits = {
        'suits/suits.lua',
    },
    hands = {
        --'hands/hands.lua',
    },
    perks = {
        'perks/perk_conv.lua',
        'perks/perk_boosters.lua',
        'perks/perks.lua',
    },
    vouchers = {
        'vouchers/perk_vouchers.lua',
    },
    api = {
        'api/RetriggerAPI.lua',
    },
}

for k, v in pairs(Ceres.ITEMS) do
    for _, path in pairs(v) do
        assert(load(nativefs.read(Ceres.MOD_PATH .. path)))()
    end
end

-- custom rarity based on Cryptid, which was based on Relic-Jokers

G.C.RARITY['cere_divine'] = Ceres.C['divine']

local insert_pool_ref = SMODS.insert_pool
function SMODS.insert_pool(pool, center, replace)
    if pool == nil then pool = {} end
    insert_pool_ref(pool, center, replace)
end

local loc_colour_ref = loc_colour
function loc_colour(_c, _default)
    return Ceres.C[_c] or loc_colour_ref(_c, _default)
end

-- custom badge colours

local get_badge_colour_ref = get_badge_colour
function get_badge_colour(key)
    local ref_return = get_badge_colour_ref(key)
    if key == 'cere_epic' then return Ceres.C.epic end
    if key == 'cere_divine' then return Ceres.C.divine end
    if key == 'cere_moon' then return G.C.SECONDARY_SET.Planet end
    if key == 'cere_perk_card' then return G.C.GREEN end
    return ref_return
end

-- page for mod options

SMODS.current_mod.config_tab = function()
	local ref_table = Ceres.SETTINGS
  	local _buttons = {
    	{label = 'Jokers', toggle_ref = ref_table.jokers, button_ref = 'cere_change_page', ref_page = 'jokers_rarities'},
    	{label = 'Consumables', toggle_ref = ref_table.consumables, button_ref = 'cere_change_page', ref_page = 'consumables'},
    	{label = 'Card Effects', toggle_ref = ref_table.card_effects, button_ref = 'cere_change_page', ref_page = 'card_effects'},
    	{label = 'Blinds', toggle_ref = ref_table.blinds, button_ref = 'cere_change_page', ref_page = 'blinds'},
      	{label = 'Suits', toggle_ref = ref_table.suits, button_ref = 'cere_change_page', ref_page = 'suits'},
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
        nodes = Ceres.FUNCS.create_buttons(_buttons, false),
    }
end

-- custom info queues

function SMODS.current_mod.process_loc_text()
    G.localization.descriptions.Other['makima_info'] = {
        name = 'Makima',
        text = {
            'A {C:dark_red}corpse{}',
            'is talking',
        },
    }
    G.localization.descriptions.Other['aizen_info'] = {
        name = 'Aizen',
        text = {
            'Welcome, to my',
            '{C:spectral}Soul Society{}',
        },
    }
    G.localization.descriptions.Other['colourblind_info'] = {
        name = "Colourblind",
        text = {
            "Swaps {C:blue}Chips{} and {C:red}Mult{}",
            '{C:inactive}(if possible)',
        }
    }
    G.localization.descriptions.Other['sneaky_info'] = {
        name = "Sneaky",
        text = {
            "This card cannot",
            "be {C:attention}debuffed{}",
        },
    }
    G.localization.descriptions.Other['perk_info'] = {
        name = "Perk Card",
        text = {
            "This card has a",
            'special effect',
            "{C:attention}activated on play{}",
        },
    }
    G.localization.descriptions.Other['temp_info'] = {
        name = "Temporary",
        text = {
            "Card is {C:attention}destroyed{}",
            "at end of round",
        },
    }
    G.localization.descriptions.Other['burn_info'] = {
        name = "Burn",
        text = {
            "Card is {C:attention}removed{}",
            'from your deck for the',
            'remainder of this {C:attention}ante{}',
        },
    }
    G.localization.descriptions.Other['shred_info'] = {
        name = "Shred",
        text = {
            "Card is {C:attention}removed{}",
            'from your deck',
        },
    }
end

-- picks new cards for jokers, same way idol and rebate do

function SMODS.current_mod.reset_game_globals()
    G.GAME.cere_jackpot_card = pick_from_deck('jackpot')
    G.GAME.cere_clock_card = pick_from_deck('clock')   
end

function pick_from_deck(seed)
    local valid_cards = {}
    for k, v in ipairs(G.playing_cards) do
        if v.ability.effect ~= 'Stone Card' then
            valid_cards[#valid_cards+1] = v
        end
    end
    if valid_cards[1] then 
        local random_card = pseudorandom_element(valid_cards, pseudoseed(seed..G.GAME.round_resets.ante))
        return {
            rank = random_card.base.value,
            suit = random_card.base.suit,
            id = random_card.base.id,
        }
    else
        return {
            rank = 'Ace',
            suit = 'Spades',
            id = 14,
        }
    end
end

----------------------------------------------
---------------- MOD CODE END ----------------