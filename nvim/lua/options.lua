vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.mouse          = 'a'
vim.opt.showmode       = false
vim.opt.undofile       = true
vim.opt.ignorecase     = true
vim.opt.smartcase      = true
vim.opt.updatetime     = 250
vim.opt.timeoutlen     = 300
vim.opt.splitright     = true
vim.opt.splitbelow     = true
vim.opt.list           = true
vim.opt.listchars      = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.cursorline     = true
vim.opt.shiftwidth     = 4
vim.opt.tabstop        = 4
vim.opt.expandtab      = true

vim.opt.termguicolors  = true

vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)
