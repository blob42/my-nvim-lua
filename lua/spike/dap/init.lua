local present, dap = pcall(require, "dap")
if not present then
    print("nvim-dap missing !")
    return
end
local api = vim.api
local dapmode = require("spike.dap.dapmode")
local daputils = require('spike.dap.utils')
local dapui = require("dapui")
local keymap_restore = {}

local liblldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.so"

local M = {}
M.signs = {
    DapBreakpoint = {
        icon = '',
        hl   = 'DapBreakpoint'
    },
    DapLogPoint = {
        icon = 'ﳁ',
        hl = 'DapLogPoint',
    },
    DapStopped = {
        icon = '',
        hl = 'DapStopped',
    },
    DapBreakpointCondition = {
        icon = '',
        hl = 'DapBreakpointCondition',
    },
    DapBreakpointRejected = {
        icon = '',
        hl = 'DapBreakpointRejected'
    }
}


local function register_listeners()
    dap.listeners.before['event_initialized']['blob42-dap'] = function(_, _)
        dapmode.start()
        dapui.open()
    end

    dap.listeners.after['event_terminated']['blob42-dap'] = function(_, _)
        -- print("dap session ended")
        dapmode.stop()
        dapui.close()
    end
end

function M.go_debug()
    local present, gdap = pcall(require, "go.dap")
    if not present then return end
    gdap.run()
end

local function set_signs()
    for sign, conf in pairs(M.signs) do
        vim.fn.sign_define(sign, {text = conf.icon, texthl=conf.hl})
    end
end

local function dap_setup()
    -- set default externalTerminal
    dap.defaults.fallback.external_terminal = {
        command = "/usr/bin/alacritty",
        args = {
            "--class",
            "dap",
            "-o",
            "window.dimensions.lines=30",
            "-o",
            "window.dimensions.columns=100",
            "-e"
        }
    }

    -- Map K to hover while session is active https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#map-k-to-hover-while-session-is-active
    dap.listeners.after['event_initialized']['blob42-dap'] = function() -- takes session,body
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

    dap.listeners.after['event_terminated']['blob42-dap'] = function()
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

    -- dap.adapters["codelldb-c"] = {
    --     type = 'server',
    --     host = "127.0.0.1",
    --     port = "${port}",
    --     executable = {
    --         command = "/home/spike/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",
    --         args = {"--liblldb", liblldb_path,"--port", "${port}"},
    --     }
    -- }

    dap.adapters["codelldb-c"] = {
        type = 'server',
        host = "127.0.0.1",
        port = "${port}",
        executable = {
            command = "/home/spike/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",
            args = {"--liblldb", liblldb_path,"--port", "${port}"},
        }
    }


    dap.configurations.c = {
        {
            name = "Launch file",
            type = "codelldb-c",
            request = "launch",
            program = function()
                return vim.fn.input("path to exe: ", vim.fn.getcwd() .. '/',  'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            -- runInTerminal = true, -- use external terminal
        },

        {
            name = "Launch file (custom args)",
            type = "codelldb-c",
            request = "launch",
            program = function()
                -- local custom_args = vim.ui.input({ prompt = "custom args: "}
                return vim.fn.input("path to exe: ", vim.fn.getcwd() .. '/',  'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = function()
                local args = vim.fn.input("args: ", "")
                -- return a table of args
                return vim.split(args, "%s+")
            end
            -- runInTerminal = true,
        },

    }

end

function M.prepare_launch()
end

function M.setup()
    dap_setup()
    dapmode.setup({})
    register_listeners()
    set_signs()
    daputils.load_launch_json()
end


return M
