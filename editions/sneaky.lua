SMODS.Shader({key = 'sneaky', path = 'sneaky.fs'})

local sneaky = Ceres.SETTINGS.editions.enabled and Ceres.SETTINGS.editions.sneaky.enabled and SMODS.Edition({
    key = "sneaky",
    loc_txt = {
        name = "Sneaky",
        label = "Sneaky",
        text = {
            "This card cannot",
            "be {C:attention}debuffed{}",
        },
    },
    unlocked = false or Ceres.SETTINGS.misc.unlock_all.enabled,
    discovered = false or Ceres.SETTINGS.misc.discover_all.enabled, -- play a hand of 5 debuffed cards
    shader = 'sneaky',
    config = {},
    time = 0,
    in_shop = true,
    override_base_shader = true,
    ignore_shadow = true,
    weight = 10,
    extra_cost = 4,
    apply_to_float = false,

    loc_vars = function(self)
        return { vars = {}}
    end,

    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
})

local blind_debuff_card_ref = Blind.debuff_card
function Blind:debuff_card(card, from_blind)
    if card.edition and card.edition.type == 'e_cere_sneaky' then
        card.debuff = false
        return
    else
        blind_debuff_card_ref(self, card, from_blind)
    end
end