local back_atlas = SMODS.Atlas{
    key = 'backs',
    path = 'backs.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

local scratch = Ceres.CONFIG.run_modifiers.decks.enabled and SMODS.Back{
    key = 'scratch',
    unlocked = false or Ceres.CONFIG.misc.unlock_all.enabled,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    atlas = 'backs',
    pos = {
        x = 0,
        y = 0,
    },
    config = {
        vouchers = {
            'v_hone',
            'v_clearance_sale',
        },
        reroll_discount = -2,
    },
}

if Ceres.CONFIG.run_modifiers.decks.enabled then
    G.P_CENTERS['sticker_eternal'] = { set = 'Other', key = 'eternal' }
end

local soul = Ceres.CONFIG.run_modifiers.decks.enabled and SMODS.Back{
    key = 'soul',
    unlocked = false or Ceres.CONFIG.misc.unlock_all.enabled,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    atlas = 'backs',
    pos = {
        x = 1,
        y = 0,
    },
    soul_pos = {
        x = 1,
        y = 1,
    },
    config = {},

    apply = function(self)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.8, func = function()
            play_sound('timpani')
            local card = create_card('Joker', G.jokers, true, nil, nil, nil, nil, 'sou')
            card:set_eternal(true)
            card:add_to_deck()
            G.jokers:emplace(card)
            check_for_unlock{type = 'spawn_legendary'}
        return true end }))
    end,
}

local gift = Ceres.CONFIG.run_modifiers.decks.enabled and SMODS.Back{
    key = 'gift',
    unlocked = false or Ceres.CONFIG.misc.unlock_all.enabled,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    atlas = 'backs',
    pos = {
        x = 2,
        y = 0,
    },
    config = {
        vouchers = {
            'v_cere_overflow_norm',
        },
        dollars = 5,
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.dollars}}
    end,
}

local golden = Ceres.CONFIG.run_modifiers.decks.enabled and SMODS.Back{
    key = 'golden',
    unlocked = false or Ceres.CONFIG.misc.unlock_all.enabled,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    atlas = 'backs',
    pos = {
        x = 3,
        y = 0,
    },
    config = {
        no_interest = true,
        extra_card_bonus = 2,
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.extra_card_bonus}}
    end,
}