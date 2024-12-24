local pokemon_list = {
    "greninja",
    "bulbasaur",
    "charizard",
    "treecko",
    "rayquaza",
    "garchomp",
    "cyndaquil",
    "lugia",
    "mewtwo"
}
math.randomseed(os.time())
local pokemon = pokemon_list[math.random(#pokemon_list)]

return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    build = "cargo install krabby",
    opts = {
        bigfile = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        dashboard = {
            enabled = true,
            sections = {
                { section = "header" },
                { section = "keys",   gap = 1, padding = 1 },
                { section = "startup" },
                {
                    section = "terminal",
                    cmd = "krabby name " .. pokemon .. " --no-title",
                    --padding = { 100, 10 },
                    align = "center",
                    pane = 2,
                    height = 30,
                },
            },
        },
        input = {
            enabled = true,
            position = "float",
            border = "rounded",
            title_pos = "center",
        },
        indent = { enabled = true },
        -- terminal = { enabled = true },
    },
    keys = {
        { "<leader>ps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Bufer" },
        -- { "<leader>pp", function() Snacks.toggle.profiler() end,            desc = "Toggle Profiler" },
        -- { "<leader>ph", function() Snacks.toggle.profiler_highlights() end, desc = "Toggle Profiler Highlights" },
        { "<leader>gg", function() Snacks.lazygit() end,          desc = "Lazygit" },
    }
}
