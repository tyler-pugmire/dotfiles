-- Pull in the wezterm API
local wezterm = require("wezterm")
local selector = require("config-selector")
local act = wezterm.action
-- local mux = wezterm.mux
-- This will hold the configuration.

local config = wezterm.config_builder()

local themes = selector.new({ title = "Color Scheme Selector", subdir = "themes" })
local opacity = selector.new({ title = "Opacity Selector", subdir = "opacity" })
local fonts = selector.new({ title = "Font Selector", subdir = "fonts" })

themes:select(config, "Catppuccin Mocha")
opacity:select(config, "Default")
fonts:select(config, "Cousine Nerd Font")

local sessionizer = wezterm.plugin.require "https://github.com/tyler-pugmire/sessionizer.wezterm"

config.front_end = "OpenGL"
config.max_fps = 144
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color" -- Set the terminal type

config.font = wezterm.font 'Cousine Nerd Font'
config.cell_width = 0.9
--config.window_background_opacity = 1.0
config.prefer_egl = true
config.font_size = 10

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

-- tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
-- config.tab_bar_at_bottom = true

-- config.inactive_pane_hsb = {
-- 	saturation = 0.0,
-- 	brightness = 1.0,
-- }

-- keymaps
config.keys = {
    { key = "9", mods = "CTRL", action = act.PaneSelect },
    { key = "L", mods = "CTRL", action = act.ShowDebugOverlay },
    {
        key = 'r',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ReloadConfiguration
    },
    {
        key = 't',
        mods = 'LEADER',
        action = act.SpawnTab 'CurrentPaneDomain',
    },
    {
        key = 'n',
        mods = 'LEADER',
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        key = 'p',
        mods = 'LEADER',
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        -- |
        key = '|',
        mods = 'LEADER|SHIFT',
        action = act.SplitPane {
            direction = 'Right',
            size = { Percent = 50 },
        },
    },
    {
        -- -
        key = '-',
        mods = 'LEADER',
        action = act.SplitPane {
            direction = 'Down',
            size = { Percent = 25 },
        },
    },
    {
        key = 'c',
        mods = 'LEADER',
        action = themes:selector_action()
    },
    {
        key = 'o',
        mods = 'LEADER',
        action = opacity:selector_action()
    },
    {
        key = 'f',
        mods = 'LEADER',
        action = fonts:selector_action()
    },
    {
        key = "s",
        mods = "LEADER",
        action = sessionizer.show
    },
    {
        key = "a",
        mods = "LEADER",
        action = sessionizer.show_active
    }
}

sessionizer.apply_to_config(config, true)
local appdata = os.getenv('LOCALAPPDATA')
local home = os.getenv('HOME')
local config_path = home .. "/.config"
sessionizer.config.paths = "G:/Github"

sessionizer.config.additional_directories = {
    appdata .. "/nvim",
    config_path .. "/wezterm"
}

sessionizer.config.on_workspace_added = function()
    themes:selector_action()
end

sessionizer.config.command_options.fd_path =
"C:\\Users\\tyler\\AppData\\Local\\Microsoft\\WinGet\\Packages\\sharkdp.fd_Microsoft.Winget.Source_8wekyb3d8bbwe\\fd-v10.2.0-x86_64-pc-windows-msvc\\fd.exe"
-- For example, changing the color scheme:
--config.color_scheme = "Cloud (terminal.sexy)"

config.window_frame = {
    font = wezterm.font({ family = "Cousine Nerd Font", weight = "Regular" }),
    active_titlebar_bg = "#0c0b0f",
    -- active_titlebar_bg = "#181616",
}

-- config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_decorations = "NONE | RESIZE"
config.default_prog = { "pwsh.exe", "-NoLogo" }
config.initial_cols = 80
-- config.window_background_image = "C:/dev/misc/berk.png"
-- config.window_background_image_hsb = {
-- 	brightness = 0.1,
-- }

-- wezterm.on("gui-startup", function(cmd)
-- 	local args = {}
-- 	if cmd then
-- 		args = cmd.args
-- 	end
--
-- 	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	-- window:gui_window():maximize()
-- 	-- window:gui_window():set_position(0, 0)
-- end)

-- and finally, return the configuration to wezterma

--Multiplexing
-- config.unix_domains = {
--     {
--         name = 'unix',
--     },
-- }

config.leader = {
    key = 'a',
    mods = 'CTRL',
    timeout_milliseconds = 2000,
}
config.tab_bar_at_bottom = true
config.pane_focus_follows_mouse = true
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
smart_splits.apply_to_config(config, {
    direction_keys = {
        resize = { 'h', 'j', 'k', 'l' },
        move = { 'H', 'J', 'K', 'L' }
    },
    modifiers = {
        move = 'CTRL|SHIFT',  -- modifier to use for pane movement, e.g. CTRL+h to move left
        resize = 'META|CTRL', -- modifier to use for pane resize, e.g. META+h to resize to the left
    },
})

return config
