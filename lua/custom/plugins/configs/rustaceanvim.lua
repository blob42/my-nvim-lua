local M = {}

local config = {
    server = {
        cmd = {"run-rust-analyzer"},
        auto_attach = false,
        on_attach = function(client, bufnr)
            require('navigator.lspclient.mapping').setup({client=client, bufnr=bufnr}) -- setup navigator keymaps here,
            require("navigator.dochighlight").documentHighlight(bufnr)
            require('navigator.codeAction').code_action_prompt(bufnr)
            -- otherwise, you can define your own commands to call navigator functions
        end
    }
}

function M.setup()
    vim.g.rustaceanvim = config
end

return M
