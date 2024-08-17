local blind_atlas = SMODS.Atlas{
    key = 'base_blinds',
    path = 'base_blinds.png',
    px = 34,
    py = 34,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
}

-- custom blinds

local new_moon = Ceres.SETTINGS.blinds.enabled and Ceres.SETTINGS.blinds.base_blinds.enabled and SMODS.Blind{
    key = 'new_moon',
    boss_colour = Ceres.C.new_moon,
    dollars = 10, -- default is 5, default showdown is 8
    mult = 2,
    boss = {
        showdown = true
    },
    pos = {
        x = 0,
        y = 0,
    },
    atlas = 'base_blinds',
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    debuff = {
        suit = 'Spades',
        value = 'Ace',
    },
}

local the_bill = Ceres.SETTINGS.suits.enabled and Ceres.SETTINGS.suits.coins.enabled and SMODS.Blind{
    key = 'the_bill',
    boss_colour = Ceres.C.the_bill,
    dollars = 5, -- default is 5, default showdown is 8
    mult = 2,
    boss = {
        min = 1
    },
    pos = {
        x = 0,
        y = 1,
    },
    atlas = 'base_blinds',
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    debuff = {
        suit = 'cere_Coins',
    },
}

local the_fall = Ceres.SETTINGS.suits.enabled and Ceres.SETTINGS.suits.leaves.enabled and SMODS.Blind{
    key = 'the_fall',
    boss_colour = Ceres.C.the_fall,
    dollars = 5, -- default is 5, default showdown is 8
    mult = 2,
    boss = {
        min = 1
    },
    pos = {
        x = 0,
        y = 2,
    },
    atlas = 'base_blinds',
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    debuff = {
        suit = 'cere_Leaves',
    },
}

local the_french = Ceres.SETTINGS.suits.enabled and Ceres.SETTINGS.suits.crowns.enabled and SMODS.Blind{
    key = 'the_french',
    boss_colour = Ceres.C.the_french,
    dollars = 5, -- default is 5, default showdown is 8
    mult = 2,
    boss = {
        min = 1
    },
    pos = {
        x = 0,
        y = 3,
    },
    atlas = 'base_blinds',
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    debuff = {
        suit = 'cere_Crowns',
    },
}


-- updating new moon blind when cards in deck are modified

local new_moon_updated = false

local check_for_unlock_ref = check_for_unlock
function check_for_unlock(args)
    check_for_unlock_ref(args)
    if G.playing_cards and not new_moon_updated then
        new_moon_updated = true
        update_new_moon()
    end
end

function update_new_moon()
    local suits = {}
    local values = {}
    for k, v in pairs(G.playing_cards) do
        if v.ability.effect ~= 'Stone Card' then
            suits[v.base.suit] = (suits[v.base.suit] or 0) + 1
            values[v.base.value] = (values[v.base.value] or 0) + 1
        end
    end
    local common_suit = {'Spades', 0}
    local common_value = {'Ace', 0}
    for k, v in pairs(suits) do
        if v > common_suit[2] then
            common_suit = {k, v}
        end
    end
    for k, v in pairs(values) do
        if v > common_value[2] then
            common_value = {k, v}
        end
    end
    new_moon.debuff = {
        suit = common_suit[1],
        value = common_value[1],
    }
    new_moon_updated = false
end