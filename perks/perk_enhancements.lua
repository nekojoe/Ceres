local enhancement_atlas = SMODS.Atlas{
    key = 'perk_atlas',
    path = 'perks.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

-- this shit could go somewhere else but ill do that another time

Ceres.PERKS = {
    'm_cere_prototype',
    'm_cere_dirty_napkin',
    'm_cere_reward_card',
    'm_cere_business_card',
    'm_cere_trading_card',
}

function perk_message(card, text, colour)
    local percent = (0.9 + 0.2*math.random())
    local volume = 1
    local card_aligned = 'bm'
    local y_off = 0.15*G.CARD_H
    if card.area == G.jokers or card.area == G.consumeables then
        y_off = 0.05*card.T.h
    elseif card.area == G.hand then
        y_off = -0.05*G.CARD_H
        card_aligned = 'tm'
    elseif card.area == G.play then
        y_off = -0.05*G.CARD_H
        card_aligned = 'tm'
    elseif card.jimbo  then
        y_off = -0.05*G.CARD_H
        card_aligned = 'tm'
    end
    local config = {
        scale = 0.7,
        type = 'fall'
    }
    local delay = 0.75 * 1.25
    local colour = colour or G.C.FILTER
    local extrafunc = nil
    local sound = 'generic1'
    G.E_MANAGER:add_event(Event({ --Add bonus chips from this card
        trigger = 'before',
        delay = delay,
        func = function()
        if extrafunc then extrafunc() end
        attention_text({
            text = text,
            scale = config.scale or 1, 
            hold = delay - 0.2,
            backdrop_colour = colour,
            align = card_aligned,
            major = card,
            offset = {x = 0, y = y_off}
        })
        play_sound(sound, 0.8+percent*0.2, volume)
        if not extra or not extra.no_juice then
            card:juice_up(0.6, 0.1)
            G.ROOM.jiggle = G.ROOM.jiggle + 0.7
        end
        return true
        end
    }))
end

local prototype = Ceres.SETTINGS.enhancements.enabled and Ceres.SETTINGS.enhancements.perks.enabled and SMODS.Enhancement{
    key = 'prototype',
    pos = {
        x = 0,
        y = 0,
    },
    atlas = 'perk_atlas',
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    overrides_base_rank = true,
    config = {
        bonus = 25,
    },
    
    in_pool = function() return false end,

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {set = 'Other', key = 'temp_info'}
        info_queue[#info_queue+1] = G.P_CENTERS['j_blueprint']
        info_queue[#info_queue+1] = {set = 'Other', key = 'burn_info'}
        return {
            vars = {
                'Blueprint',
            }
        }
    end,

    calculate = function(self, context, effect, card)
        if card and not card.burnt then
            card.burnt = true
            perk_message(card, 'Blueprint!', G.C.SECONDARY_SET.Spectral)
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _card = create_card('Joker', G.jokers, nil, 0, nil, nil, 'j_blueprint', 'ben')
                    play_sound('tarot1')
                    _card:set_eternal(true)
                    G.jokers:emplace(_card)
                    _card:start_materialize()
                    G.GAME.joker_buffer = 0
                    table.insert(G.TEMP, _card)
                    return true
                end
            }))
        end   
    end
}

local dirty_napkin = Ceres.SETTINGS.enhancements.enabled and Ceres.SETTINGS.enhancements.perks.enabled and SMODS.Enhancement{
    key = 'dirty_napkin',
    pos = {
        x = 1,
        y = 0,
    },
    atlas = 'perk_atlas',
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    overrides_base_rank = true,
    config = {
        bonus = 25,
    },
    
    in_pool = function() return false end,

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {set = 'Other', key = 'temp_info'}
        info_queue[#info_queue+1] = G.P_CENTERS['j_brainstorm']
        info_queue[#info_queue+1] = {set = 'Other', key = 'burn_info'}
        return {
            vars = {
                'Brainstorm',
            }
        }
    end,

    calculate = function(self, context, effect, card)
        if card and not card.burnt then
            card.burnt = true
            perk_message(card, 'Brainstorm!', G.C.RED)
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _card = create_card('Joker', G.jokers, nil, 0, nil, nil, 'j_brainstorm', 'ben')
                    play_sound('tarot1')
                    _card:set_eternal(true)
                    G.jokers:emplace(_card)
                    _card:start_materialize()
                    G.GAME.joker_buffer = 0
                    table.insert(G.TEMP, _card)
                    return true
                end
            }))
        end   
    end
}

local reward_card = Ceres.SETTINGS.enhancements.enabled and Ceres.SETTINGS.enhancements.perks.enabled and SMODS.Enhancement{
    key = 'reward_card',
    pos = {
        x = 2,
        y = 0,
    },
    atlas = 'perk_atlas',
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    overrides_base_rank = true,
    config = {
        bonus = 25,
        cost = 6,
    },
    
    in_pool = function() return false end,

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_TAGS['tag_coupon']
        info_queue[#info_queue+1] = {set = 'Other', key = 'burn_info'}
        return {
            vars = {
                self.config.cost,
                'Coupon Tag',
            }
        }
    end,

    calculate = function(self, context, effect, card)
        if card and not card.burnt then
            card.burnt = true
            perk_message(card, 'Tag!', G.C.GREEN)
            ease_dollars(-self.config.cost)
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - self.config.cost
            G.E_MANAGER:add_event(Event({func = (function()
                G.GAME.dollar_buffer = 0
                add_tag(Tag('tag_coupon'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                return true 
            end)}))
        end
    end,
}

local business_card = Ceres.SETTINGS.enhancements.enabled and Ceres.SETTINGS.enhancements.perks.enabled and SMODS.Enhancement{
    key = 'business_card',
    pos = {
        x = 3,
        y = 0,
    },
    atlas = 'perk_atlas',
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    overrides_base_rank = true,
    config = {
        bonus = 25,
        cost = 3,
    },

    in_pool = function() return false end,

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_TAGS['tag_uncommon']
        info_queue[#info_queue+1] = {set = 'Other', key = 'burn_info'}
        return {
            vars = {
                self.config.cost,
                'Uncommon Tag',
            }
        }
    end,

    calculate = function(self, context, effect, card)
        if card and not card.burnt then
            card.burnt = true
            perk_message(card, 'Tag!', G.C.GREEN)
            ease_dollars(-self.config.cost)
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - self.config.cost
            G.E_MANAGER:add_event(Event({func = (function()
                G.GAME.dollar_buffer = 0
                add_tag(Tag('tag_uncommon'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                return true 
            end)}))
        end
    end,
}

local trading_card = Ceres.SETTINGS.enhancements.enabled and Ceres.SETTINGS.enhancements.perks.enabled and SMODS.Enhancement{
    key = 'trading_card',
    pos = {
        x = 4,
        y = 0,
    },
    atlas = 'perk_atlas',
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    overrides_base_rank = true,
    config = {
        bonus = 25,
    },

    in_pool = function() return false end,

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {set = 'Other', key = 'burn_info'}
    end,

    calculate = function(self, context, effect, card)
        if card and not card.burnt then
            card.burnt = true
            perk_message(card, 'Trade!', G.C.RED)
            for _, _card in pairs(context.scoring_hand) do
                if not _card.traded and _card.ability.name ~= 'm_cere_trading_card' then
                    _card.traded = true
                end
            end
            G.E_MANAGER:add_event(Event({func = (function()
                trading_card_card()
                return true 
            end)}))
        end
    end,
}

-- goofy name i know im rushing here

function trading_card_card()
    local card = create_card("Enhanced", G.hand, nil, nil, nil, true, nil, 'trad')
    local edition_rate = 2
    local edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true)
    card:set_edition(edition)
    local seal_rate = 10
    local seal_poll = pseudorandom(pseudoseed('tradseal'..G.GAME.round_resets.ante))
    if seal_poll > 1 - 0.02*seal_rate then
        local seal_type = pseudorandom(pseudoseed('tradsealtype'..G.GAME.round_resets.ante))
        if seal_type > 0.75 then card:set_seal('Red')
        elseif seal_type > 0.5 then card:set_seal('Blue')
        elseif seal_type > 0.25 then card:set_seal('Gold')
        else card:set_seal('Purple')
        end
    end
    card:add_to_deck()
    G.deck.config.card_limit = G.deck.config.card_limit + 1
    table.insert(G.playing_cards, card)
    G.hand:emplace(card)
    card.states.visible = nil
    card:start_materialize()
end