local present, navigator = pcall(require, "navigator")

if not present then
  return
end

M = {}

local config = {
  debug = false,
  transparency = 5,
  lsp_signature_help = false, -- needs plugin lsp_signature 
  default_mapping = false,
  keymaps = {
    { key = 'gr', func = require('navigator.reference').async_ref, desc = 'lsp async_ref' },
    { key = '<Leader>gr', func = require('navigator.reference').reference, desc = 'lsp reference' }, -- reference deprecated
    {
      key = '<M-i>',
      mode = 'i',
      func = vim.lsp.buf.signature_help,
      desc = 'lsp signature_help'
    },
    -- { key = '<C-i>', func = vim.lsp.buf.signature_help, desc = 'lsp signature_help' },
    { key = 'g0', func = require('navigator.symbols').document_symbols, desc = 'lsp document_symbols' },
    { key = 'gW', func = require('navigator.workspace').workspace_symbol_live, desc = 'lsp workspace_symbol_live' },
    { key = '<c-]>', func = require('navigator.definition').definition, desc = 'lsp definition' },
    { key = 'gd', func = require('navigator.definition').definition, desc = 'lsp definition' },
    { key = 'gD', func = vim.lsp.buf.declaration, desc = 'lsp declaration' },
    { key = 'gp', func = require('navigator.definition').definition_preview, desc = 'lsp definition_preview' },
    { key = '<Leader>gt', func = require('navigator.treesitter').buf_ts, desc = 'lsp buf_ts' },
    { key = '<Leader>gT', func = require('navigator.treesitter').bufs_ts, desc = 'lsp bufs_ts' },
    { key = '<Leader>ct', func = require('navigator.ctags').ctags, desc = 'lsp ctags' },
    { key = 'K', func = vim.lsp.buf.hover, desc = 'lsp hover' },
    { key = '<C-a>', mode = 'n', func = require('navigator.codeAction').code_action, desc = 'lsp code_action' },
    {
      key = '<C-a>',
      mode = 'v',
      func = require('navigator.codeAction').range_code_action,
      desc = 'lsp range_code_action',
    },
    -- { key = '<Leader>re', func = 'rename()' },
    { key = '<Space>rn', func = require('navigator.rename').rename, desc = 'lsp rename' },
    { key = '<Leader>gc', func = vim.lsp.buf.incoming_calls, desc = 'lsp incoming_calls' },
    { key = '<Leader>go', func = vim.lsp.buf.outgoing_calls, desc = 'lsp outgoing_calls' },
    { key = '<Leader>gi', func = vim.lsp.buf.implementation, desc = 'lsp implementation' },
    { key = '<Space>D', func = vim.lsp.buf.type_definition, desc = 'lsp type_definition' },
    { key = 'gL', func = require('navigator.diagnostics').show_diagnostics, desc = 'lsp show_diagnostics' },
    { key = 'gG', func = require('navigator.diagnostics').show_buf_diagnostics, desc = 'lsp show_buf_diagnostics' },
    -- { key = '<Leader>dt', func = require('navigator.diagnostics').toggle_diagnostics, desc = 'lsp toggle_diagnostics' },
    { key = '<Leader>dt', func = require('spike.lsp').toggle_diagnostics, desc = 'lsp toggle_diagnostics' },
    { key = ']d', func = vim.diagnostic.goto_next, desc = 'lsp next diagnostics' },
    { key = '[d', func = vim.diagnostic.goto_prev, desc = 'lsp prev diagnostics' },
    { key = ']O', func = vim.diagnostic.set_loclist, desc = 'lsp diagnostics set loclist' },
    { key = ']r', func = require('navigator.treesitter').goto_next_usage, desc = 'lsp goto_next_usage' },
    { key = '[r', func = require('navigator.treesitter').goto_previous_usage, desc = 'lsp goto_previous_usage' },
    { key = '<C-LeftMouse>', func = vim.lsp.buf.definition, desc = 'lsp definition' },
    { key = 'g<LeftMouse>', func = vim.lsp.buf.implementation, desc = 'lsp implementation' },
    { key = '<Leader>k', func = require('navigator.dochighlight').hi_symbol, desc = 'lsp hi_symbol' },
    { key = '<Space>wa', func = require('navigator.workspace').add_workspace_folder, desc = 'lsp add_workspace_folder' },
    {
      key = '<Space>wr',
      func = require('navigator.workspace').remove_workspace_folder,
      desc = 'lsp lsp remove_workspace_folder',
    },
    { key = '<Space>ff', func = vim.lsp.buf.format, mode = 'n', desc = 'lsp format' },
    -- { key = '<Space>ff', func = vim.lsp.buf.range_formatting, mode = 'v', desc = 'lsp range format' },
    -- DEPRECATED 
    -- {
    --   key = '<Space>gm',
    --   func = require('navigator.formatting').range_format,
    --   mode = 'n',
    --   desc = 'lsp range format operator e.g gmip',
    -- },
    { key = '<Space>wl', func = require('navigator.workspace').list_workspace_folders, desc = 'lsp list_workspace_folders' },
    { key = '<Space>la', mode = 'n', func = require('navigator.codelens').run_action, desc = 'lsp run code lens action' },
  },

  icons = {
    icons = true, -- set to false to use system default ( if you using a terminal does not have nerd/icon)
    -- Code action
    code_action_icon = ' ', -- "",

    -- code lens
    code_lens_action_icon = '',

    -- Diagnostics
    diagnostic_head = '',   -- default diagnostic head on dialogs
    diagnostic_err =  '',    -- severity 1
    diagnostic_warn = '',   --          2
    diagnostic_info = '',   --          3
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
  mason = true,
  mason_disabled_for = {"ccls"}, -- disable mason for specified lspclients 
  lsp = {
    document_highlight = false,
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

    diagnostic_scrollbar_sign = false,

    disable_lsp = {"clangd"},

    -- disable auto start of lsp per language
    -- set global default on lspconfig (see lspconfig doc)
    gopls = {
      -- on_attach = require("spike.lsp.go").custom_attach,
      on_attach = require("spike.lsp.go").gopls_onattach,
      settings = {
        gopls = {
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        }
      }
    },

    ["lua-dev"] = {
      library = {
        enabled = true,
        plugins = {"plenary.nvim"},
        -- plugins = {"navigator.lua", "guihua.lua", "go.nvim", "plenary.nvim"},
        runtime = true,
        types = true,
      }
    },
  }
}

M.setup = function()
  navigator.setup(config)
end

-- make sure LSP is not started automatically
-- TODO: how to it per project basis
-- M.enable = function()
--   local lspconfig = require("lspconfig")
--   lspconfig.util.default_config = vim.tbl_extend(
--     "force",
--     lspconfig.util.default_config,
--     {
--       autostart = true
--     }
--   )
--   vim.cmd[[
--   LspStart
--   ]]
-- end

return M
