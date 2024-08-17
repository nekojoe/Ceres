local planet_atlas = SMODS.Atlas{
    key = 'planets',
    path = 'planets.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

local charon = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.themed.enabled and Ceres.SETTINGS.jokers.themed.bleach.enabled and SMODS.Consumable{
    key = 'charon',
    set = 'Planet',
    config = {
        hand_type = 'cere_six_of_a_kind',
        softlock = true
    },
    pos = {
        x = 0,
        y = 0,
    },
    atlas = 'planets',
    unlocked = false or Ceres.SETTINGS.misc.unlock_all.enabled,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,

    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_moon'), get_badge_colour('cere_moon'), nil, 1.2)
    end,

    loc_vars = function(self, info_queue, card)
        local vars = {G.GAME.hands['cere_six_of_a_kind'].level, G.GAME.hands['cere_six_of_a_kind'].l_mult, G.GAME.hands['cere_six_of_a_kind'].l_chips}
        local level = G.GAME.hands['cere_six_of_a_kind'].level or 1
        local col = G.C.HAND_LEVELS[math.min(level, 7)]
        if level == 1 then
            col = G.C.UI.TEXT_DARK
        end
        vars.colours = {col}
        return {vars = vars}
    end,

    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname='Six of a Kind',chips = G.GAME.hands['cere_six_of_a_kind'].chips, mult = G.GAME.hands['cere_six_of_a_kind'].mult, level=G.GAME.hands['cere_six_of_a_kind'].level})
        level_up_hand(card, 'cere_six_of_a_kind')
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

local ganymede = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.themed.enabled and Ceres.SETTINGS.jokers.themed.bleach.enabled and SMODS.Consumable{
    key = 'ganymede',
    set = 'Planet',
    config = {
        hand_type = 'cere_flush_six',
        softlock = true
    },
    pos = {
        x = 1,
        y = 0,
    },
    atlas = 'planets',
    unlocked = false or Ceres.SETTINGS.misc.unlock_all.enabled,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,

    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_moon'), get_badge_colour('cere_moon'), nil, 1.2)
    end,

    loc_vars = function(self, info_queue, card)
        local vars = {G.GAME.hands['cere_flush_six'].level, G.GAME.hands['cere_flush_six'].l_mult, G.GAME.hands['cere_flush_six'].l_chips}
        local level = G.GAME.hands['cere_flush_six'].level or 1
        local col = G.C.HAND_LEVELS[math.min(level, 7)]
        if level == 1 then
            col = G.C.UI.TEXT_DARK
        end
        vars.colours = {col}
        return {vars = vars}
    end,

    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname='Flush Six',chips = G.GAME.hands['cere_flush_six'].chips, mult = G.GAME.hands['cere_flush_six'].mult, level=G.GAME.hands['cere_flush_six'].level})
        level_up_hand(card, 'cere_flush_six')
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}