return {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- event = "VeryLazy",
    config = function()
        require('harpoon'):setup()
    end,
    keys = {
        { "<leader>ha", function() require("harpoon"):list():add() end },
        { "<leader>hh", function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end },
        { "<leader>1",  function() require("harpoon"):list():select(1) end },
        { "<leader>2",  function() require("harpoon"):list():select(2) end },
        { "<leader>3",  function() require("harpoon"):list():select(3) end },
        { "<leader>4",  function() require("harpoon"):list():select(4) end },
        { "<leader>5",  function() require("harpoon"):list():select(5) end },
        { "<leader>6",  function() require("harpoon"):list():select(6) end },
        { "<leader>7",  function() require("harpoon"):list():select(7) end },
    },
    opts = {
        global_settings = {
            enter_on_sendcmd = true
        }
    }
}
