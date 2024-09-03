local suit_atlas = SMODS.Atlas{
    key = 'suits',
    path = 'suits.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

local ui_atlas = SMODS.Atlas{
    key = 'ui_icons',
    path = 'ui_icons.png',
    px = 18,
    py = 18,
    atlas_table = 'ASSET_ATLAS',
}

local nothings = Ceres.CONFIG.suits.enabled and SMODS.Suit {
    key = 'Nothings',
    card_key = 'N',
    hc_atlas = 'suits',
    lc_atlas = 'suits',
    hc_ui_atlas = 'ui_icons',
    lc_ui_atlas = 'ui_icons',
    pos = {
        y = 0
    },
    ui_pos = {
        x = 0,
        y = 0,
    },
    hc_colour = HEX('464646'),
    lc_colour = HEX('464646'),

    in_pool = function(self, args)
        return false
    end
}