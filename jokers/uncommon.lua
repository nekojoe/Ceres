-- atlas for uncommon jokers

local uncommon_joker_atlas = SMODS.Atlas{
    key = 'uncommon_jokers',
    path = 'uncommon_jokers.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

-- custom uncommon jokers

local chainsaw_devil = false and Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.uncommon.enabled and SMODS.Joker{
    key = 'chainsaw_devil',
    rarity = 2,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    pos = {
        x = 1,
        y = 0,
    },
    cost = 7,
    config = {
        mult_min = 16,
        mult_max = 36,
        x_mult_min = 1.1,
        x_mult_max = 1.4,
        x_mult_chance = 0.2,
        chips_min = 57,
        chips_max = 73,
        chips_chance = 0.6,
        money_min = 1,
        money_max = 3,
        money_chance = 0.2,
        woof_chance = 0.7,
    },
    atlas = 'uncommon_jokers',
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,

    calculate = function(self, card, context)
        if context.joker_main then
            local mult = pseudorandom('pochita') > self.config.chips_chance
            if not mult then
                local temp_chips = pseudorandom('pochita', self.config.chips_min, self.config.chips_max)
                return {
                    message = localize{type = 'variable', key = 'a_chips', vars = {temp_chips}},
                    chip_mod = temp_chips,
                }
            else
                local x_mult = pseudorandom('pochita') < self.config.x_mult_chance
                if x_mult then
                    local temp_x_mult = pseudorandom('pochita', self.config.x_mult_min, self.config.x_mult_max)
                    return {
                        message = localize{type = 'variable', key = 'a_xmult', vars = {temp_x_mult}},
                        Xmult_mod = temp_x_mult,
                    }
                else
                    local temp_mult = pseudorandom('pochita', self.config.mult_min, self.config.mult_max)
                    return {
                        message = localize{type = 'variable', key = 'a_mult', vars = {temp_mult}},
                        mult_mod = temp_mult,
                    }
                end
            end
        elseif context.after and not context.blueprint and not context.control_devil then
            if pseudorandom('pochita') < self.config.woof_chance then
                return {
                    message = 'Woof!',
                }
            end
        end
    end,

    calc_dollar_bonus = function(self, card)
        if pseudorandom('pochita') < self.config.money_chance then
            return pseudorandom('pochita', self.config.money_min, self.config.money_max)
        end
    end,
}

local snake_eyes = Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.rare.enabled and SMODS.Joker{
    key = 'snake_eyes',
    rarity = 2,
    unlocked = false or Ceres.CONFIG.misc.unlock_all.enabled, -- smth luck related
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    pos = {
        x = 3,
        y = 0,
    },
    cost = 6,
    config = {
        extra = 1,
    },
    atlas = 'rare_jokers',
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    -- unfortunately thunk isnt consistent with chance jokers using odds in their abilities

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
        end
    end,
}

local professor = Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.uncommon.enabled and SMODS.Joker{
    key = 'professor',
    config = {
        extra = 1,
    },
    rarity = 2,
    pos = {
        x = 2,
        y = 0,
    },
    atlas = 'uncommon_jokers',
    cost = 6,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                'Ace',
            },
        }
    end,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 14 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra,
                    card = card
                }
            end
        end
    end,
}

local squared = Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.uncommon.enabled and SMODS.Joker{
    key = 'squared',
    config = {
        extra = 9,
    },
    rarity = 2,
    pos = {
        x = 3,
        y = 0,
    },
    atlas = 'uncommon_jokers',
    cost = 9,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra,
            },
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 or
            context.other_card:get_id() == 9 or
            context.other_card:get_id() == 4 then
                return {
                    mult = card.ability.extra,
                    card = card,
                }
            end
        end
    end,
}


local favourable_odds = Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.uncommon.enabled and SMODS.Joker{
    key = 'favourable_odds',
    rarity = 2,
    pos = {
        x = 4,
        y = 0,
    },
    soul_pos = {
        x = 4,
        y = 1,
    },
    atlas = 'uncommon_jokers',
    cost = 7,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS['m_lucky']
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            local odds = {}
            for k, v in ipairs(context.scoring_hand) do
                if (v:get_id() <= 10 and 
                v:get_id() >= 0 and
                v:get_id()%2 == 1) or
                v:get_id() == 14
                then
                    odds[#odds+1] = v
                    v:set_ability(G.P_CENTERS.m_lucky, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    })) 
                end
            end
            if #odds > 0 then
                return {
                    message = {'Lucky'},
                    colour = G.C.GREEN,
                    card = card,
                }
            end
        end
    end,
}

local miku = Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.uncommon.enabled and SMODS.Joker{
    key = 'miku',
    rarity = 2,
    pos = {
        x = 5,
        y = 0,
    },
    soul_pos = {
        x = 5,
        y = 1,
    },
    config = {
        extra = 0.1,
        x_mult = 1,
    },
    atlas = 'uncommon_jokers',
    cost = 7,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra,
                card.ability.x_mult,
            },
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if context.scoring_name and not (context.individual or context.repetition or context.blueprint) then
                local curr_level = (G.GAME.hands[context.scoring_name].level or 1)
                local inc = true
                for k, v in pairs(G.GAME.hands) do
                    if k ~= context.scoring_name and v.level > curr_level then
                        inc = false
                    end
                end
                if inc then
                    card.ability.x_mult = card.ability.x_mult + card.ability.extra
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.x_mult}}})
                end
            end
        end
        if context.joker_main and card.ability.x_mult > 0 then
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.x_mult}},
                colour = G.C.RED,
                Xmult_mod = card.ability.x_mult,
                repetitions = 0
            }
        end
    end,
}

local marlboro_reds = Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.uncommon.enabled and SMODS.Joker{
    key = 'marlboro_reds',
    rarity = 2,
    pos = {
        x = 0,
        y = 1,
    },
    config = {
        x_mult = 2,
        extra = 0.05,
    },
    atlas = 'uncommon_jokers',
    cost = 6,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.x_mult,
                card.ability.extra,
            },
        }
    end,

    calculate = function(self, card, context)
        -- main
        if context.joker_main then
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.x_mult}},
                colour = G.C.RED,
                Xmult_mod = card.ability.x_mult,
                repetitions = 0
            }
        end
        -- end of round
        if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
            if card.ability.x_mult - card.ability.extra <= 1 then 
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                })) 
                return {
                    message = 'Smoked!',
                    colour = G.C.RED,
                    repetitions = 0
                }
            else
                card.ability.x_mult = card.ability.x_mult - card.ability.extra
                return {
                    message = localize{type='variable',key='a_xmult_minus',vars={card.ability.extra}},
                    colour = G.C.MULT,
                    repetitions = 0,
                }
            end
        end
    end,
}

local skateboard = Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.uncommon.enabled and SMODS.Joker{
    key = 'skateboard',
    rarity = 2,
    pos = {
        x = 1,
        y = 1,
    },
    config = {
        Xmult_mod = 1,
        extra = 0.5,
        hands = {},
    },
    atlas = 'uncommon_jokers',
    cost = 7,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra,
                card.ability.Xmult_mod,
            },
        }
    end,

    calculate = function(self, card, context)
        -- before round
        if context.before and not context.blueprint then
            for _, hand in pairs(card.ability.hands) do
                if hand == context.scoring_name then
                    return
                end
            end
            card.ability.hands[#card.ability.hands+1] = context.scoring_name
            card.ability.Xmult_mod = 1 + (#card.ability.hands * card.ability.extra)
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED,
                card = card
            }
        end
        -- during round
        if context.joker_main and card.ability.Xmult_mod > 1 then
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult_mod}},
                colour = G.C.RED,
                Xmult_mod = card.ability.Xmult_mod,
            }
        end
        -- end of round
        if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
            card.ability.hands = {}
            card.ability.Xmult_mod = 1
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end
    end,
}

-- atlas for stopwatch

local stopwatch_joker_atlas = SMODS.Atlas{
    key = 'stopwatch_joker',
    path = 'stopwatch.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

local stopwatch = Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.uncommon.enabled and SMODS.Joker{
    key = 'stopwatch',
    rarity = 2,
    pos = {
        x = 0,
        y = 0,
    },
    config = {
        Xmult_mod = 1,
        dt = 0,
        active = false
    },
    atlas = 'stopwatch_joker',
    cost = 7,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.Xmult_mod,
            },
        }
    end,

    update = function(self, card, dt)
        if card.ability.active then
            card.ability.dt = card.ability.dt + G.real_dt
            card.ability.Xmult_mod = 1 + (math.floor(card.ability.dt) * 0.01)
        end
        card.config.center.pos.x = (math.floor(card.ability.dt) % 12)
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced and not context.blueprint then
            card.ability.active = true
            card.ability.Xmult_mod = 1
            card.ability.dt = 0
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Start!'})
        end
        if context.joker_main and card.ability.Xmult_mod > 1 then
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult_mod}},
                colour = G.C.RED,
                Xmult_mod = card.ability.Xmult_mod,
            }
        end
        if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
            card.ability.active = false
            card.ability.Xmult_mod = 1
            card.ability.dt = 0
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Stop!'})
        end
    end,
}

local fisherman = Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.uncommon.enabled and SMODS.Joker{
    key = 'fisherman',
    rarity = 2,
    pos = {
        x = 2,
        y = 1,
    },
    config = {
        extra = 1,
        added = 0
    },
    atlas = 'uncommon_jokers',
    cost = 6,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra,
            },
        }
    end,

    calculate = function(self, card, context)
        if context.before then
            G.hand:change_size(card.ability.extra)
            card.ability.added = card.ability.added + card.ability.extra
            return {
                message = '+' .. card.ability.extra .. ' Size',
                colour = G.C.BLUE,
            }
        end
        if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
            G.hand:change_size(-card.ability.added)
            card.ability.added = 0
            return {
                message = localize('k_reset')
            }
        end
    end,
}

local insurance_fraud = Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.uncommon.enabled and SMODS.Joker{
    key = 'insurance_fraud',
    rarity = 2,
    pos = {
        x = 3,
        y = 1,
    },
    config = {
        extra = 3,
        debuffed = {}
    },
    atlas = 'uncommon_jokers',
    cost = 8,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        if G.GAME.cere_insurance_card then
            return {
                vars = {
                    G.GAME.cere_insurance_card.rank,
                    card.ability.extra,
                },
            }
        else
            return {
                vars = {
                    'Ace',
                    card.ability.extra,
                }
            }
        end
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced and not context.blueprint and G.GAME.cere_insurance_card then
            for _, _card in pairs(G.deck.cards) do
                if _card:get_id() == G.GAME.cere_insurance_card.id then
                    card.ability.debuffed[#card.ability.debuffed+1] = _card
                    _card.debuff = true
                end
            end
        end
        if context.joker_main then
            local debuff_tot = 0
            for _, _card in pairs(context.scoring_hand) do
                if _card.debuff then
                    debuff_tot = debuff_tot + 1
                end
            end
            if debuff_tot > 0 then
                ease_dollars(card.ability.extra*debuff_tot)
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + (card.ability.extra*debuff_tot)
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                return {
                    message = localize('$') .. (card.ability.extra*debuff_tot),
                    dollars = (card.ability.extra*debuff_tot),
                    colour = G.C.MONEY
                }
            end
        end
        if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
            for _, _card in pairs(card.ability.debuffed) do
                _card.debuff = false
            end
            card.ability.debuffed = {}
        end
    end,
}

local seasoning = false and Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.uncommon.enabled and SMODS.Joker{
    key = 'seasoning',
    rarity = 2,
    pos = {
        x = 0,
        y = 0,
    },
    config = {
        extra = 3,
    },
    atlas = 'uncommon_jokers',
    cost = 6,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra, card.ability.extra > 1 and 's' or ''}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.other_card and not context.repetition and not context.blueprint and context.cardarea == G.play then
            if card.ability.extra > 0 then
                local seal = SMODS.poll_seal({guaranteed = true})
                local enhancement =  pseudorandom_element(G.P_CENTER_POOLS.Enhanced, pseudoseed('seasoning'))
                local edition = poll_edition('seasoning', nil, true, true)
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() context.other_card:flip();play_sound('card1', percent);context.other_card:juice_up(0.3, 0.3);return true end }))
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.175,func = function() 
                    context.other_card:set_seal(seal, true, true)
                    context.other_card:set_ability(enhancement)
                    context.other_card:set_edition(edition, true, true)
                    return true 
                end 
                }))
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() context.other_card:flip();play_sound('tarot2', percent, 0.6);context.other_card:juice_up(0.3, 0.3);return true end }))
                card.ability.extra = card.ability.extra - 1
                card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {message = 'Seasoned!', colour = G.C.RED})
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                })) 
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Empty!', colour = G.C.RED})
            end
        end
    end,
}

local ghost = Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.uncommon.enabled and SMODS.Joker{
    key = 'ghost',
    rarity = 2,
    pos = {
        x = 1,
        y = 2,
    },
    config = {
        extra = 0.5,
        Xmult_mod = 1,
    },
    atlas = 'uncommon_jokers',
    cost = 6,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra, card.ability.Xmult_mod}}
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.ability.set == 'Spectral' then
                card.ability.Xmult_mod = card.ability.Xmult_mod + card.ability.extra
                G.E_MANAGER:add_event(Event({
                    func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')}); return true
                    end}))
            end
        end
        if context.joker_main and card.ability.Xmult_mod > 1 then
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult_mod}},
                colour = G.C.RED,
                Xmult_mod = card.ability.Xmult_mod,
            }
        end
    end,
}

local blacksmith = Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.uncommon.enabled and SMODS.Joker{
    key = 'blacksmith',
    rarity = 2,
    pos = {
        x = 0,
        y = 2,
    },
    config = {
        extra = 0,
    },
    atlas = 'uncommon_jokers',
    cost = 7,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra, card.ability.extra == 1 and '' or 's'}}
    end,

    calculate = function(self, card, context)
        if context.selling_self then
            if card.ability.extra > 0 then
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true end }))
                update_hand_text({delay = 0}, {mult = '+', StatusText = true})
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true end }))
                update_hand_text({delay = 0}, {chips = '+', StatusText = true})
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true end }))
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+'..card.ability.extra})
                delay(1.3)
                for k, v in pairs(G.GAME.hands) do
                    level_up_hand(card, k, true, card.ability.extra)
                end
                update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
            end
        end
        if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
            card.ability.extra = card.ability.extra + 1
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.SECONDARY_SET.Planet})
        end
    end,
}