local autocmd = vim.api.nvim_create_autocmd
local M = {}

M.lazy_load_module = function()


    autocmd({"BufRead", "BufNewFile"},{
        group = vim.api.nvim_create_augroup("plantuml", {}),
        callback = function()
            plantuml_patterns = {
                "%.pu", "%.uml", "%.plantuml", "%.puml", "%.iuml"
            }

            local bufname = vim.api.nvim_buf_get_name(0)
            for _,ft in ipairs(plantuml_patterns) do
                if vim.fn.fnamemodify(bufname, ":t"):match(ft) then
                    vim.defer_fn(function()
                        require("packer").loader("plantuml-syntax")
                    end,0)
                    return
                end
            end

            firstline = vim.api.nvim_buf_get_lines(0,0,1,true)[1]
            if firestline ~= "" and firstline:match("^@startuml%s*") then
                vim.defer_fn(function()
                    require("packer").loader("plantuml-syntax")
                end,0)
            end
        end
    })
    
end

return M
