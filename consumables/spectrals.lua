local spectral_atlas = SMODS.Atlas{
    key = 'spectrals',
    px = 71,
    py = 95,
    path = 'spectrals.png',
    atlas_table = 'ASSET_ATLAS',
}

local chromatic = Ceres.CONFIG.card_modifiers.editions.enabled and SMODS.Consumable{
    key = 'chromatic',
    set = 'Spectral',
    pos = {
        x = 0,
        y = 0,
    },
    atlas = 'spectrals',
    cost = 4,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_cere_colourblind
    end,

    can_use = function(self, card)
        if #G.hand.highlighted == 1 then
            if not G.hand.highlighted[1].edition then return true end
        end
        if #G.hand.highlighted == 0 then
            if G.jokers then
                for _, card in pairs(G.jokers.cards) do
                    if not card.edition then
                        return true
                    end
                end
            end
        end
        return false
    end,

    use = function(self, card, area, copier)
        local valid_cards = {}
        local picked_card = nil
        if #G.hand.highlighted == 1 then
            if not G.hand.highlighted[1].edition then
                picked_card = G.hand.highlighted[1]
            end
        end
        if #G.hand.highlighted == 0 then
            if G.jokers then
                for _, card in pairs(G.jokers.cards) do
                    if not card.edition then
                        valid_cards[#valid_cards+1] = card
                    end
                end
                picked_card = pseudorandom_element(valid_cards, pseudoseed('colourblind'))
            end
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                local over = false
                local edition = 'e_cere_colourblind'
                picked_card:set_edition(edition, true)
                card:juice_up(0.3, 0.5)
                return true 
            end 
        }))  
    end,
}

local camouflage = Ceres.CONFIG.card_modifiers.editions.enabled and SMODS.Consumable{
    key = 'camouflage',
    set = 'Spectral',
    pos = {
        x = 1,
        y = 0,
    },
    atlas = 'spectrals',
    cost = 4,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_cere_sneaky
    end,

    can_use = function(self, card)
        if #G.hand.highlighted == 1 then
            if not G.hand.highlighted[1].edition then return true end
        end
        if #G.hand.highlighted == 0 then
            if G.jokers then
                for _, card in pairs(G.jokers.cards) do
                    if not card.edition then
                        return true
                    end
                end
            end
        end
        return false
    end,

    use = function(self, card, area, copier)
        local valid_cards = {}
        local picked_card = nil
        if #G.hand.highlighted == 1 then
            if not G.hand.highlighted[1].edition then
                picked_card = G.hand.highlighted[1]
            end
        end
        if #G.hand.highlighted == 0 then
            if G.jokers then
                for _, card in pairs(G.jokers.cards) do
                    if not card.edition then
                        valid_cards[#valid_cards+1] = card
                    end
                end
                picked_card = pseudorandom_element(valid_cards, pseudoseed('sneaky'))
            end
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                local over = false
                local edition = 'e_cere_sneaky'
                picked_card:set_edition(edition, true)
                card:juice_up(0.3, 0.5)
                return true 
            end 
        }))  
    end,
}

local con_ess_pool = {
    'j_cere_makima',
    'j_cere_aizen'
}

local function get_divine_pool(_type, _rarity, _legendary, _append)
    --create the pool
    G.ARGS.TEMP_POOL = EMPTY(G.ARGS.TEMP_POOL)
    local _pool, _starting_pool, _pool_key, _pool_size = G.ARGS.TEMP_POOL, nil, '', 0

    local rarity = 'cere_divine'
    local _starting_pool, _pool_key = con_ess_pool, 'Joker'..'cere_divine'

    --cull the pool
    for k, v in ipairs(_starting_pool) do
        local add = nil
        if not (G.GAME.used_jokers[v] and not next(find_joker("Showman"))) then
            add = true
        end

        if add then 
            _pool[#_pool + 1] = v
            _pool_size = _pool_size + 1
        else
            _pool[#_pool + 1] = 'UNAVAILABLE'
        end
    end

    --if pool is empty
    if _pool_size == 0 then
        _pool[#_pool + 1] = "j_joker"
    end

    return _pool, _pool_key
end

local function create_divine()
    local _pool, _pool_key = get_divine_pool()
    local center = pseudorandom_element(_pool, pseudoseed(_pool_key))
    local it = 1
    while center == 'UNAVAILABLE' do
        it = it + 1
        center = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
    end
    
    local card = Card(G.jokers.T.x + G.jokers.T.w/2, G.jokers.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[center],
    {bypass_discovery_center = true,
    bypass_discovery_ui = false,
    discover = true,
    bypass_back = G.GAME.selected_back.pos})
    if G.GAME.modifiers.all_eternal then
        card:set_eternal(true)
    end
    card:start_materialize()
    local edition = poll_edition('edi'..'cere'..G.GAME.round_resets.ante)
    card:set_edition(edition)
    check_for_unlock({type = 'have_edition'})

    return card
end

local ceres_spectral = Ceres.CONFIG.jokers.enabled and Ceres.CONFIG.jokers.rarities.divine.enabled and SMODS.Consumable{
    key = 'ceres_spectral',
    set = 'Spectral',
    pos = {
        x = 2,
        y = 0,
    },
    soul_pos = {
        x = 2,
        y = 1,
    },
    atlas = 'spectrals',
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    hidden = true,
    soul_set = 'Spectral',
    soul_rate = 0.001,

    can_use = function(self, card)
        if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
            return true
        end
        return false
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            local card = create_divine()
            card:add_to_deck()
            G.jokers:emplace(card)
            card:juice_up(0.3, 0.5)
            return true end }))
        delay(0.6)
    end
}

local magnet = Ceres.CONFIG.card_modifiers.seals.enabled and SMODS.Consumable{
    key = 'magnet',
    set = 'Spectral',
    pos = {
        x = 3,
        y = 0,
    },
    config = {
        seal = 's_cere_green_seal',
    },
    atlas = 'spectrals',
    cost = 4,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 's_cere_green_seal_seal', vars = {G.GAME.probabilities.normal, 2}}
    end,

    can_use = function(self, card)
        if G.hand and (#G.hand.highlighted == 1) and G.hand.highlighted[1] then
            return true
        else
            return false
        end
    end,

    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            conv_card:set_seal(card.ability.seal, nil, true)
            return true end }))
        
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
}

local card_sleeve = Ceres.CONFIG.card_modifiers.editions.enabled and SMODS.Consumable{
    key = 'card_sleeve',
    set = 'Spectral',
    pos = {
        x = 4,
        y = 0,
    },
    atlas = 'spectrals',
    cost = 4,
    unlocked = true,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_cere_mint_condition
    end,

    can_use = function(self, card)
        if #G.hand.highlighted == 1 then
            if not G.hand.highlighted[1].edition then return true end
        end
        if #G.hand.highlighted == 0 then
            if G.jokers then
                for _, card in pairs(G.jokers.cards) do
                    if not card.edition then
                        return true
                    end
                end
            end
        end
        return false
    end,

    use = function(self, card, area, copier)
        local valid_cards = {}
        local picked_card = nil
        if #G.hand.highlighted == 1 then
            if not G.hand.highlighted[1].edition then
                picked_card = G.hand.highlighted[1]
            end
        end
        if #G.hand.highlighted == 0 then
            if G.jokers then
                for _, card in pairs(G.jokers.cards) do
                    if not card.edition then
                        valid_cards[#valid_cards+1] = card
                    end
                end
                picked_card = pseudorandom_element(valid_cards, pseudoseed('mint_condition'))
            end
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                local over = false
                local edition = 'e_cere_mint_condition'
                picked_card:set_edition(edition, true)
                card:juice_up(0.3, 0.5)
                return true 
            end 
        }))  
    end,
}