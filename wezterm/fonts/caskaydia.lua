local wezterm = require("wezterm")
local M = {}
local name = "CaskaydiaCove NF"

M.init = function()
    return name
end

M.activate = function(config)
    config.font = wezterm.font(name)
    config.font_size = 10.0
    --config.line_height = 1.2
    config.harfbuzz_features = { "calt", "ss01" }
    config.font_rules = {
        {
            intensity = "Normal",
            italic = false,
            font = wezterm.font("CaskaydiaCove NF", { weight = "Regular" }),
        },
        {
            intensity = "Normal",
            italic = true,
            font = wezterm.font("CaskaydiaCove NF", { weight = "Regular", style = "Italic" }),
        },
    }
end

return M
