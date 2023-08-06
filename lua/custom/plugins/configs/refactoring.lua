local ok, refactoring = pcall(require, 'refactoring')
if not ok then 
    vim.notify("missing module refactoring", vim.log.levels.WARN)
    return
end

local M = {}


local config = {
-- prompt for return type
    prompt_func_return_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
    },
    -- prompt for function parameters
    prompt_func_param_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
    },
    printf_statements = {},
    print_var_statements = {},
}

M.setup = function()
    refactoring.setup(config)
    -- require("telescope").load_extension("refactoring")
end



return M
