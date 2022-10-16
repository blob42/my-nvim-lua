local ok, dap = pcall(require, 'dap')
if not ok then
    vim.notify('dap module missing')
end
local M = {}

M.disconnect_dap = function()
  local has_dap, dap = pcall(require, 'dap')
  if has_dap then
    dap.disconnect()
    dap.repl.close()
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

return M
