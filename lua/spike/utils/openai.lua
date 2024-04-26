-- openai api helpers
local M = {}

M.load_api_key = function(provider)
    local openai_api_key_path = vim.fn.expand('$XDG_CONFIG_HOME') .. '/openai/token-' .. provider
    local openai_api_key = vim.fn.readfile(openai_api_key_path, '', 1)
    vim.fn.setenv('OPENAI_API_KEY', openai_api_key[1])
end

return M
