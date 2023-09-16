
local M = {}
local opts = {
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = true,
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.5 },
                { id = "breakpoints", size = 0.25 },
                { id = "stacks", size = 0.25 },
                -- "watches",
            },
            size = 40, -- 40 columns
            position = "left",
        },
        {
            elements = {
                { id = "repl", size = 0.7 },
                { id = "watches", size = 0.5 },
                -- "console",
            },
            size = 10, -- 25% of total lines
            position = "bottom",
        },
    },
    -- where to display controls
    controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,

        -- Display controls in this element
        element = "repl",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "",
        },
    },
    floating = {
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
    }
}


M.setup = function()
    local ok, dapui = pcall(require, "dapui")
    if not ok then
        vim.notify("missing module dapui", vim.log.levels.WARN)
        return
    end

    dapui.setup(opts)
end

M.opts = opts


return M
