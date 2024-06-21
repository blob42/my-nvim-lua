local M = {}

local opts = {
    -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
    -- it's recommended to use "telescope" or "fzf"
    picker = "select",

    lsp = {
        -- `config` is passed to `vim.lsp.start_client(config)`
        config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
            on_attach = function(client, bufnr)
                vim.keymap.set("n", "K", "<cmd> lua vim.lsp.buf.hover()<CR>", { desc = "zk lsp hover"})
                vim.keymap.set("v", "<leader>za", ":'<,'> vim.lsp.buf.range_code_action()<CR>", { desc = "zk range code action" })
            end
        },

        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
        },
    },
}

M.setup = function()
    require("zk").setup(opts)
end

return M
