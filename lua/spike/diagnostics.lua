local M = {}

M.shown = true

-- toggle diagnostics with show/hide
M.toggle = function()
    if M.shown then
        M.shown = false
        return vim.diagnostic.hide()
    end


    M.shown = true
    vim.diagnostic.show()
end

local orig_diag_virt_handler = vim.diagnostic.handlers.virtual_text
local ns = vim.api.nvim_create_namespace("my_diagnostics")

local filter_diagnostics = function(diagnostics, level)
    local filtered_diag = {}
    for _, d in ipairs(diagnostics) do
        if d.severity <= level then
            table.insert(filtered_diag, 0, d)
        end
    end
    return filtered_diag
end

--NOTE:  apply diagnostics filter to current buffer / all buffers
M.set_diagnostics_level = function(level)
    -- hide all diagnostics
    vim.diagnostic.hide(nil, 0) 

    -- vim.diagnostic.reset()
    vim.diagnostic.handlers.virtual_text = {
        show = function(_, bufnr, _, opts)
            -- get all diagnostics for local buffer
            local diagnostics = vim.diagnostic.get(bufnr)
            filtered = filter_diagnostics(diagnostics, level)
            -- filter diags based on severity
            orig_diag_virt_handler.show(ns, bufnr, filtered, opts)
        end,
        hide = function(_, bufnr)
            orig_diag_virt_handler.hide(ns, bufnr)
        end
    }

    local diags = vim.diagnostic.get(0)
    if #diags > 0 then
        filtered = filter_diagnostics(diags, level)
        vim.diagnostic.show(ns, 0, filtered)
    end

end

return M
