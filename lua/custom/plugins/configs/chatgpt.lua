local ok, chatgpt = pcall(require, 'chatgpt')
if not ok then 
    vim.notify("missing module chatgpt", vim.log.levels.WARN)
    return
end

local M = {}

local config = {
    loading_text = "loading",
}

M.setup = function()
    chatgpt.setup({})
end


return M
