local ok, grapple = pcall(require, 'grapple')
if not ok then
    vim.notify("missing module grapple", vim.log.levels.WARN)
    return
end

local M = {}

local config = {
    -- Your configuration goes here
    -- Leave empty to use the default configuration
    -- Please see the Configuration section below for more information
    scope = "git",
    log_level = "warn",
}

M.setup = function()
    grapple.setup(config)
end


return M
