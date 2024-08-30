local colourblind_shader = SMODS.Shader({key = 'colourblind', path = 'colourblind.fs'})
local sneaky_shader = SMODS.Shader({key = 'sneaky', path = 'sneaky.fs'})
local mint_shader = SMODS.Shader({key = 'mint', path = 'mint.fs'})

local colourblind = Ceres.CONFIG.card_modifiers.editions.enabled and SMODS.Edition({
    key = "colourblind",
    unlocked = false or Ceres.CONFIG.misc.unlock_all.enabled,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    shader = 'colourblind',
    config = {
        x_mult = 1.5,
        eris_x_chips = 1.5,
    },
    in_shop = true,
    weight = 20,
    extra_cost = 4,
    apply_to_float = false,
    loc_vars = function(self)
        return { vars = {
            self.config.eris_x_chips,
            self.config.x_mult,
        }}
    end,

    get_weight = function(self)
        return (G.GAME.cere_edition_rate or 1) * self.weight
    end
})

local sneaky = Ceres.CONFIG.card_modifiers.editions.enabled and SMODS.Edition({
    key = "sneaky",
    unlocked = false or Ceres.CONFIG.misc.unlock_all.enabled,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled, -- play a hand of 5 debuffed cards
    shader = 'sneaky',
    config = {},
    time = 0,
    in_shop = true,
    override_base_shader = true,
    ignore_shadow = true,
    weight = 20,
    extra_cost = 4,
    apply_to_float = false,

    loc_vars = function(self)
        return { vars = {}}
    end,

    get_weight = function(self)
        return (G.GAME.cere_edition_rate or 1) * self.weight
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

local mint = Ceres.CONFIG.card_modifiers.editions.enabled and SMODS.Edition({
    key = "mint_condition",
    unlocked = false or Ceres.CONFIG.misc.unlock_all.enabled,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    shader = 'mint',
    config = { eris_x_dollars = 1.5 },
    in_shop = true,
    weight = 10,
    extra_cost = 4,
    apply_to_float = false,
    loc_vars = function(self)
        return { vars = {self.config.eris_x_dollars}}
    end,

    get_weight = function(self)
        return (G.GAME.cere_edition_rate or 1) * self.weight
    end
})

-- uh

local mint_atlas = SMODS.Atlas{
    key = 'mint',
    path = 'mint_condition.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

local glass = nil

local card_draw_ref = Card.draw
function Card:draw(layer)
    if not glass then
        glass = Sprite(0, 0, G.CARD_W, G.CARD_H, mint_atlas, {x=0,y=0})
    end
    card_draw_ref(self, layer)
    if self.sprite_facing == 'front' and self.edition and self.edition.type == 'cere_mint_condition' then
        glass.role.draw_major = self
        glass:draw_shader('dissolve', nil, nil, nil, self.children.center)
    end
end