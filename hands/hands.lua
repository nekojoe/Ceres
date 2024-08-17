local six_of_a_kind = SMODS.PokerHand{
    key = 'six_of_a_kind',
    chips = 200,
    mult = 20,
    l_chips = 60,
    l_mult = 5,
    example = {
        { 'S_8', true },
        { 'S_8', true },
        { 'H_8', true },
        { 'C_8', true },
        { 'C_8', true },
        { 'D_8', true },
    },
    visible = false,
    above_hand = 'Flush Five',

    evaluate = function(parts, hand)
        local ret = {}
        for _, card in pairs(hand) do
            if #ret == 0 then
                ret[1] = card
            else
                if card:get_id() == ret[1]:get_id() then
                    ret[#ret+1] = card
                end
            end
        end
        return #ret == 6 and {ret} or {}
    end,
}

local flush_six = SMODS.PokerHand{
    key = 'flush_six',
    chips = 240,
    mult = 24,
    l_chips = 80,
    l_mult = 6,
    example = {
        { 'S_J', true },
        { 'S_J', true },
        { 'S_J', true },
        { 'S_J', true },
        { 'S_J', true },
        { 'S_J', true },
    },
    visible = false,
    above_hand = 'Flush Five',

    evaluate = function(parts, hand)
        local ret = {}
        for _, card in pairs(hand) do
            if #ret == 0 then
                ret[1] = card
            else
                if card:get_id() == ret[1]:get_id() and card:is_suit(ret[1].base.suit, true, true) then
                    ret[#ret+1] = card
                end
            end
        end
        return #ret == 6 and {ret} or {}
    end,
}