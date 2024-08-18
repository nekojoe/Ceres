local spectral_atlas = SMODS.Atlas{
    key = 'spectrals',
    px = 71,
    py = 95,
    path = 'spectrals.png',
    atlas_table = 'ASSET_ATLAS',
}

local chromatic = Ceres.SETTINGS.card_effects.editions.enabled and Ceres.SETTINGS.card_effects.editions.colourblind.enabled and SMODS.Consumable{
    key = 'chromatic',
    set = 'Spectral',
    pos = {
        x = 0,
        y = 0,
    },
    atlas = 'spectrals',
    cost = 4,
    unlocked = true,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'colourblind_info'}
        return {vars = {G.GAME.probabilities.normal}}
    end,

    can_use = function(self, card)
        local hand = false
        local joker = false
        if G.hand then
            for _, card in pairs(G.hand.cards) do
                if not card.edition then
                    hand = true
                end
            end
        end
        if G.jokers then
            for _, card in pairs(G.jokers.cards) do
                if not card.edition then
                    joker = true
                end
            end
        end
        return joker or hand
    end,

    use = function(self, card, area, copier)
        local valid_cards = {}
        if G.hand then
            for _, card in pairs(G.hand.cards) do
                if not card.edition then
                    valid_cards[#valid_cards+1] = card
                end
            end
        end
        if G.jokers then
            for _, card in pairs(G.jokers.cards) do
                if not card.edition then
                    valid_cards[#valid_cards+1] = card
                end
            end
        end
        local picked_card = pseudorandom_element(valid_cards, pseudoseed('colourblind'))
        if picked_card.ability.set == 'Joker' then
            if true then--colourblind_compat(picked_card.ability) then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        local over = false
                        local edition = 'e_cere_colourblind'
                        picked_card:set_edition(edition, true)
                        card:juice_up(0.3, 0.5)
                        return true 
                    end 
                }))
            else
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        local over = false
                        local edition = 'e_cere_monochrome'
                        picked_card:set_edition(edition, true)
                        card:juice_up(0.3, 0.5)
                        return true 
                    end 
                }))
            end
        else
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    local over = false
                    local edition = 'e_cere_colourblind'
                    picked_card:set_edition(edition, true)
                    card:juice_up(0.3, 0.5)
                    return true 
                end 
            }))
        end       
    end,
}

local camouflage = Ceres.SETTINGS.card_effects.editions.enabled and Ceres.SETTINGS.card_effects.editions.colourblind.enabled and SMODS.Consumable{
    key = 'camouflage',
    set = 'Spectral',
    pos = {
        x = 1,
        y = 0,
    },
    atlas = 'spectrals',
    cost = 4,
    unlocked = true,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'sneaky_info'}
        return {vars = {G.GAME.probabilities.normal}}
    end,

    can_use = function(self, card)
        if G.hand and (#G.hand.highlighted == 1) and G.hand.highlighted[1] and (not G.hand.highlighted[1].edition) then
            return true
        else
            return false
        end
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            local over = false
            local edition = 'e_cere_sneaky'
            local sneaky_card = G.hand.highlighted[1]
            sneaky_card:set_edition(edition, true)
            card:juice_up(0.3, 0.5)
        return true end }))
    end,
}