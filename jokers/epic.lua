-- atlas for epic jokers

local epic_joker_atlas = SMODS.Atlas{
    key = 'epic_jokers',
    path = 'epic_jokers.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

-- custom epic jokers

local ben = Ceres.SETTINGS.jokers.enabled and Ceres.SETTINGS.jokers.rarities.epic.enabled and SMODS.Joker{
    key = 'ben',
    name = 'Ben',
    rarity = 3,
    unlocked = false or Ceres.SETTINGS.misc.unlock_all.enabled,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    pos = {
        x = 1,
        y = 0,
    },
    cost = 11,
    config = {
        odds = 1,
    },
    atlas = 'epic_jokers',
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,

    loc_vars = function(self, info_queue, card)
        local var = 0
        if G.GAME and G.GAME.chips and G.GAME.blind and G.GAME.blind.chips and G.GAME.blind.chips ~= 0 then
            local chips = G.GAME.chips or 0
            local blind_chips = G.GAME.blind.chips or 0
            local percent = (G.GAME.chips / G.GAME.blind.chips) * 100 or 0
            var = Ceres.FUNCS.round(tonumber(percent), 0)
            if var > 100 then
                var = 100
            end
        end
        return {vars = {var}}
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('ben') < G.GAME.chips / G.GAME.blind.chips then
                G.GAME.chips = G.GAME.blind.chips
                G.hand_text_area.game_chips:juice_up()
                G.E_MANAGER:add_event(Event({func = function()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('voice9')
                        return true
                    end
                }))
                return {
                    message = 'Yes!',
                    repetitions = 0,
                    colour = G.C.GREEN,
                }
            else
                G.E_MANAGER:add_event(Event({func = function()
                        play_sound('voice2')
                        return true
                    end
                }))
                return {
                    message = 'No!',
                    repetitions = 0,
                    colour = G.C.RED,
                }
            end
        end
    end,
}