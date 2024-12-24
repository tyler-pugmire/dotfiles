return {
    {
        "nvim-lua/plenary.nvim",
        cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" },
        lazy = true
    },
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = true,
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
    },
    {
        "rktjmp/lush.nvim",
        lazy = true
    },
    { "xiyaowong/transparent.nvim", lazy = false },
    { "meznaric/key-analyzer.nvim", opts = {} },
    -- {
    --     'mrjones2014/smart-splits.nvim',
    --     lazy = false,
    --     config = function()
    --         vim.keymap.set('n', '<CA-h>', require('smart-splits').resize_left)
    --         vim.keymap.set('n', '<CA-j>', require('smart-splits').resize_down)
    --         vim.keymap.set('n', '<CA-k>', require('smart-splits').resize_up)
    --         vim.keymap.set('n', '<CA-l>', require('smart-splits').resize_right)
    --         -- moving between splits
    --         vim.keymap.set('n', '<C-H>', require('smart-splits').move_cursor_left)
    --         vim.keymap.set('n', '<C-J>', require('smart-splits').move_cursor_down)
    --         vim.keymap.set('n', '<C-K>', require('smart-splits').move_cursor_up)
    --         vim.keymap.set('n', '<C-L>', require('smart-splits').move_cursor_right)
    --         vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
    --         -- swapping buffers between windows
    --         vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
    --         vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
    --         vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
    --         vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
    --     end
    -- }
}
