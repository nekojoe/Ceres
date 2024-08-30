G.FUNCS.cere_save_config = function(e)
    Eris.FUNCS.save_config(Ceres)
end

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
			nodes = Eris.FUNCS.create_buttons(page_config, back, cere_save_config),
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
	local ref_table = Ceres.CONFIG
	local _buttons = {
    	{label = 'Jokers', toggle_ref = ref_table.jokers, button_ref = 'cere_change_page', ref_page = 'jokers_rarities'},
    	{label = 'Consumables', toggle_ref = ref_table.consumables, button_ref = 'cere_change_page', ref_page = 'consumables'},
    	{label = 'Card Modifiers', toggle_ref = ref_table.card_modifiers, button_ref = 'cere_change_page', ref_page = 'card_modifiers'},
    	{label = 'Run Modifiers', toggle_ref = ref_table.run_modifiers, button_ref = 'cere_change_page', ref_page = 'run_modifiers'},
		{label = 'Suits', toggle_ref = ref_table.suits, remove_enable = true,},
		{label = 'Miscellaneous', button_ref = 'cere_change_page', ref_page = 'misc', remove_enable = true,},
  	}
	return _buttons, false
end

Ceres.PAGE_FUNCS.jokers_rarities = function()
	local ref_table = Ceres.CONFIG.jokers
	local _buttons = {
		{label = 'Common Jokers', toggle_ref = ref_table.rarities.common, remove_enable = true,},
		{label = 'Uncommon Jokers', toggle_ref = ref_table.rarities.uncommon, remove_enable = true,},
		{label = 'Rare Jokers', toggle_ref = ref_table.rarities.rare, remove_enable = true,},
		{label = 'Legendary Jokers', toggle_ref = ref_table.rarities.legendary, remove_enable = true,},
		{label = 'Divine Jokers', toggle_ref = ref_table.rarities.divine, remove_enable = true,},

	}
	return _buttons, 'main'
end

Ceres.PAGE_FUNCS.card_modifiers = function()
	local ref_table = Ceres.CONFIG.card_modifiers
	local _buttons = {
		{label = 'Seals', toggle_ref = ref_table.seals, remove_enable = true,},
		--{label = 'Enhancements', toggle_ref = ref_table.enhancements, remove_enable = true,},
		{label = 'Editions', toggle_ref = ref_table.editions, remove_enable = true,},
	}
	return _buttons, 'main'
end

Ceres.PAGE_FUNCS.consumables = function()
	local ref_table = Ceres.CONFIG.consumables
	local _buttons = {
		{label = 'Tarot Reversals', toggle_ref = ref_table.reversed_tarots, remove_enable = true,},
		{label = 'Vouchers', toggle_ref = ref_table.vouchers, remove_enable = true,},
	}
	return _buttons, 'main'
end

Ceres.PAGE_FUNCS.run_modifiers = function()
	local ref_table = Ceres.CONFIG.run_modifiers
	local _buttons = {
		{label = 'Stakes', toggle_ref = ref_table.stakes, remove_enable = true,},
		{label = 'Blinds', toggle_ref = ref_table.blinds, remove_enable = true,},
		{label = 'Decks', toggle_ref = ref_table.decks, remove_enable = true,},
	}
	return _buttons, 'main'
end

Ceres.PAGE_FUNCS.misc = function()
	local ref_table = Ceres.CONFIG.misc
	local _buttons = {
		{label = 'Unlock All', toggle_ref = ref_table.unlock_all, remove_enable = true,},
		{label = 'Discover All', toggle_ref = ref_table.discover_all, remove_enable = true,},
	}
	return _buttons, 'main'
end