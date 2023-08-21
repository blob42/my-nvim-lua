---@diagnostic disable: redefined-local
local ok, dap = pcall(require, 'dap')
if not ok then
    vim.notify('dap module missing')
end
local api = vim.api
local keymap_restore = {}

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

M.register_keymaps = function()
    for _, buf in pairs(api.nvim_list_bufs()) do
        local keymaps = api.nvim_buf_get_keymap(buf, 'n')
        for _, keymap in pairs(keymaps) do
            if keymap.lhs == "K" then
                table.insert(keymap_restore, keymap)
                api.nvim_buf_del_keymap(buf, 'n', 'K')
            end
        end
    end
    api.nvim_set_keymap(
    'n', 'K', '<cmd>lua require("dap.ui.widgets").hover()<CR>',
    {silent = true}
    )
end

M.unregister_keymaps = function()

    for _,keymap in pairs(keymap_restore) do
        api.nvim_buf_set_keymap(
        keymap.buffer,
        keymap.mode,
        keymap.lhs,
        keymap.rhs,
        { silent = keymap.silent == 1 }
        )
    end
    keymap_restore = {}
end

return M
