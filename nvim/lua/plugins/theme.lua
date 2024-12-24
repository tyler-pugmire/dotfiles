return {
    {
        "lmantw/themify.nvim",
        lazy = false,
        priority = 999,
        config = function()
            require('themify').setup({
                {
                    'folke/tokyonight.nvim',
                    -- after = function()
                    --     local colors = require("tokyonight.colors").setup()
                    --     vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", {
                    --         fg = colors.border_highlight,
                    --     })
                    -- end
                },
                'catppuccin/nvim',
                'default'
            })
        end
    }
}
