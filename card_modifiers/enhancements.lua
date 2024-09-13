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
    config = {},

    loc_vars = function(self, info_queue)
        return {vars = {}}
    end,

    calculate = function(self, card, context, effect)
    end
}

local titanium = Ceres.CONFIG.card_modifiers.enhancements.enabled and SMODS.Enhancement{
    key = 'titanium',
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