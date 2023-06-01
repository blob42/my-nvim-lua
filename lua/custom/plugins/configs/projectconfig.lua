local ok, pconfig = pcall(require, "nvim-projectconfig")
if not ok then
    vim.notify("missing module nvim-projectconfig", vim.log.levels.WARN)
    return false
end

local M = {}

local config = {
    project_dir = "~/.config/nvim-project-confs/", -- trailing slash important
    selint = false,
}

M.setup = function()
    pconfig.setup(config)
end

return M
