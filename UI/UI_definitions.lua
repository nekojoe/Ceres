G.FUNCS.cere_change_page = function(e)
	local page_config, back = Ceres.PAGE_FUNCS[e.config.ref_page]()
	local option_box = G.OVERLAY_MENU:get_UIE_by_ID('tab_contents')
	option_box.config.object:remove()
	option_box.config.object = UIBox{
		definition = {
			n = G.UIT.ROOT,
			config = {
				emboss = 0.05,
				r = 0.1,
				minh = 8,
				minw = 7.3,
				align = 'cm',
				padding = 0.2,
				colour = G.C.BLACK,
			},
			nodes = Ceres.FUNCS.create_buttons(page_config, back),
		},
		config = {
			offset = {
				x = 0,
				y = 0,
			},
			parent = option_box,
		}
	}
	option_box.UIBox:recalculate()
end

Ceres.PAGE_FUNCS = {}

Ceres.PAGE_FUNCS.main = function()
	local ref_table = Ceres.SETTINGS
	local _buttons = {
    	{label = 'Jokers', toggle_ref = ref_table.jokers, button_ref = 'cere_change_page', ref_page = 'jokers_rarities'},
    	{label = 'Consumables', toggle_ref = ref_table.consumables, button_ref = 'cere_change_page', ref_page = 'consumables'},
    	{label = 'Card Effects', toggle_ref = ref_table.card_effects, button_ref = 'cere_change_page', ref_page = 'card_effects'},
    	{label = 'Blinds', toggle_ref = ref_table.blinds, button_ref = 'cere_change_page', ref_page = 'blinds'},
      	{label = 'Suits', toggle_ref = ref_table.suits, button_ref = 'cere_change_page', ref_page = 'suits'},
		{label = 'Miscellaneous', button_ref = 'cere_change_page', ref_page = 'misc', remove_enable = true,},
  	}
	return _buttons, false
end

Ceres.PAGE_FUNCS.jokers_rarities = function()
	local ref_table = Ceres.SETTINGS.jokers
	local _buttons = {
		{label = 'Common Jokers', toggle_ref = ref_table.rarities.common, remove_enable = true,},
		{label = 'Uncommon Jokers', toggle_ref = ref_table.rarities.uncommon, remove_enable = true,},
		{label = 'Rare Jokers', toggle_ref = ref_table.rarities.rare, remove_enable = true,},
		{label = 'Legendary Jokers', toggle_ref = ref_table.rarities.legendary, remove_enable = true,},
		{label = 'Divine Jokers', toggle_ref = ref_table.rarities.divine, remove_enable = true,},
		{label = 'Themed Jokers', toggle_ref = ref_table.themed, button_ref = 'cere_change_page', ref_page = 'jokers_themed'},

	}
	return _buttons, 'main'
end

Ceres.PAGE_FUNCS.jokers_themed = function()
	local ref_table = Ceres.SETTINGS.jokers.themed
	local _buttons = {
		{label = 'CSM Jokers', toggle_ref = ref_table.csm, remove_enable = true,},
		{label = 'Bleach Jokers', toggle_ref = ref_table.bleach, remove_enable = true,},
	}
	return _buttons, 'jokers_rarities'
end

Ceres.PAGE_FUNCS.card_effects = function()
	local ref_table = Ceres.SETTINGS.card_effects
	local _buttons = {
		{label = 'Perks', toggle_ref = ref_table.perks, remove_enable = true,},
		{label = 'Enhancements', toggle_ref = ref_table.enhancements, button_ref = 'cere_change_page', ref_page = 'enhancements'},
		{label = 'Editions', toggle_ref = ref_table.editions, button_ref = 'cere_change_page', ref_page = 'editions'},
	}
	return _buttons, 'main'
end

Ceres.PAGE_FUNCS.enhancements = function()
	local ref_table = Ceres.SETTINGS.card_effects.enhancements
	local _buttons = {
		{label = 'Illusion', toggle_ref = ref_table.illusion, remove_enable = true,},
		{label = 'Cobalt', toggle_ref = ref_table.cobalt, remove_enable = true,},
	}
	return _buttons, 'card_effects'
end

Ceres.PAGE_FUNCS.editions = function()
	local ref_table = Ceres.SETTINGS.card_effects.editions
	local _buttons = {
		{label = 'Colourblind', toggle_ref = ref_table.colourblind, remove_enable = true,},
		{label = 'Sneaky', toggle_ref = ref_table.sneaky, remove_enable = true,},
	}
	return _buttons, 'card_effects'
end

Ceres.PAGE_FUNCS.consumables = function()
	local ref_table = Ceres.SETTINGS.consumables
	local _buttons = {
		{label = 'Tarot Reversals', toggle_ref = ref_table.reversed_tarots, remove_enable = true,},
		{label = 'Vouchers', toggle_ref = ref_table.vouchers, remove_enable = true,},
	}
	return _buttons, 'main'
end

Ceres.PAGE_FUNCS.blinds = function()
	local ref_table = Ceres.SETTINGS.blinds
	local _buttons = {
		{label = 'Base Blinds', toggle_ref = ref_table.base_blinds, remove_enable = true,},
		{label = 'Devil Blinds', toggle_ref = ref_table.devil_blinds, remove_enable = true,},
	}
	return _buttons, 'main'
end

Ceres.PAGE_FUNCS.suits = function()
	local ref_table = Ceres.SETTINGS.suits
	local _buttons = {
		{label = 'Crowns', toggle_ref = ref_table.crowns, remove_enable = true,},
		{label = 'Leaves', toggle_ref = ref_table.leaves, remove_enable = true,},
		{label = 'Coins', toggle_ref = ref_table.coins, remove_enable = true,},
	}
	return _buttons, 'main'
end

Ceres.PAGE_FUNCS.misc = function()
	local ref_table = Ceres.SETTINGS.misc
	local _buttons = {
		{label = 'Unlock All', toggle_ref = ref_table.unlock_all, remove_enable = true,},
		{label = 'Discover All', toggle_ref = ref_table.discover_all, remove_enable = true,},
		{label = 'Redeem All', toggle_ref = ref_table.redeem_all, remove_enable = true},
	}
	return _buttons, 'main'
end