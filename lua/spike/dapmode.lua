local libmodal = require "libmodal"

M = {}
M.layer = nil

local config = {
  mappings = {
    n =
    { 
      t = { rhs = '<cmd> DapToggleBreakpoint<CR>', desc= "[dap] toggle breakpoint" },
      T = {
        rhs = function()
              require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
        desc = "[dap] conditional breakpoint",
      },
      c = {
        rhs = function()
          require('dap').continue()
        end,
        desc = "[dap] continue"
      },
      n = {
        rhs = function()
          require('dap').step_over()
        end,
        desc = "[dap] step over"
      },
      s = {
        rhs = function()
          require('dap').step_into()
        end,
        desc = '[dap] step into'
      },
      o = {
        rhs = function()
          require('dap').step_out()
        end,
        desc = '[dap] step out'
      },
      r = {
        rhs = function()
          require('go.dap').run()
        end,
        desc = '[dap] run'
      },
      S = {
        rhs = function()
          require('go.dap').stop()
        end,
        desc = "[dap] stop"
      },
      C = {
        rhs = function()
          require('dap').run_to_cursor()
        end,
        desc = "[dap] run to curosr"
      },
      W = {
        rhs = function()
            require("dapui").float_element('watches')
        end,
        desc = '[dapui] float watches'
      },
      B = {
        rhs = function()
            require("dapui").float_element('breakpoints')
        end,
        desc = '[dapui] float breakpoints'
      },
      O = {
        rhs = function()
            require("dapui").float_element('scopes')
        end,
        desc = '[dapui] float scopes'
      },
      ["Q"] = {
        rhs = function()
          M.layer:exit()
        end,
        desc = "[dap] exit dap mode"
      } 
    }
  }
}


function M.start()
  if M.layer == nil then
    M.layer = libmodal.layer.new(config.mappings)
  end
  M.layer:enter()
end

function M.stop()
  if M.layer ~= nil then M.layer:exit() end
end

function M.setup (opts)
  config = vim.tbl_deep_extend("force", config, opts or {})
end

function M.is_active()
  if M.layer == nil then return false end
  return M.layer:is_active()
end


-- layer:map('n', '<Esc>', function() layer:exit() end, {})
-- --
-- layer:enter()
--

return M
