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
  -- dap_debug_gui = false,
  -- dap_debug_vt = false,
}

function M.setup()
  require("go").setup(config)
end

return M
