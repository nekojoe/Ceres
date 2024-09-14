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

local all_suits = Ceres.CONFIG.card_modifiers.suits.enabled and SMODS.Suit {
    key = 'all_suits',
    card_key = 'A',
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
    hc_colour = Ceres.C.all_suits,
    lc_colour = Ceres.C.all_suits,

    in_pool = function(self, args)
        if args and args.initial_deck then
            return false
        else
            return true
        end
    end
}

local card_is_suit_ref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if self.base.suit == 'cere_all_suits' then return true end
    return card_is_suit_ref(self, suit, bypass_debuff, flush_calc)
end