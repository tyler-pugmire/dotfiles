return {
    {
        "utilyre/barbecue.nvim",
        version = "*",
        lazy = false,
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
        config = function()
            require('barbecue').setup({
                create_autocmd = false
            })

            vim.api.nvim_create_autocmd({
                "WinScrolled",
                "BufWinEnter",
                "CursorHold",
                "InsertLeave"
            }, {
                group = vim.api.nvim_create_augroup("barbecue.updater", {}),
                callback = function()
                    require("barbecue.ui").update();
                end
            })
        end
    }
}
