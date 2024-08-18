local perk_atlas = SMODS.Atlas{
    key = 'perks',
    path = 'perks.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

SMODS.Perk = SMODS.Enhancement:extend {
	set = 'Perk',
	class_prefix = 'pk',
	atlas = 'perks',
	pos = { x = 0, y = 0 },
	required_params = {
		'key',
	},
	-- always overwrite the base card
	replace_base_card = true,
	-- always score the card
	always_scores = true,
	-- card has no suit or rank
    no_suit = true,
    no_rank = true,

	register = function(self)
		self.config = self.config or {}
		SMODS.Perk.super.register(self)
	end,

	inject = function(self)
		G.P_CENTERS[self.key] = self
		SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self)
	end,
}

-- allows only 1 perk card to be selected per hand, but it is selected a 6th card
-- so can still play 5 card hands
local card_click_ref = Card.click
function Card:click()
	if not G.hand then return card_click_ref(self) end
	if self.ability.set == 'Perk' then
		if self.area ~= G.hand then return card_click_ref(self) end
		if self.area and self.area:can_highlight(self) and self.area == G.hand then
			if self.highlighted ~= true then
				local can_select = true
				for _, card in pairs(G.hand.highlighted) do
					if card.ability and card.ability.set == 'Perk' then
						can_select = false
					end
				end
				if can_select then
					if self.ability.cost and G.GAME.dollars < self.ability.cost then
        				self:perk_alert('cost')
					else
						if G.v_cere_six_fingers or Ceres.SETTINGS.misc.redeem_all.enabled then
							G.hand.config.highlighted_limit = 6
						end
						self.area:add_to_highlighted(self)
					end
				else
					self:perk_alert('max')
				end
			else
				G.hand.config.highlighted_limit = 5
				self.area:remove_from_highlighted(self)
				play_sound('cardSlide2', nil, 0.3)
			end
		end
	else
		G.hand.config.highlighted_limit = 5
		for _, card in pairs(G.hand.highlighted) do
			if card.ability and card.ability.set == 'Perk' and (G.v_cere_six_fingers or Ceres.SETTINGS.misc.redeem_all.enabled) then
				G.hand.config.highlighted_limit = 6
			end
		end
		card_click_ref(self)
	end
	if #G.hand.highlighted == 6 then
		G.play.T.w = 6.3*G.CARD_W
	else
		G.play.T.w = 5.3*G.CARD_W
	end
end

-- function for displaying alerts
function Card:perk_alert(alert)
	local area = G.hand
	local text = alert == 'max' and 'Perk card already selected!' or alert == 'cost' and 'Not enough money!'
	attention_text({
		scale = 0.9, text = text, hold = 0.9, align = 'cm',
		cover = area, cover_padding = 0.1, cover_colour = adjust_alpha(G.C.BLACK, 0.7)
	})
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1.3, blockable = false, blocking = false,
		func = function()
			for _, card in pairs(G.hand.cards) do
				card.greyed = false
			end
			return true
		end
	}))
	for _, card in pairs(G.hand.cards) do
		card.greyed = true
	end
	
	self:juice_up(0.3, 0.2)
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
		play_sound('tarot2', 0.76, 0.4)
		return true 
	end}))
	play_sound('tarot2', 1, 0.4)
end

-- function for nice dissolving of cards
function Card:perk_dissolve()
    local dissolve_time = 0.7
    self.dissolve = 0
    self.dissolve_colours = {G.C.BLACK, G.C.ORANGE, G.C.RED, G.C.GOLD, G.C.JOKER_GREY}
    self:juice_up()
    local childParts = Particles(0, 0, 0,0, {
        timer_type = 'TOTAL',
        timer = 0.01*dissolve_time,
        scale = 0.1,
        speed = 2,
        lifespan = 0.7*dissolve_time,
        attach = self,
        colours = self.dissolve_colours,
        fill = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.7*dissolve_time,
        func = (function() childParts:fade(0.3*dissolve_time) return true end)
    }))
	G.E_MANAGER:add_event(Event({
		blockable = false,
		func = (function()
				play_sound('whoosh2', math.random()*0.2 + 0.9,0.5)
				play_sound('crumple'..math.random(1, 5), math.random()*0.2 + 0.9,0.5)
			return true end)
	}))
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        blockable = false,
        ref_table = self,
        ref_value = 'dissolve',
        ease_to = 1,
        delay =  1*dissolve_time,
        func = (function(t) return t end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.051*dissolve_time,
    }))
end

-- displays the perk cards effect when it triggers
function Card:perk_message()
	if not (self.ability and self.ability.set == 'Perk') then return end
	local message = self.ability.message or {}
	local text = message.text or 'Perk!'
	local colour = message.colour or G.C.GREEN
    local percent = (0.9 + 0.2*math.random())
    local volume = 1
    local config = {
        scale = 0.7,
        type = 'fall'
    }
    local delay = 0.75 * 1.25
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
            align = cm,
            major = self,
            offset = {x = 0, y = 0}
        })
        play_sound(sound, 0.8+percent*0.2, volume)
        if not extra or not extra.no_juice then
            self:juice_up(0.6, 0.1)
            G.ROOM.jiggle = G.ROOM.jiggle + 0.7
        end
		self:perk_dissolve()
        return true
        end
    }))
end

-- necessary for burnt cards returning to deck and any temp jokers getting destroyed

G.FUNCS.draw_from_burnt_to_discard = function()
    local burnt_count = #G.burnt.cards
    for i=1, burnt_count do
        G.burnt.cards[i].burnt = false
        G.burnt.cards[i]:start_materialize(nil, true, 0.00001)
        draw_card(G.burnt,G.discard, i*100/burnt_count,'down', nil, nil, 0.07)
    end
end

G.TEMP = {
	jokers = {},
	hand_size = 0,
}

local end_round_ref = end_round
function end_round()
	-- remove any temp jokers
    for _, card in pairs(G.TEMP.jokers) do
        card:start_dissolve()
    end
	-- set hand size back to normal
	G.hand.config.real_card_limit = (G.hand.config.real_card_limit or G.hand.config.card_limit) - G.TEMP.hand_size
    G.hand.config.card_limit = math.max(0, G.hand.config.real_card_limit)
	G.TEMP.hand_size = 0
    end_round_ref()
end

-- perk card objects

-- blueprint
local prototype = Ceres.SETTINGS.card_effects.perks.enabled and SMODS.Perk{
    key = 'prototype',
	atlas = 'perks',
    pos = {
        x = 0,
        y = 0,
    },
    config = {
		message = {
			text = 'Blueprint!',
			colour = G.C.SECONDARY_SET.Spectral,
		},
	},

	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_perk_card'), get_badge_colour('cere_perk_card'), nil, 1.2)
    end,

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
		if context.cardarea == G.play then
			if card and not card.burnt then
				card.burnt = true
				card:perk_message()
				G.GAME.joker_buffer = G.GAME.joker_buffer + 1
				G.E_MANAGER:add_event(Event({
					func = function()
						local _card = create_card('Joker', G.jokers, nil, 0, nil, nil, 'j_blueprint', 'ben')
						play_sound('tarot1')
						_card:set_eternal(true)
						G.jokers:emplace(_card)
						_card:start_materialize()
						G.GAME.joker_buffer = 0
						table.insert(G.TEMP.jokers, _card)
						return true
					end
				}))
			end
		end
    end,
}

-- brainstorm
local dirty_napkin = Ceres.SETTINGS.card_effects.perks.enabled and SMODS.Perk{
    key = 'dirty_napkin',
	atlas = 'perks',
    pos = {
        x = 1,
        y = 0,
    },
    config = {
		message = {
			text = 'Brainstorm!',
			colour = G.C.RED,
		},
	},

	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_perk_card'), get_badge_colour('cere_perk_card'), nil, 1.2)
    end,

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
		if context.cardarea == G.play then
			if card and not card.burnt then
				card.burnt = true
				card:perk_message()
				G.GAME.joker_buffer = G.GAME.joker_buffer + 1
				G.E_MANAGER:add_event(Event({
					func = function()
						local _card = create_card('Joker', G.jokers, nil, 0, nil, nil, 'j_brainstorm', 'ben')
						play_sound('tarot1')
						_card:set_eternal(true)
						G.jokers:emplace(_card)
						_card:start_materialize()
						G.GAME.joker_buffer = 0
						table.insert(G.TEMP.jokers, _card)
						return true
					end
				}))
			end
		end
    end,
}

-- coupon tag
local reward_card = Ceres.SETTINGS.card_effects.perks.enabled and SMODS.Perk{
	key = 'reward_card',
	atlas = 'perks',
	pos = {
		x = 2,
		y = 0,
	},
	config = {
		cost = 6,
		message = {
			text = 'Tag!',
			colour = G.C.GREEN,
		},
	},

	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_perk_card'), get_badge_colour('cere_perk_card'), nil, 1.2)
    end,

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
		if context.cardarea == G.play then
			if card and not card.burnt then
				card.burnt = true
				card:perk_message()
				ease_dollars(-self.config.cost)
				G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - self.config.cost
				G.E_MANAGER:add_event(Event({func = (function()
					G.GAME.dollar_buffer = 0
					add_tag(Tag('tag_coupon'))
					play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
					return true 
				end)}))
			end
		end
    end,
}

-- uncommon tag
local business_card = Ceres.SETTINGS.card_effects.perks.enabled and SMODS.Perk{
    key = 'business_card',
	atlas = 'perks',
    pos = {
        x = 3,
        y = 0,
    },
	config = {
		cost = 3,
		message = {
			text = 'Tag!',
			colour = G.C.GREEN,
		},
	},

    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_perk_card'), get_badge_colour('cere_perk_card'), nil, 1.2)
    end,

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
		if context.cardarea == G.play then
			if card and not card.burnt then
				card.burnt = true
				card:perk_message()
				ease_dollars(-self.config.cost)
				G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - self.config.cost
				G.E_MANAGER:add_event(Event({func = (function()
					G.GAME.dollar_buffer = 0
					add_tag(Tag('tag_uncommon'))
					play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
					return true 
				end)}))
			end
		end
    end,
}

-- card removal and gain enhanced card
local trading_card = Ceres.SETTINGS.card_effects.perks.enabled and SMODS.Perk{
    key = 'trading_card',
	atlas = 'perks',
    pos = {
        x = 4,
        y = 0,
    },
	config = {
		extra = 0,
		message = {
			text = 'Trade!',
			colour = G.C.RED,
		},
	},

	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_perk_card'), get_badge_colour('cere_perk_card'), nil, 1.2)
    end,

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {set = 'Other', key = 'burn_info'}
    end,

    calculate = function(self, context, effect, card)
		if context.cardarea == G.play then
			if card and not card.burnt then
				card.burnt = true
				card:perk_message()
				for _, _card in pairs(context.scoring_hand) do
					if not _card.traded and _card.ability.name ~= 'pk_cere_trading_card' then
						_card.traded = true
						card.ability.extra = card.ability.extra + 1
					end
				end
				G.E_MANAGER:add_event(Event({func = (function()
					for i = 1, card.ability.extra do
						perk_trade_cards()
					end
					card.ability.extra = 0
					return true 
				end)}))
			end
		end
    end,
}

-- function for generating enhanced card for trading card

function perk_trade_cards()
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

-- gain hand size
local plus_two = Ceres.SETTINGS.card_effects.perks.enabled and SMODS.Perk{
    key = 'plus_two',
	atlas = 'perks',
    pos = {
        x = 0,
        y = 1,
    },
	config = {
		extra = 2,
		message = {
			text = '+2!',
			colour = G.C.RED,
		},
	},

	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_perk_card'), get_badge_colour('cere_perk_card'), nil, 1.2)
    end,

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {set = 'Other', key = 'burn_info'}
		return {
			vars = {
				self.config.extra,
			},
		}
    end,

    calculate = function(self, context, effect, card)
		if context.cardarea == G.play then
			if card and not card.burnt then
				card.burnt = true
				card:perk_message()
				G.hand.config.real_card_limit = (G.hand.config.real_card_limit or G.hand.config.card_limit) + card.ability.extra
        		G.hand.config.card_limit = math.max(0, G.hand.config.real_card_limit)
				G.TEMP.hand_size = G.TEMP.hand_size + card.ability.extra
			end
		end
    end,
}