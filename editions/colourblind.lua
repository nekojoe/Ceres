local colourblind_shader = SMODS.Shader({key = 'colourblind', path = 'colourblind.fs'})
local monochrome_shader = SMODS.Shader({key = 'monochrome', path = 'monochrome.fs'})

local colourblind = Ceres.SETTINGS.editions.enabled and Ceres.SETTINGS.editions.colourblind.enabled and SMODS.Edition({
    key = "colourblind",
    loc_txt = {
        name = "Colourblind",
        label = "Colourblind",
        text = {
            "Swaps {C:blue}Chips{} and {C:red}Mult{}",
            '{C:inactive}(if possible)',
        }
    },
    unlocked = false or Ceres.SETTINGS.misc.unlock_all.enabled,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
    shader = 'colourblind',
    config = {},
    in_shop = false,
    weight = 0,
    extra_cost = 4,
    apply_to_float = false,
    loc_vars = function(self)
        return { vars = {}}
    end
})

-- i got lazy sorry, ill get this working at some point but i wanna get this released before i disappear forever (6 days)
-- local monochrome = Ceres.SETTINGS.editions.enabled and Ceres.SETTINGS.editions.colourblind.enabled and SMODS.Edition({
--     key = "monochrome",
--     loc_txt = {
--         name = "Colourblind",
--         label = "Colourblind",
--         text = {
--             'This Joker doesn\'t have',
--             '{C:red}Mult{} or {C:blue}chips{} to swap',
--         }
--     },
--     unlocked = false or Ceres.SETTINGS.misc.unlock_all.enabled,
--     discovered = false or Ceres.SETTINGS.misc.discover_all.enabled,
--     shader = 'monochrome',
--     config = {},
--     in_shop = false,
--     weight = 0,
--     extra_cost = 4,
--     apply_to_float = false,
--     loc_vars = function(self)
--         return { vars = {}}
--     end
-- })

-- making colourblind functional 

-- this is all commented out because im using MathIsFun_'s retrigger api
-- so ive had to put these functions in that
-- if i werent using that api then these would have to be uncommented

-- local eval_card_ref = eval_card
-- function eval_card(card, context)
--     local ret = eval_card_ref(card, context)
--     if card.edition and card.edition.type == 'cere_ed_colourblind' then
--         return colourblind_edition(ret, context)
--     end
--     return ret
-- end

-- local calc_joker_ref = Card.calculate_joker
-- function Card:calculate_joker(context, callback, retrigger, no_retrigger_anim)
--     local ret = calc_joker_ref(self, context, callback, retrigger, no_retrigger_anim)
--     if ret and self.edition and self.edition.type == 'cere_ed_colourblind' then
--         ret = colourblind_edition(ret, context, true)
--     end
--     return ret
-- end

-- checking if joker is compatible with edition instead
-- of having a list of compatible jokers i have to update
function colourblind_compat(joker)
    local valid = false
    for k, v in pairs(joker) do
        if type(v) == 'table' then
            valid = valid or colourblind_compat(v)
        else
            if (k == 'mult' and v ~= 0) or
            (k == 'mult_mod' and v ~= 0) or
            (k == 'x_mult' and v ~= 1) or
            (k == 'Xmult_mod' and v ~= 1) or
            (k == 'h_mult' and v ~= 0) or
            (k == 'e_mult' and v ~= 1) or
            (k == 'Emult_mod' and v ~= 1) or
            (k == 'chips' and v ~= 0) or
            (k == 'chip_mod' and v ~= 0) or
            (k == 'x_chips' and v ~= 1) or
            (k == 'Xchip_mod' and v ~= 1) or
            (k == 'h_chips' and v ~= 0) or
            (k == 'e_chips' and v ~= 1) or
            (k == 'Echip_mod' and v ~= 1) then
                valid = true
            end
        end
    end
    return valid
end

-- fuck me this code is horrible
function colourblind_edition(ret, context, joker)
    local new_ret = {}
    local removed = {
        'mult',
        'mult_mod',
        'x_mult',
        'Xmult_mod',
        'h_mult',
        'e_mult',
        'Emult_mod',
        'chips',
        'chip_mod',
        'x_chips',
        'Xchip_mod',
        'h_chips',
        'e_chips',
        'Echip_mod',
    }
    if joker then
        if ret.mult then
            new_ret.chips = ret.mult
        end
        if ret.mult_mod then
            new_ret.chip_mod = ret.mult_mod
        end
        if ret.x_mult then
            new_ret.x_chips = ret.x_mult
        end
        if ret.Xmult_mod then
            new_ret.Xchip_mod = ret.Xmult_mod
        end
        if ret.h_mult then
            new_ret.h_chips = ret.h_mult
        end
        if ret.e_mult then
            new_ret.e_chips = ret.e_mult
        end
        if ret.Emult_mod then
            new_ret.Echip_mod = ret.Emult_mod
        end
        if ret.chips then
            new_ret.mult = ret.chips
        end
        if ret.chip_mod then
            new_ret.mult_mod = ret.chip_mod
        end
        if ret.x_chips then
            new_ret.x_mult = ret.x_chips
        end
        if ret.Xchip_mod then
            new_ret.Xmult_mod = ret.Xchip_mod
        end
        if ret.h_chips then
            new_ret.h_mult = ret.h_chips
        end
        if ret.e_chips then
            new_ret.e_mult = ret.e_chips
        end
        if ret.Echip_mod then
            new_ret.Emult_mod = ret.Echip_mod
        end
        local new_ret_len = 0
        for k, v in pairs(new_ret) do
            new_ret_len = new_ret_len + 1
        end
        for k, v in pairs(ret) do
            if not new_ret[k] then
                local valid = true
                for _k, _v in pairs(removed) do
                    if k == _v then
                        valid = false
                    end
                end
                if valid then
                    new_ret[k] = v
                end
            end
        end
        if new_ret.message and new_ret_len > 0 then
            if string.find(new_ret.message, 'Mult') then
                new_ret.message = string.gsub(new_ret.message, 'Mult', '')
                new_ret.colour = G.C.CHIPS
            else
                new_ret.message = new_ret.message .. ' Mult'
                new_ret.colour = G.C.MULT
            end
        end
        return new_ret
    else
        -- playing card effects
        if ret.mult then
            new_ret.chips = ret.mult
        end
        if ret.mult_mod then
            new_ret.chip_mod = ret.mult_mod
        end
        if ret.x_mult then
            new_ret.x_chips = ret.x_mult
        end
        if ret.Xmult_mod then
            new_ret.Xchip_mod = ret.Xmult_mod
        end
        if ret.h_mult then
            new_ret.h_chips = ret.h_mult
        end
        if ret.e_mult then
            new_ret.e_chips = ret.e_mult
        end
        if ret.Emult_mod then
            new_ret.Echip_mod = ret.Emult_mod
        end
        if ret.chips then
            new_ret.mult = ret.chips
        end
        if ret.chip_mod then
            new_ret.mult_mod = ret.chip_mod
        end
        if ret.x_chips then
            new_ret.x_mult = ret.x_chips
        end
        if ret.Xchip_mod then
            new_ret.Xmult_mod = ret.Xchip_mod
        end
        if ret.h_chips then
            new_ret.h_mult = ret.h_chips
        end
        if ret.e_chips then
            new_ret.e_mult = ret.e_chips
        end
        if ret.Echip_mod then
            new_ret.Emult_mod = ret.Echip_mod
        end
        -- jokers 
        if ret.jokers then
            new_ret.jokers = {}
            if ret.jokers.mult then
                new_ret.jokers.chips = ret.jokers.mult
            end
            if ret.jokers.mult_mod then
                new_ret.jokers.chip_mod = ret.jokers.mult_mod
            end
            if ret.jokers.x_mult then
                new_ret.jokers.x_chips = ret.jokers.x_mult
            end
            if ret.jokers.Xmult_mod then
                new_ret.jokers.Xchip_mod = ret.jokers.Xmult_mod
            end
            if ret.jokers.h_mult then
                new_ret.jokers.h_chips = ret.jokers.h_mult
            end
            if ret.jokers.e_mult then
                new_ret.jokers.e_chips = ret.jokers.e_mult
            end
            if ret.jokers.Emult_mod then
                new_ret.jokers.Echip_mod = ret.jokers.Emult_mod
            end
            if ret.jokers.chips then
                new_ret.jokers.mult = ret.jokers.chips
            end
            if ret.jokers.chip_mod then
                new_ret.jokers.mult_mod = ret.jokers.chip_mod
            end
            if ret.jokers.x_chips then
                new_ret.jokers.x_mult = ret.jokers.x_chips
            end
            if ret.jokers.Xchip_mod then
                new_ret.jokers.Xmult_mod = ret.jokers.Xchip_mod
            end
            if ret.jokers.h_chips then
                new_ret.jokers.h_mult = ret.jokers.h_chips
            end
            if ret.jokers.e_chips then
                new_ret.jokers.e_mult = ret.jokers.e_chips
            end
            if ret.jokers.Echip_mod then
                new_ret.jokers.Emult_mod = ret.jokers.Echip_mod
            end
            for k, v in pairs(ret.jokers) do
                if not new_ret[k] then
                    local valid = true
                    for _k, _v in pairs(removed) do
                        if k == _v then
                            valid = false
                        end
                    end
                    if valid then
                        new_ret.jokers[k] = v
                    end
                end
            end
        end
        for k, v in pairs(ret) do
            if not new_ret[k] then
                local valid = true
                for _k, _v in pairs(removed) do
                    if k == _v then
                        valid = false
                    end
                end
                if valid then
                    new_ret[k] = v
                end
            end
        end
        if new_ret.message then
            if string.find(new_ret.message, 'Mult') then
                new_ret = string.gsub(new_ret.message, 'Mult', '')
            else
                new_ret.message = new_ret.message .. ' Mult'
            end
        end
    end
    return new_ret
end