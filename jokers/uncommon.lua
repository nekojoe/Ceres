-- atlas for uncommon jokers

local uncommon_joker_atlas = SMODS.Atlas{
    key = 'uncommon_jokers',
    path = 'uncommon_jokers.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

-- custom uncommon jokers

local chainsaw_devil = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.themed.enabled and Ceres.SETTINGS.jokers.themed.csm.enabled and SMODS.Joker{
    key = 'chainsaw_devil',
    name = 'Chainsaw Devil',
    rarity = 2,
    unlocked = true,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
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

local professor = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.rarities.uncommon.enabled and SMODS.Joker{
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
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
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

local squared = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.rarities.uncommon.enabled and SMODS.Joker{
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
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.extra,
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


local favourable_odds = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.rarities.uncommon.enabled and SMODS.Joker{
    key = 'favourable_odds',
    rarity = 2,
    pos = {
        x = 4,
        y = 0,
    },
    soul_pos = {
        x = 5,
        y = 0,
    },
    atlas = 'uncommon_jokers',
    cost = 7,
    unlocked = true,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
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