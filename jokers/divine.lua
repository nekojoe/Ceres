local divine_joker_atlas = SMODS.Atlas{
    key = 'divine_jokers',
    path = 'divine_jokers.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

local makima = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.themed.enabled and Ceres.SETTINGS.jokers.themed.csm.enabled and SMODS.Joker{
    key = 'makima',
    name = 'Makima',
    rarity = 'cere_divine',
    unlocked = false or Ceres.SETTINGS.misc.unlock_all.enabled,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    pos = {
        x = 0,
        y = 0,
    },
    soul_pos = {
        x = 0,
        y = 1,
    },
    cost = 50,
    config = {
        Emult_mod = 1,
        extra = 0.01,
    },
    atlas = 'divine_jokers',
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'makima_info'}
        return {vars = {card.ability.extra, card.ability.Emult_mod}}
    end,

    calculate = function(self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker then
            if context.other_card.ability and context.other_card.ability.set == 'Joker' then
                local price_diff = math.floor((card.sell_cost - context.other_card.sell_cost) / 10)
                if price_diff > 0 then
                    card.ability.Emult_mod = card.ability.Emult_mod + (price_diff*card.ability.extra)
                    return {
                        message = localize('k_again_ex'),
                        repetitions = price_diff,
                        card = card
                    }
                end
            end
        end
        if context.joker_main then
            return {
                message = '^' .. card.ability.Emult_mod .. ' Mult',
                Emult_mod = card.ability.Emult_mod,
                colour = G.C.RED,
            }
        end
    end,
}

local aizen = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.themed.enabled and Ceres.SETTINGS.jokers.themed.bleach.enabled and SMODS.Joker{
    key = 'aizen',
    name = 'aizen',
    rarity = 'cere_divine',
    unlocked = false or Ceres.SETTINGS.misc.unlock_all.enabled,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    pos = {
        x = 1,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 1,
    },
    cost = 50,
    config = {
        Emult_mod = 1,
        extra = 0.01,
        old_select_size = 5,
    },
    atlas = 'divine_jokers',
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'aizen_info'}
        return {vars = {card.ability.extra, card.ability.Emult_mod}}
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.old_select_size = G.hand.config.highlighted_limit
        G.play.T.w = 6.3*G.CARD_W
        G.hand.config.highlighted_limit = 6
    end, 

    remove_from_deck = function(self, card, from_debuff)
        G.play.T.w = 5.3*G.CARD_W
        G.hand.config.highlighted_limit = card.ability.old_select_size
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
        if context.individual and context.cardarea == G.play then
            card.ability.Emult_mod = card.ability.Emult_mod + card.ability.extra
        end
        if context.joker_main then
            return {
                message = '^' .. card.ability.Emult_mod .. ' Mult',
                Emult_mod = card.ability.Emult_mod,
            }
        end
    end,
} or false