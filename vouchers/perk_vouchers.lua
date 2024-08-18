local perk_voucher_atlas = SMODS.Atlas{
    key = 'perk_vouchers',
    path = 'perk_vouchers.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

local card_spread = Ceres.SETTINGS.consumables.vouchers.enabled and not Ceres.SETTINGS.misc.redeem_all.enabled and SMODS.Voucher{
    key = 'card_spread',
    atlas = 'perk_vouchers',
    pos = {
        x = 0,
        y = 0,
    },
    cost = 10,
    unlocked = true,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,

    redeem = function(self)
        G.v_cere_card_spread = true
    end
}

local six_fingers = Ceres.SETTINGS.consumables.vouchers.enabled and not Ceres.SETTINGS.misc.redeem_all.enabled and SMODS.Voucher{
    key = 'six_fingers',
    atlas = 'perk_vouchers',
    pos = {
        x = 0,
        y = 1,
    },
    cost = 10,
    unlocked = true,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    requires = {
        'v_cere_card_spread',
    },

    redeem = function(self)
        G.v_cere_six_fingers = true
    end
}