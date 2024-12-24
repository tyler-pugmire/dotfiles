return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = true,
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "javascript", "html", "cpp", "c_sharp", "rust", "cmake" },
                sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
                ignore_install = {},
                auto_install = false
            })
        end
    },
    {
        "nvim-treesitter/playground"
    }
}
