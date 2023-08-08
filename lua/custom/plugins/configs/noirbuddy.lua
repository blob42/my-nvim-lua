local ok, noirbuddy = pcall(require, "noirbuddy")
if not ok then
    vim.notify("missing module noirbuddy", vim.log.levels.WARN)
    return
end

local M = {}

M.config = {
    preset = 'minimal',
    colors = {
        primary = '#BD93F9',
        secondary = '#92a2d4',
    },
}

M.setup = function()
    -- noirbuddy.setup(M.config)
end


return M
