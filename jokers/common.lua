-- atlas for common jokers

local common_joker_atlas = SMODS.Atlas{
    key = 'common_jokers',
    path = 'common_jokers.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

-- custom common jokers

local one_up = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.rarities.common.enabled and SMODS.Joker{
    key = 'one_up',
    name = '1 UP',
    rarity = 1,
    unlocked = true,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    pos = {
        x = 1,
        y = 0,
    },
    cost = 3,
    config = {
        dollars = 5,
    },
    atlas = 'common_jokers',
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.dollars}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
            if not card.used then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                    func = function()
                        play_sound('tarot1')  
                        G.jokers:remove_card(card)
                        card:remove()
                        card = nil
                        return true
                    end
                }))
                card.used = true
                if not context.game_over then
                    ease_dollars(5)
                end
                return {
                    message = '1 UP!',
                    repetitions = 0,
                    saved = true,
                    colour = G.C.GREEN,
                }
            end
        end
    end,
}

local coin_toss = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.rarities.common.enabled and SMODS.Joker{
    key = 'coin_toss',
    name = 'Coin Toss',
    rarity = 1,
    unlocked = true,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    pos = {
        x = 2,
        y = 0,
    },
    cost = 4,
    config = {
        extra = 1,
    },
    atlas = 'common_jokers',
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,

    loc_vars = function(self, info_queue, card)
        return {vars = {G.GAME.probabilities.normal}}
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced then
            if pseudorandom(pseudoseed('coin')) < G.GAME.probabilities.normal/2 then
                G.E_MANAGER:add_event(Event({func = function()
                        ease_hands_played(card.ability.extra)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = '+'..card.ability.extra..' Hand'})
                        return true
                    end
                }))
            else
                G.E_MANAGER:add_event(Event({func = function()
                        ease_discard(card.ability.extra)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = '+'..card.ability.extra..' Discard'})
                        return true
                    end
                }))
            end
        end
    end,
}

local warm_up = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.rarities.common.enabled and SMODS.Joker{
    key = 'warm_up',
    name = 'Warm Up',
    rarity = 1,
    unlocked = true,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    pos = {
        x = 3,
        y = 0,
    },
    cost = 4,
    config = {
        amt = 15,
        extra = 1,
    },
    atlas = 'common_jokers',
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.amt, card.ability.extra}}
    end,

    calculate = function(self, card, context)
        if context.after and G.GAME.current_round.hands_played == 0 then
            if G.GAME.chips < (card.ability.amt/100) * G.GAME.blind.chips and G.GAME.chips ~= 0 then
                G.E_MANAGER:add_event(Event({func = function()
                        ease_hands_played(card.ability.extra)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = '+'..card.ability.extra..' Hand'})
                        return true
                    end
                }))
            end
        end
    end,
}

local the_solo = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.rarities.common.enabled and SMODS.Joker{
    key = 'the_solo',
    name = 'The Solo',
    rarity = 1,
    unlocked = true,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    pos = {
        x = 4,
        y = 0,
    },
    cost = 5,
    atlas = 'common_jokers',
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{type='variable',key='a_xmult',vars={1}},
                colour = G.C.RED,
                Xmult_mod = 1,
            }
        end
    end,
}

local diving_joker = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.rarities.common.enabled and SMODS.Joker{
    key = 'diving_joker',
    name = 'Diving Joker',
    rarity = 1,
    unlocked = true,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    pos = {
        x = 5,
        y = 0,
    },
    config = {
        extra = 2,
    },
    cost = 5,
    atlas = 'common_jokers',
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,

    loc_vars = function(self, info_queue, card)
        local playing_cards = G.playing_cards or {}
        local deck_cards = G.deck and G.deck.cards or {}
        local drawn = #playing_cards - #deck_cards
        drawn = math.max(math.floor(drawn/8), 0)
        return {vars = {card.ability.extra, card.ability.extra*drawn}}
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local playing_cards = G.playing_cards or {}
            local deck_cards = G.deck and G.deck.cards or {}
            local drawn = #playing_cards - #deck_cards
            drawn = math.floor(drawn/8)
            if drawn > 0 then
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra*drawn}},
                    mult_mod = card.ability.extra*drawn,
                    colour = G.C.MULT
                }
            end
        end
    end,
}

local accountant = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.rarities.common.enabled and SMODS.Joker{
    key = 'accountant',
    name = 'Accountant',
    rarity = 1,
    unlocked = true,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    pos = {
        x = 0,
        y = 1,
    },
    config = {
        extra = 2,
        mult_mod = 0,
    },
    cost = 6,
    atlas = 'common_jokers',
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra, card.ability.mult_mod}}
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.mult_mod > 0 then
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.mult_mod}},
                    mult_mod = card.ability.mult_mod,
                    colour = G.C.MULT
                }
            end
        end
    end,

    calc_dollar_bonus = function(self, card)
        local inc = card.ability.extra * G.GAME.interest_amount*math.min(math.floor(G.GAME.dollars/5), G.GAME.interest_cap/5)
        if inc > 0 then
            card.ability.mult_mod = card.ability.mult_mod + inc
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
        end
    end,
}

local museum = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.rarities.common.enabled and SMODS.Joker{
    key = 'museum',
    name = 'Museum',
    rarity = 1,
    unlocked = true,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    pos = {
        x = 1,
        y = 1,
    },
    config = {
        mult_mod = 0,
    },
    cost = 6,
    atlas = 'common_jokers',
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.mult_mod}}
    end,

    calculate = function(self, card, context)
        if context.selling_card then
            if context.card.ability.set == 'Joker' then
                card.ability.mult_mod = card.ability.mult_mod + context.card.sell_cost
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED,
                    card = card
                }
            end
        end
        if context.joker_main and card.ability.mult_mod > 0 then
            return {
                message = localize{type='variable',key='a_mult',vars={card.ability.mult_mod}},
                mult_mod = card.ability.mult_mod,
                colour = G.C.MULT
            }
        end
    end,
}