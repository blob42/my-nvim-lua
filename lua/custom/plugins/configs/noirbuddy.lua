local ok, noirbuddy = pcall(require, "noirbuddy")
if not ok then
    P("NO NOIR BUDDY")
    vim.notify("missing module noirbuddy", vim.log.levels.WARN)
    return
end

local M = {}
local g_config = require("core.utils").load_config()

M.palette = {
        primary = "#ef9d9d",
        secondary = "#a1b1e3",
        background = "#282936",
        noir_0 = "#e9e9f4",
        noir_1 = "#f1f2f8",
        noir_2 = "#e4e4f1",
        loir_3 = "#d4d4dd",
        loir_4 = "#cdcdd7",
        loir_5 = "#b9b9c7",
        noir_6 = "#a8a8b9",
        noir_7 = "#757b9a",
        noir_8 = "#353848",
        noir_9 = "#222430",

}

local config = {
    preset = 'slate',
    colors = M.palette
}



M.setup = function()
    local base46 = require'base46'
    noirbuddy.setup(config)
    base46.load_highlight "defaults"
    base46.load_highlight "statusline"
    base46.load_highlight(base46.turn_str_to_color(g_config.ui.hl_add))
    require('theme.highlights').setup()
end

return M
