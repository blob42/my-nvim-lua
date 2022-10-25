local M = {}


local on_attach = function(bufnr)
    require("custom.utils").set_plugin_mappings "gitsigns"
end

M.setup = function()
    local present, gitsigns = pcall(require, "gitsigns")

    if not present then
        return
    end

    require("base46").load_highlight "git"

    local options = {
        signs = {
            add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
            change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
            delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
            topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
            changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
        },
        on_attach = on_attach,
        
    }

    gitsigns.setup(options)
end

return M
