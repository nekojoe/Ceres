local reversed_tarot_atlas = SMODS.Atlas{
    key = 'reversed_tarots',
    path = 'reversed_tarots.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

local set_usage_ref = set_consumeable_usage
function set_consumeable_usage(card)
    if card.config.center.set == 'reversed_tarot' then
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    G.GAME.last_reversed_tarot = card.config.center_key
                    return true
                end
            }))
                return true
            end
        }))
    end
    set_usage_ref(card)
end

local reversed_tarot = ((Ceres.CONFIG.consumables.enabled and Ceres.CONFIG.consumables.reversed_tarots.enabled) or
(Ceres.CONFIG.suits.enabled or Ceres.CONFIG.card_modifiers.enhancements.enabled)) and SMODS.ConsumableType{
    key = 'reversed_tarot',
    primary_colour = G.C.SET.Tarot,
    secondary_colour = G.C.SECONDARY_SET.Tarot,
    loc_txt = {
        name = 'Tarot Reversal',
        collection = 'Tarot Reversals',
        undiscovered = {
            name = 'Not Discovered',
            text = {
                'Purchase or use',
                'this card in an',
                'unseeded run to',
                'learn what it does',
            },
        },
    },
    collection_rows = { 5, 6 },

    inject_card = function(self, center)
        SMODS.insert_pool(G.P_CENTER_POOLS['Tarot'], center)
    end
}

local undiscoverd_atlas = SMODS.UndiscoveredSprite{
    atlas = 'reversed_tarots',
    key = 'reversed_tarot',
    pos = {
        x = 2,
        y = 2,
    },
}

local reversed_fool = Ceres.CONFIG.consumables.enabled and Ceres.CONFIG.consumables.reversed_tarots.enabled and SMODS.Consumable{
    key = 'reversed_fool',
    set = 'reversed_tarot',
    config = {},
    atlas = 'reversed_tarots',
    pos = {
        x = 0,
        y = 0,
    },
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,

    loc_vars = function(self, info_queue, card)
        local fool_c = G.GAME.last_reversed_tarot and G.P_CENTERS[G.GAME.last_reversed_tarot] or nil
        local last_reversed_tarot = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
        local colour = (not fool_c or fool_c.name == 'The Fool') and G.C.RED or G.C.GREEN
        local main_end = {
            {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
                {n=G.UIT.C, config={align = "m", colour = colour, r = 0.05, padding = 0.05}, nodes={
                    {n=G.UIT.T, config={text = ' '..last_reversed_tarot..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                }}
            }}
        }
        if not (not fool_c or fool_c.name == 'The Fool Reversal') then
            info_queue[#info_queue+1] = fool_c
        end
        return {main_end = main_end}
    end,

    can_use = function(self, card)
        if (#G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables) 
        and G.GAME.last_reversed_tarot and G.GAME.last_reversed_tarot ~= 'c_cere_reversed_fool' then
            return true
        else
            return false
        end
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = create_card('reversed_tarot', G.consumeables, nil, nil, nil, nil, G.GAME.last_reversed_tarot, 'reversed_fool')
                card:add_to_deck()
                G.consumeables:emplace(card)
                card:juice_up(0.3, 0.5)
            end
            return true end }))
        delay(0.6)
    end
}

local reversed_magician = Ceres.CONFIG.card_modifiers.enhancements.enabled and SMODS.Consumable{
    key = 'reversed_magician',
    set = 'reversed_tarot',
    config = {
        mod_conv = 'm_cere_illusion',
        max_highlighted = 2,
    },
    atlas = 'reversed_tarots',
    pos = {
        x = 1,
        y = 0,
    },
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.mod_conv]
        return {
            vars = {
                self.config.max_highlighted,
                'Illusion Card',
            },
        }
    end
}

local reversed_lovers = Ceres.CONFIG.consumables.enabled and Ceres.CONFIG.consumables.reversed_tarots.enabled and SMODS.Consumable{
    key = 'reversed_lovers',
    set = 'reversed_tarot',
    config = {
        max_highlighted = 3,
    },
    atlas = 'reversed_tarots',
    pos = {
        x = 6,
        y = 0,
    },
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,

    loc_vars = function(self, info_queue)
        return {
            vars = {
                self.config.max_highlighted,
            },
        }
    end,

    use = function(self, card, area, copier)
        local suit = pseudorandom_element(SMODS.Suits, pseudoseed('lovers')).key
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[i]:change_suit(suit);return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
    end
}

local reversed_chariot = Ceres.CONFIG.card_modifiers.enhancements.enabled and SMODS.Consumable{
    key = 'reversed_chariot',
    set = 'reversed_tarot',
    config = {
        mod_conv = 'm_cere_cobalt',
        max_highlighted = 1,
    },
    atlas = 'reversed_tarots',
    pos = {
        x = 7,
        y = 0,
    },
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.mod_conv]
        return {
            vars = {
                self.config.max_highlighted,
                'Cobalt Card',
            },
        }
    end
}

local reversed_hanged_man = Ceres.CONFIG.consumables.enabled and Ceres.CONFIG.consumables.reversed_tarots.enabled and SMODS.Consumable{
    key = 'reversed_hanged_man',
    set = 'reversed_tarot',
    config = {
        max_highlighted = 1,
    },
    atlas = 'reversed_tarots',
    pos = {
        x = 2,
        y = 1,
    },
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,

    loc_vars = function(self, info_queue)
        return {
            vars = {
                self.config.max_highlighted,
            },
        }
    end,

    use = function(self, card, area, copier)
        local _card = copy_card(G.hand.highlighted[1], nil, nil, 1)
        _card:add_to_deck()
        G.deck.config.card_limit = G.deck.config.card_limit + 1
        table.insert(G.playing_cards, _card)
        G.deck:emplace(_card)
        G.deck:shuffle('hung')
        _card.states.visible = nil
        G.E_MANAGER:add_event(Event({
            func = function()
                _card:start_materialize()
                return true
            end
        }))
    end
}

local reversed_strength = Ceres.CONFIG.consumables.enabled and Ceres.CONFIG.consumables.reversed_tarots.enabled and SMODS.Consumable{
    key = 'reversed_strength',
    set = 'reversed_tarot',
    config = {
        max_highlighted = 2,
    },
    atlas = 'reversed_tarots',
    pos = {
        x = 1,
        y = 1,
    },
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,

    loc_vars = function(self)
        return {
            vars = {
                self.config.max_highlighted,
            },
        }
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                local card = G.hand.highlighted[i]
                local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
                local rank_suffix = card.base.id == 2 and 14 or math.max(card.base.id-1, 2)
                if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                elseif rank_suffix == 10 then rank_suffix = 'T'
                elseif rank_suffix == 11 then rank_suffix = 'J'
                elseif rank_suffix == 12 then rank_suffix = 'Q'
                elseif rank_suffix == 13 then rank_suffix = 'K'
                elseif rank_suffix == 14 then rank_suffix = 'A'
                end
                card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
            return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
    end,
}

local reversed_star = Ceres.CONFIG.suits.enabled and SMODS.Consumable{
    key = 'reversed_star',
    set = 'reversed_tarot',
    config = {
        suit_conv = 'cere_Coins',
        max_highlighted = 3,
    },
    atlas = 'reversed_tarots',
    pos = {
        x = 7,
        y = 1,
    },
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,

    loc_vars = function(self)
        return {
            vars = {
                self.config.max_highlighted,
                localize(self.config.suit_conv, 'suits_plural'),
                colours = { G.C.SUITS[self.config.suit_conv] },
            },
        }
    end
}

local reversed_sun = Ceres.CONFIG.suits.enabled and SMODS.Consumable{
    key = 'reversed_sun',
    set = 'reversed_tarot',
    config = {
        suit_conv = 'cere_Leaves',
        max_highlighted = 3,
    },
    atlas = 'reversed_tarots',
    pos = {
        x = 9,
        y = 1,
    },
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,

    loc_vars = function(self)
        return {
            vars = {
                self.config.max_highlighted,
                localize(self.config.suit_conv, 'suits_plural'),
                colours = { G.C.SUITS[self.config.suit_conv] },
            },
        }
    end
}

local reversed_world = Ceres.CONFIG.suits.enabled and SMODS.Consumable{
    key = 'reversed_world',
    set = 'reversed_tarot',
    config = {
        suit_conv = 'cere_Crowns',
        max_highlighted = 3,
    },
    atlas = 'reversed_tarots',
    pos = {
        x = 1,
        y = 2,
    },
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,

    loc_vars = function(self)
        return {
            vars = {
                self.config.max_highlighted,
                localize(self.config.suit_conv, 'suits_plural'),
                colours = { G.C.SUITS[self.config.suit_conv] },
            },
        }
    end
}