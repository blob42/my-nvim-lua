local present, navigator = pcall(require, "navigator")

if not present then
  return
end


M = {}


local config = {
  -- debug = true,
  transparency = 5,
  lsp_signature_help = true,
  default_mapping = true,

  icons = {
    icons = true, -- set to false to use system default ( if you using a terminal does not have nerd/icon)
    -- Code action
    code_action_icon = ' ', -- "",

    -- code lens
    code_lens_action_icon = '',

    -- Diagnostics
    diagnostic_head = '',   -- default diagnostic head on dialogs
    diagnostic_err =  '',    -- severity 1
    diagnostic_warn = '',   --          2
    diagnostic_info = '',   --          3
    diagnostic_hint = '',   --          4

    -- used in the diagnostics summary window
    diagnostic_head_severity_1 = '',
    diagnostic_head_severity_2 = '',
    diagnostic_head_severity_3 = 'i',
    diagnostic_head_description = ' ',
    diagnostic_virtual_text = '',
    diagnostic_file = '🚑',
    -- Values
    value_changed = '📝',
    value_definition = '🐶🍡', -- it is easier to see than 🦕
    side_panel = {
      section_separator = '',
      line_num_left = '',
      line_num_right = '',
      inner_node = '├○',
      outer_node = '╰○',
      bracket_left = '⟪',
      bracket_right = '⟫',
    },
    -- Treesitter
    match_kinds = {
      var = ' ', -- "👹", -- Vampaire
      method = 'ƒ ', --  "🍔", -- mac
      ['function'] = ' ', -- "🤣", -- Fun
      parameter = '  ', -- Pi
      associated = '🤝',
      namespace = '🚀',
      type = ' ',
      field = '🏈',
      module = '📦',
      flag = '🎏',
    },
    treesitter_defult = '🌲',
    doc_symbols = '',
  },
  lsp = {
    document_highlight = false,
    mason = true,
    format_on_save = false, -- applies to all formatting feature of neovim 
                            -- including auto-fold
    diagnostic = {
      underline = true,
      virtual_text = {
        spacing = 3,
        source = true
      }, -- show virtual for diagnostic message
      update_in_insert = false, -- update diagnostic message in insert mode
      severity_sort = { reverse = true },
    },

    -- disable_lsp = {"sqls"},

    -- disable auto start of lsp per language
    -- set global default on lspconfig (see lspconfig doc)
    -- ["lua-dev"] = {
    --   autostart = false,
    -- }
  }
}

M.setup = function()
  navigator.setup(config)
end

M.enable = function()
  local lspconfig = require("lspconfig")
  lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
      autostart = true
    }
  )
  vim.cmd[[
  LspStart
  ]]
end

return M
