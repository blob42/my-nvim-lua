local ok, terminal = pcall(require, 'nvterm.terminal')
if not ok then
    vim.notify("missing module nvterm.terminal", vim.log.levels.WARN)
    return
end
local M = {}

M.last_cmds = {}

---run cmd using builtin terminal
---@alias mode "vertical" | "horizontal" | "float"
---@param input string command to be run in term
---@param opts? { mode: mode } options
M.run_cmd = function(input, opts)
    opts = opts or { mode = "vertical" }


    if input then
        table.insert(M.last_cmds, 1, input)
        terminal.send(input, opts.mode)
        return
    end


    vim.ui.input({ prompt = "float term cmd:> "}, function(linput)
        table.insert(M.last_cmds, 1, linput)
        terminal.send(linput, opts.mode)
    end)
end

M.rerun_last_cmd = function()
    P(M.last_cmds)
    if #M.last_cmds > 0 then terminal.send(M.last_cmds[1]) end
end



return M
