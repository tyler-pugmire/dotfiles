local servers = {
    clangd = {
        -- filetypes = { ".cpp", ".c", "h", ".hpp" }
    },
    --gopls = {},
    pyright = {},
    rust_analyzer = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnotics = { disable = { 'missing-fields' } }
        },
    },
    cmake = {}
}

local function on_attach(client, buffer)
    if client.supports_method('textDocument/formatting', 0) then
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = buffer,
            callback = function()
                vim.lsp.buf.format({ bufnr = buffer, id = client.id })
            end
        })
    end

    if client.server_capabilities.documentSymbolProvider then
        local navic = require('nvim-navic')
        navic.attach(client, buffer)
    end


    local group = vim.api.nvim_create_augroup("clangd_no_inlay_hints_in_insert", { clear = true })

    vim.keymap.set("n", "<leader>lh", function()
        if require("clangd_extensions.inlay_hints").toggle_inlay_hints() then
            vim.api.nvim_create_autocmd("InsertEnter", {
                group = group,
                buffer = buffer,
                callback = require("clangd_extensions.inlay_hints").disable_inlay_hints
            })
            vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
                group = group,
                buffer = buffer,
                callback = require("clangd_extensions.inlay_hints").set_inlay_hints
            })
        else
            vim.api.nvim_clear_autocmds({ group = group, buffer = buffer })
        end
    end, { buffer = buffer, desc = "[l]sp [h]ints toggle" })

    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = buffer, desc = desc })
    end
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
    nmap('K', function()
        vim.lsp.buf.hover({ border = 'rounded' })
    end, 'Hover Documentation')
    nmap('<C-k>', function()
        vim.lsp.buf.signature_help({ border = 'rounded' })
    end, 'Signature Documentation')
    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    -- nmap('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')
    -- nmap('<leader>ws', require('fzf-lua').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
end

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
            'saghen/blink.cmp',
            "utilyre/barbecue.nvim"
        },
        config = function()
            require('neodev').setup()
            local capabilities = vim.lsp.protocol.make_client_capabilities();
            capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

            local mason_lspconfig = require 'mason-lspconfig'
            mason_lspconfig.setup {
                ensure_installed = vim.tbl_keys(servers),
                automatic_installation = false
            }

            mason_lspconfig.setup_handlers {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    }
                end
            }
        end
    },
    {
        "p00f/clangd_extensions.nvim",
        ft = { "c", "cpp", "h", "hpp" },
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>gh", "<CMD>ClangdSwitchSourceHeader<CR>", mode = { "n" } }
        },
        config = function()
            require("clangd_extensions").setup()
        end
    }
}
