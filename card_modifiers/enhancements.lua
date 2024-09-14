local enhancement_atlas = SMODS.Atlas{
    key = 'enhancement_atlas',
    path = 'enhancements.png',
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}

local sketch = Ceres.CONFIG.card_modifiers.enhancements.enabled and SMODS.Enhancement{
    key = 'sketch',
    pos = {
        x = 0,
        y = 0,
    },
    atlas = 'enhancement_atlas',
    config = {},

    loc_vars = function(self, info_queue)
        return {vars = {}}
    end,

    calculate = function(self, card, context, effect)
    end
}

local postcard = Ceres.CONFIG.card_modifiers.enhancements.enabled and SMODS.Enhancement{
    key = 'postcard',
    pos = {
        x = 1,
        y = 0,
    },
    atlas = 'enhancement_atlas',
    config = {
        extra = 3,
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card and card.ability and card.ability.extra or self.config.extra}}
    end,

    calculate = function(self, card, context, effect)
        if context.pre_discard then
            local discard = false
            for _, _card in pairs(G.hand.highlighted) do
                if _card == card then
                    discard = true
                end
            end
            if discard then
                ease_dollars(card.ability.extra)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('$')..card.ability.extra, colour = G.C.MONEY})
            end
        end
    end
}

local platinum = Ceres.CONFIG.card_modifiers.enhancements.enabled and SMODS.Enhancement{
    key = 'platinum',
    pos = {
        x = 2,
        y = 0,
    },
    atlas = 'enhancement_atlas',
    config = {},

    loc_vars = function(self, info_queue)
        return {vars = {}}
    end,

    calculate = function(self, card, context, effect)
    end
}

local stained_glass = Ceres.CONFIG.card_modifiers.enhancements.enabled and SMODS.Enhancement{
    key = 'stained_glass',
    pos = {
        x = 3,
        y = 0,
    },
    atlas = 'enhancement_atlas',
    config = {},

    loc_vars = function(self, info_queue)
        return {vars = {}}
    end,

    calculate = function(self, card, context, effect)
    end
}