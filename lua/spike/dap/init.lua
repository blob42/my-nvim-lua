local present, dap = pcall(require, "dap")
if not present then
    print("nvim-dap missing !")
    return
end
local dapmode = require("spike.dap.dapmode")
local daputils = require('spike.dap.utils')
local dapui = require("dapui")

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
    dap.listeners.before['event_initialized']['spike-dap'] = function(_, _)
        dapmode.start()
        dapui.open()
    end

    dap.listeners.after['event_terminated']['spike-dap'] = function(_, _)
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
