local ok, dap = pcall(require, 'dap')
if not ok then
    vim.notify('dap module missing')
end
local M = {}

M.disconnect_dap = function()
  local has_dap, dap = pcall(require, 'dap')
  local _, dapui = pcall(require, 'dapui')
  if has_dap then
    dap.disconnect()
    dap.repl.close()
    dapui.close()
    vim.cmd('sleep 100m') -- allow cleanup
  else
    vim.notify('dap not found')
  end
end

M.dap_logpoint = function()
    vim.ui.input({ prompt = 'Logpoint message> '}, function (input)
        dap.set_breakpoint(nil,nil,input)
    end)
end

-- if there are no breakpoints in the project set a breakpoint on the current 
-- line
M.init_breakpoints = function()
    -- see https://github.com/rcarriga/nvim-dap-ui/blob/master/lua/dapui/state.lua
    -- for a reference to access dap breakpoint details
    local breakpoints = require('dap.breakpoints').get() or {}
    if #breakpoints == 0 then
        dap.set_breakpoint()
    end
end

--- Load the DAP launch.json file
--- If the file does not exist, create it at the default location.
M.load_launch_json = function()
    local Path = require("plenary.path")
    local fpath = Path:new(vim.fn.getcwd() .. "/.vscode/launch.json")
    -- if path does not exist print message
    if not fpath:exists() then
        vim.notify('launch.json not found at ' .. fpath.filename)
        return
    end
    require("dap.ext.vscode").load_launchjs()
end

return M
