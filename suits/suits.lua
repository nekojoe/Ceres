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

local leaves = Ceres.SETTINGS.suits.enabled and Ceres.SETTINGS.suits.leaves.enabled and SMODS.Suit {
    key = 'Leaves',
    card_key = 'LEAVES',
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
    hc_colour = HEX('419947'),
    lc_colour = HEX('419947'),
}

local crowns = Ceres.SETTINGS.suits.enabled and Ceres.SETTINGS.suits.crowns.enabled and SMODS.Suit {
    key = 'Crowns',
    card_key = 'CROWNS',
    hc_atlas = 'suits',
    lc_atlas = 'suits',
    hc_ui_atlas = 'ui_icons',
    lc_ui_atlas = 'ui_icons',
    pos = {
        y = 1,
    },
    ui_pos = {
        x = 1,
        y = 0,
    },
    hc_colour = HEX('424DC4'),
    lc_colour = HEX('424DC4'),
}

local coins = Ceres.SETTINGS.suits.enabled and Ceres.SETTINGS.suits.coins.enabled and SMODS.Suit {
    key = 'Coins',
    card_key = 'COINS',
    hc_atlas = 'suits',
    lc_atlas = 'suits',
    hc_ui_atlas = 'ui_icons',
    lc_ui_atlas = 'ui_icons',
    pos = {
        y = 2,
    },
    ui_pos = {
        x = 2,
        y = 0,
    },
    hc_colour = HEX('DAA520'),
    lc_colour = HEX('DAA520'),
}