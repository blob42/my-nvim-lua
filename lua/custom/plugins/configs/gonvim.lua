local dapui_cfg = require("custom.plugins.configs.dapui").opts

local M = {}

local config = {
  -- verbose = true,
  run_in_floaterm = false,
  icons = false,
  -- icons = { breakpoint = "🧘", currentpos = "🏃" }, -- set to false to disable
  lsp_cfg = false, -- handled instead by navigator 
  lsp_keymaps = false, -- use navigator
  -- lsp_diag_signs = false,
  lsp_codelens = false, -- use navigator
  textobjects = true,
  dap_debug_keymap = false,
  dap_debug_gui = dapui_cfg,
  -- dap_debug_vt = false,
  log_path = vim.fn.stdpath('cache') .. '/gonvim.log',
  lsp_inlay_hints = {
      enable = false,
      -- only_current_line = true,

  }
}

function M.setup()
    local ok, null_ls = pcall(require, 'null-ls')
    if not ok then 
        vim.notify("missing module null-ls", vim.log.levels.WARN)
    end

    require("go").setup(config)
    local gotest = require('go.null_ls').gotest()
    local gotest_codeaction = require("go.null_ls").gotest_action()
    null_ls.register(gotest)
    null_ls.register(gotest_codeaction)
end

return M
