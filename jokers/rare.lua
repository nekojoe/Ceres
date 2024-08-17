-- atlas for uncommon jokers

local rare_joker_atlas = SMODS.Atlas{
    key = 'rare_jokers',
    path = 'rare_jokers.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

-- custom rare jokers

local fox_devil = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.themed.enabled and Ceres.SETTINGS.jokers.themed.csm.enabled and SMODS.Joker{
    key = 'fox_devil',
    name = 'Fox Devil',
    rarity = 3,
    unlocked = false or Ceres.SETTINGS.misc.unlock_all.enabled,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    pos = {
        x = 1,
        y = 0,
    },
    cost = 8,
    config = {
        increase = 50,
        decrease = 25,
    },
    atlas = 'rare_jokers',
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.increase, card.ability.decrease}}
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced and not context.blueprint and not context.control_devil then
            if context.blind.boss then
                G.GAME.blind.chips = G.GAME.blind.chips  * ((100 - self.config.decrease) / 100)
            else
                G.GAME.blind.chips = G.GAME.blind.chips + (G.GAME.blind.chips * (self.config.increase / 100))
            end
        end
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.HUD_blind:get_UIE_by_ID('HUD_blind_count').UIBox:recalculate()
    end,
}

local blood_fiend = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.themed.enabled and Ceres.SETTINGS.jokers.themed.csm.enabled and SMODS.Joker{
    key = 'blood_fiend',
    name = 'Blood Fiend',
    rarity = 3,
    unlocked = false or Ceres.SETTINGS.misc.unlock_all.enabled,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    pos = {
        x = 2,
        y = 0,
    },
    cost = 7,
    config = {
        extra = 0.25,
        x_mult = 1,
    },
    atlas = 'rare_jokers',
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra, card.ability.x_mult}}
    end,

    calculate = function(self, card, context)
        if not (context.blueprint or context.control_devil) then
            if context.cards_destroyed then
                local hearts = 0
                for k, v in ipairs(context.glass_shattered) do
                    if v:is_suit('Hearts') then
                        hearts = hearts + 1
                    end
                end
                if hearts > 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    card.ability.x_mult = card.ability.x_mult + hearts*card.ability.extra
                                return true
                                end
                            }))
                            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.x_mult + hearts*card.ability.extra}}})
                            return true
                        end
                    }))
                end
                return
            elseif context.remove_playing_cards then
                local hearts = 0
                for k, v in ipairs(context.removed) do
                    if v:is_suit('Hearts') then 
                        hearts = hearts + 1
                    end
                end
                if hearts > 0 then
                    card.ability.x_mult = card.ability.x_mult + hearts*card.ability.extra
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.x_mult}}})
                            return true
                        end
                    }))
                end
                return
            end
        else
            if context.joker_main then
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.x_mult}},
                    Xmult_mod = card.ability.x_mult
                }
            end
        end
    end,
}

local snake_eyes = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.rarities.rare.enabled and SMODS.Joker{
    key = 'snake_eyes',
    name = 'Snake Eyes',
    rarity = 3,
    unlocked = false or Ceres.SETTINGS.misc.unlock_all.enabled, -- smth luck related
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    pos = {
        x = 3,
        y = 0,
    },
    cost = 8,
    config = {
        extra = 1,
    },
    atlas = 'rare_jokers',
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    -- unfortunately thunk isnt consistent with chance jokers using odds in their abilities
    compat = {
        '8 Ball',
        'Misprint',
        'Business Card',
        'Space Joker',
        'Hallucination',
        'Gros Michel',
        'Cavendish',
        'Reserved Parking',
        'Bloodstone',
    },

    calculate = function(self, card, context)
        -- retriggering any lucky/glass cards
        if context.repetition and context.cardarea == G.play then
            if context.other_card.ability.name == 'Lucky Card' or context.other_card.ability.name == 'Glass Card' then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra,
                    card = card
                }
            end
        -- retriggering any chance jokers, if only thunk was consistent with the whole odds thing
        elseif context.retrigger_joker_check and not context.retrigger_joker then
            for _, joker in pairs(self.compat) do
                if context.other_card.ability.name == joker then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = card.ability.extra,
                        card = card
                    }
                end
            end
        end
    end,
}

local clock = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.rarities.rare.enabled and SMODS.Joker{
    key = 'calling_the_clock',
    config = {
        extra = 1,
    },
    rarity = 3,
    pos = {
        x = 4,
        y = 0,
    },
    atlas = 'rare_jokers',
    cost = 7,
    unlocked = false or Ceres.SETTINGS.misc.unlock_all.enabled, -- trigger certain amt of cards in one hand, including cards in hand or smth
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        if G.GAME.cere_clock_card then
            return {
                vars = {
                    G.GAME.cere_clock_card.rank,
                },
            }
        else
            return {
                vars = {
                    'Ace',
                }
            }
        end
    end,

    calculate = function(self, card, context)
        if G.GAME.cere_clock_card then
            if context.repetition and context.cardarea == G.play or (context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1)) then
                if context.other_card:get_id() == G.GAME.cere_clock_card.id then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = card.ability.extra,
                        card = card
                    }
                end
            end
        end
    end,
}