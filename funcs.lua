local is_suit_ref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    local ret = is_suit_ref(self, suit, bypass_debuff, flush_calc)
    if self.base.suit == 'cere_Nothings' then
        return false
    end
    return ret
end