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

local filter_diagnostics = function(diagnostics, level, bufnr)
    assert(bufnr, "bufnr is required")
    local filtered_diag = {}
    if level == -1 then return {} end
    if not diagnostics then return {} end
    for _, d in ipairs(diagnostics) do
        if d.severity <= level then
            -- check if diagnostic line is out of range in current buffer
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
            if d.end_lnum <= #lines then
                table.insert(filtered_diag, 1, d)
            end
        end
    end
    return filtered_diag
end

--NOTE:  apply diagnostics filter to current buffer / all buffers
M.set_diagnostics_level = function(level)


    vim.diagnostic.handlers.virtual_text = {
        show = function(_, bufnr, _, opts)
            -- get all diagnostics for local buffer
            local diagnostics = vim.diagnostic.get(bufnr)
            local filtered = filter_diagnostics(diagnostics, level, bufnr)
            -- filter diags based on severity
            orig_diag_virt_handler.show(ns, bufnr, filtered, opts)
        end,
        hide = function(_, bufnr)
            orig_diag_virt_handler.hide(ns, bufnr)
        end
    }

    local bufnr = vim.api.nvim_get_current_buf()
    -- hide all diagnostics
    vim.diagnostic.hide(nil, bufnr)

    local diags = vim.diagnostic.get(bufnr)
    if #diags > 0 then
        local filtered = filter_diagnostics(diags, level, bufnr)
        vim.diagnostic.show(ns, bufnr, filtered)
    end

end

return M
