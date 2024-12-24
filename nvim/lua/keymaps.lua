--remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>ff", ":lua require('fzf-lua').files()<CR>")
