local M = {}


local opts = {
    defaults = {
        enable_highlighting = true,
        inline_highlighting = true,
        hl_groups = {
            insertion = "DiffAdd",
            deletion = "DiffDelete",
            change = "DiffChange",
        },
    },

    debug = false,
    commands = {
        Norm = { cmd = "norm" },
        Reg = {
            cmd = "norm",
            -- This will transform ":5Reg a" into ":norm 5@a"
            args = function(opts)
                return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args
            end,
            range = "",
        },
    }
}

function M.get_cmds()
    local cmds = {}
    for cmd, _ in pairs(opts.commands) do
        table.insert(cmds, cmd)
    end

    return cmds
end

function M.setup()
    require("live-command").setup(opts)
end

return M
