local present, dap = pcall(require, "dap")
if not present then
    print("nvim-dap missing !")
    return
end
local api = vim.api
local dapmode = require("spike.dap.dapmode")
local daputils = require('spike.dap.utils')
local dapui = require("dapui")

local liblldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.so"
local adapter_path = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/adapter/codelldb'

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
        daputils.register_keymaps()
    end

    dap.listeners.after['event_terminated']['blob42-dap'] = function(_, _)
        -- print("dap session ended")
        dapmode.stop()
        dapui.close()
        daputils.unregister_keymaps()
    end
    dap.listeners.after['event_exited']['blob42-dap'] = function(_, _)
        -- print("dap session ended")
        dapmode.stop()
        dapui.close()
        daputils.unregister_keymaps()
    end
end

function M.go_debug()
    local ok, gdap = pcall(require, "go.dap")
    if ok then gdap.run() end
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

            command = adapter_path,
            args = {"--liblldb", liblldb_path,"--port", "${port}"},
        }
    }


    -- NOTE: if compilation is done in diffferent folder then debugging workind
    -- dir (like using symlinked folder when building) source maps are needed 
    --  "sourceMap": { "/build/time/source/path" : "/current/source/path" }
    dap.configurations.c = {
        {
            -- If you get an "Operation not permitted" error using this, try disabling YAMA:
            --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
            name = "Attach to process",
            type = 'codelldb-c',  -- Adjust this to match your adapter name (`dap.adapters.<name>`)
            request = 'attach',
            pid = require('dap.utils').pick_process,
            args = {},
        },
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

    dap.configurations.go ={
        {
            name       = "Debug current package" ,
            type       = "go",
            request    = "launch" ,
            mode       = "debug" ,
            remotePath = "" ,
            port       = 38697,
            host       = " 127.0.0.1" ,
            program    = " ${fileDirname}" ,
            env        = {
            },
            args       = {" daemon" },
            cwd        = " ${workspaceFolder}" ,
            envFile    = " ${workspaceFolder}/.env"
        },
        {
            name       = "Attach main" ,
            type       = "go" ,
            request    = "attach" ,
            mode       = "debug" ,
            remotePath = "" ,
            port       = 38697,
            host       = " 127.0.0.1" ,
            program    = "${workspaceFolder}/main.go" ,
            env        = {},
            args       = {},
            cwd        = "${workspaceFolder}" ,
            processId  = "" ,
            envFile    = "${workspaceFolder}/.env" ,
            buildFlags = ""
        },
        {
            name = "Launch file",
            type = "go",
            request = "launch",
            mode = "debug",
            program = "${file}"
        },
        {
            name = "Attach process",
            type = "go",  -- Adjust this to match your adapter name (`dap.adapters.<name>`)
            request = "attach",
            mode = "local",
            processId = require('dap.utils').pick_process,
            args = {},
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
