local dapmode = require("spike.dapmode")

local M = {}

local function register_listeners()
  local present, dap = pcall(require, "dap")
  if not present then
    print("nvim-dap missing !")
    return
  end

  dap.listeners.before['event_initialized']['spike-dap'] = function(session, body)
    dapmode.start()
  end

  dap.listeners.after['event_terminated']['spike-dap'] = function(session, body)
    -- print("dap session ended")
    dapmode.stop()
  end
end

function M.go_debug()
  local present, gdap = pcall(require, "go.dap")
  if not present then return end
  gdap.run()
end

function M.setup()
  dapmode.setup({})
  register_listeners()
end

return M
