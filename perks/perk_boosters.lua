local booster_atlas = SMODS.Atlas{
    key = 'booster_atlas',
    path = 'boosters.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

local perk_pool = {
    'pk_cere_prototype',
    'pk_cere_dirty_napkin',
    'pk_cere_reward_card',
    'pk_cere_business_card',
    'pk_cere_trading_card',
    'pk_cere_plus_two',
}

local function poll_perk(pool, key)
    pool = pool or perk_pool or {}
    key = key or 'cere'
    return pseudorandom_element(pool, pseudoseed(key))
end

local booster_one = Ceres.SETTINGS.card_effects.perks.enabled and SMODS.Booster{
    key = "perk_normal_1",
    kind = "Perk",
    atlas = "booster_atlas",
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = 3,
        choose = 1
    },
    cost = 4,
    weight = 0.96,
    discovered = false or Ceres.SETTINGS.misc.discover_all,

    create_card = function(self, card)
        local card = create_card('Base', G.pack_cards, nil, nil, true, true, nil, 'cere')
        local perk = poll_perk()
        local edition = poll_edition()
        edition = edition and edition.negative and edition or nil
        card:set_ability(G.P_CENTERS[perk])
        card:set_edition(edition, true)
        return card
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Spectral)
        ease_background_colour{new_colour = G.C.SECONDARY_SET.Spectral, special_colour = G.C.BLACK, contrast = 2}
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'perk_info'}
		return { vars = {card.config.center.config.choose, card.ability.extra} }
	end,

    group_key = "k_perk_pack"
}

local booster_two = Ceres.SETTINGS.card_effects.perks.enabled and SMODS.Booster{
    key = "perk_normal_2",
    kind = "Perk",
    atlas = "booster_atlas",
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = 3,
        choose = 1
    },
    cost = 4,
    weight = 0.96,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,

    create_card = function(self, card)
        local card = create_card('Base', G.pack_cards, nil, nil, true, true, nil, 'cere')
        local perk = poll_perk()
        local edition = poll_edition()
        edition = edition and edition.negative and edition or nil
        card:set_ability(G.P_CENTERS[perk])
        card:set_edition(edition, true)
        return card
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Spectral)
        ease_background_colour{new_colour = G.C.SECONDARY_SET.Spectral, special_colour = G.C.BLACK, contrast = 2}
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'perk_info'}
		return { vars = {card.config.center.config.choose, card.ability.extra} }
	end,

    group_key = "k_perk_pack"
}

local booster_jumbo = Ceres.SETTINGS.card_effects.perks.enabled and SMODS.Booster{
    key = "perk_jumbo",
    kind = "Perk",
    atlas = "booster_atlas",
    pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = 5,
        choose = 1
    },
    cost = 6,
    weight = 0.48,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,

    create_card = function(self, card)
        local card = create_card('Base', G.pack_cards, nil, nil, true, true, nil, 'cere')
        local perk = poll_perk()
        local edition = poll_edition()
        edition = edition and edition.negative and edition or nil
        card:set_ability(G.P_CENTERS[perk])
        card:set_edition(edition, true)
        return card
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Spectral)
        ease_background_colour{new_colour = G.C.SECONDARY_SET.Spectral, special_colour = G.C.BLACK, contrast = 2}
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'perk_info'}
		return { vars = {card.config.center.config.choose, card.ability.extra} }
	end,

    group_key = "k_perk_pack"
}

local booster_mega = Ceres.SETTINGS.card_effects.perks.enabled and SMODS.Booster{
    key = "perk_mega",
    kind = "Perk",
    atlas = "booster_atlas",
    pos = {
        x = 3,
        y = 0,
    },
    config = {
        extra = 5,
        choose = 2,
    },
    cost = 8,
    weight = 0.12,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,

    create_card = function(self, card)
        local card = create_card('Base', G.pack_cards, nil, nil, true, true, nil, 'cere')
        local perk = poll_perk()
        local edition = poll_edition()
        edition = edition and edition.negative and edition or nil
        card:set_ability(G.P_CENTERS[perk])
        card:set_edition(edition, true)
        return card
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Spectral)
        ease_background_colour{new_colour = G.C.SECONDARY_SET.Spectral, special_colour = G.C.BLACK, contrast = 2}
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'perk_info'}
		return { vars = {card.config.center.config.choose, card.ability.extra} }
	end,

    group_key = "k_perk_pack"
}