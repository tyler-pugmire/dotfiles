local lazy_path = vim.fn.stdpath("data") .. "/lua/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazy_path,
    })
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup("plugins", {
    defaults = { lazy = false },
    ui = {
        size = { width = 0.7, height = 0.7 }
    }
})
