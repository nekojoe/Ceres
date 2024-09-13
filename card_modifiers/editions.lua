local colourblind_shader = SMODS.Shader({key = 'colourblind', path = 'colourblind.fs'})
local sneaky_shader = SMODS.Shader({key = 'sneaky', path = 'sneaky.fs'})
local mint_shader = SMODS.Shader({key = 'mint', path = 'mint.fs'})

local colourblind = Ceres.CONFIG.card_modifiers.editions.enabled and SMODS.Edition({
    key = "colourblind",
    unlocked = false or Ceres.CONFIG.misc.unlock_all.enabled,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    shader = 'colourblind',
    config = {
        mult = -10,
        cere_x_chips = 2,
    },
    in_shop = true,
    weight = 3,
    extra_cost = 5,
    apply_to_float = false,
    loc_vars = function(self, info_queue, card)
        return { vars = {
            (card and card.edition and card.edition.mult) or self.config.mult,
            (card and card.edition and card.edition.cere_x_chips) or self.config.cere_x_chips,
        }}
    end,

    get_weight = function(self)
        return (G.GAME.cere_edition_rate or 1) * self.weight
    end
})

local sneaky = Ceres.CONFIG.card_modifiers.editions.enabled and SMODS.Edition({
    key = "sneaky",
    unlocked = false or Ceres.CONFIG.misc.unlock_all.enabled,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    shader = 'sneaky',
    config = {
        extra = 4,
        odds = 3
    },
    in_shop = true,
    weight = 3,
    extra_cost = 5,
    apply_to_float = false,
    loc_vars = function(self, info_queue, card)
        return { vars = {
            (card and card.edition and card.edition.odds) or self.config.odds,
            (card and card.edition and card.edition.extra) or self.config.extra,
        }}
    end,

    calculate = function(self, card, context)
        if pseudorandom(pseudoseed('sneaky')) < G.GAME.probabilities.normal/3 then
            return {
                Xmult_mod = 4,
                colour = G.C.RED,
                card = card
            }
        end
    end,

    get_weight = function(self)
        return (G.GAME.cere_edition_rate or 1) * self.weight
    end,
})

local mint = Ceres.CONFIG.card_modifiers.editions.enabled and SMODS.Edition({
    key = "mint_condition",
    unlocked = false or Ceres.CONFIG.misc.unlock_all.enabled,
    discovered = false or Ceres.CONFIG.misc.discover_all.enabled,
    shader = 'mint',
    config = { p_dollars = 3},
    in_shop = true,
    weight = 10,
    extra_cost = 4,
    apply_to_float = false,
    loc_vars = function(self, info_queue, card)
        return { vars = {(card and card.edition and card.edition.p_dollars) or self.config.p_dollars}}
    end,

    get_weight = function(self)
        return (G.GAME.cere_edition_rate or 1) * self.weight
    end
})

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