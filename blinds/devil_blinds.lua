-- blind atlas

local blind_atlas = SMODS.Atlas{
    key = 'devil_blinds',
    path = 'devil_blinds.png',
    px = 34,
    py = 34,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
}

-- custom devil blinds

local gun_devil = Ceres.SETTINGS.blinds.enabled and Ceres.SETTINGS.blinds.devil_blinds.enabled and SMODS.Blind{
    key = 'gun_devil',
    boss_colour = Ceres.C.devil,
    dollars = 10,
    mult = 2.5,
    boss = {
        showdown = true
    },
    pos = {
        x = 0,
        y = 0,
    },
    atlas = 'devil_blinds',
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    debuff = {},
    vars = {1,},

    loc_vars = function(self)
        return { vars = {G.GAME.probabilities.normal}}
    end,

    recalc_debuff = function(self, card, from_blind)
        if card.playing_card and pseudorandom(pseudoseed('gun')) < G.GAME.probabilities.normal/4 then
            return true
        else
            return false
        end
    end,
}