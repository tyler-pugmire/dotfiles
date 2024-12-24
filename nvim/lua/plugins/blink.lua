return {
    {
        'saghen/blink.cmp',
        event = {
            "LspAttach", "InsertCharPre"
        },
        version = 'v0.*',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            completion = {
                -- list = { selection = "auto_insert" },
                menu = { border = 'rounded' },
                documentation = {
                    auto_show = true,
                    window = {
                        border = "rounded",
                        direction_priority = {
                            menu_north = { 'e', 'w', 'n', 's' },
                            menu_south = { 'e', 'w', 's', 'n' },
                        },
                    }
                },
                ghost_text = { enabled = true }
            },
            signature = {
                window = {
                    border = 'rounded',
                },
                enabled = true
            },
        },
        opts_extend = { "sources.completion.enabled_providers" },
        accept = {
            auto_brackets = {
                enabled = true
            }
        },
    },
}
