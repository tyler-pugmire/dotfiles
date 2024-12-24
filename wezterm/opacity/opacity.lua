local M = {}

M.init = function()
    local opacity = {
        { label = "Default", value = 0.7 },
        { label = "Off",     value = 1.0 },
    }
    for i = 10, 90, 10 do
        table.insert(opacity, { label = string.format("%2d%%", i), value = i / 100 })
    end
    return opacity
end

M.activate = function(config, _, value)
    config.window_background_opacity = value
end

return M
