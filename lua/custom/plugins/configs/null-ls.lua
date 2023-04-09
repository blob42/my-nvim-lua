local ok, null_ls = pcall(require, 'null-ls')
if not ok then 
    vim.notify("missing module null-ls", vim.log.levels.WARN)
    return
end
local vim, api = vim, vim.api

local M = {}

M.default_sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.checkmake,
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.formatting.fish_indent,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.formatting.autoflake,
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
}

M.extra_sources = {
    null_ls.builtins.diagnostics.jshint,
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.pydocstyle,
    -- null_ls.builtins.diagnostics.pylint,


    -- golang revive (manually enabled with shortcut from mappings)
    -- null_ls.builtins.diagnostics.revive,
}

M.config = {
    debounce = 1000,
    default_timeout = 5000,
    sources = M.default_sources,
    on_attach = function(client, bufnr)
        require('plugins.configs.lspconfig').on_attach(client, bufnr)
        local util = require('navigator.util')
        local log = util.log
        local trace = util.trace
        require('navigator.lspclient.highlight').add_highlight()
        require('navigator.lspclient.highlight').diagnositc_config_sign()
        api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        require('navigator.lspclient.mapping').setup({
            client = client,
            bufnr = bufnr,
        })
        if client.server_capabilities.documentHighlightProvider == true then
            trace('attaching doc highlight: ', bufnr, client.name)
            vim.defer_fn(function()
                require('navigator.dochighlight').documentHighlight(bufnr)
            end, 50) -- allow a bit time for it to settle down
        else
            log('skip doc highlight: ', bufnr, client.name)
        end
        require('navigator.lspclient.lspkind').init()
    end
}

M.setup = function()
    null_ls.setup(M.config)   
end


return M
