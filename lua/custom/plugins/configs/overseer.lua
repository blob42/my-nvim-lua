local ok, overseer = pcall(require, 'overseer')
if not ok then 
    vim.notify("missing module overseer", vim.log.levels.WARN)
    return
end

opts = {

}

local M = {}

M.setup = function()
    require("overseer").setup(opts)
end

return M
