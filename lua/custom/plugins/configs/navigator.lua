local present, navigator = pcall(require, "navigator")


if not present then
  return
end

local myicons = require("custom.chadrc").ui.myicons

M = {}

local get_current_gomod = function()
  local file = io.open('go.mod', 'r')
  if file == nil then
    return nil
  end

  local first_line = file:read()
  local mod_name = first_line:gsub('module ', '')
  file:close()
  return mod_name
end

-- default config 
-- "~/.local/share/nvim/site/pack/packer/opt/navigator.lua/lua/navigator.lua"
-- "~/.local/share/nvim/site/pack/packer/opt/navigator.lua/lua/navigator/lspclient/mapping.lua"
local config = {
  debug = false,
  transparency = 5,
  lsp_signature_help = false, -- needs plugin lsp_signature 
  default_mapping = false,
  on_attach = require('plugins.configs.lspconfig').on_attach,
  keymaps = {
    {
        key = 'gr',
        func = require('navigator.reference').async_ref,
        desc = 'lsp async_ref'
    },
    {
        key = '<leader>lr',
        func = require('navigator.reference').reference,
        desc = 'lsp reference'
    },
    {
        key = 'g0',
        func = require('navigator.symbols').document_symbols,
        desc = 'lsp document_symbols'
    },
    {
        key = 'gW',
        func = require('navigator.workspace').workspace_symbol_live,
        desc = 'lsp workspace_symbol_live'
    },
    {
        key = '<c-]>',
        func = require('navigator.definition').definition,
        desc = 'lsp definition'
    },
    {
        key = '<C-LeftMouse>',
        func = require('navigator.definition').definition,
        desc = "lsp definition"
    },
    { key = 'gd', func = require('navigator.definition').definition, desc = 'definition' },
    { key = 'gD', func = vim.lsp.buf.declaration, desc = 'declaration' },
    { key = 'gm', func = vim.lsp.buf.implementation, desc = 'implementation' },
    { key = 'g<LeftMouse>', func = vim.lsp.buf.implementation, desc = 'implementation' },
    {
        key = 'gp',
        func = require('navigator.definition').definition_preview,
        desc = 'lsp definition preview'
    },
    { key = "<BS>h", func = function()
        vim.lsp.inlay_hint(0, nil)
    end, desc = "toggle lsp hints"},
    { key = '<leader>D', func = vim.lsp.buf.type_definition, desc = 'type_definition' },
    { key = '<leader>Dp', func = require('navigator.definition').type_definition_preview, desc = 'lsp type definition preview' },

    { key = '<M-a>', mode = 'n', func = require('navigator.codeAction').code_action, desc = 'lsp code_action' },
    { key = '<M-a>', mode = 'i', func = require('navigator.codeAction').code_action, desc = 'lsp code_action' },
    { key = '<BS><Right>', mode = 'n', func = require('navigator.symbols').side_panel, desc = 'toggle lsp outline pannel'},
    {
      key = '<M-a>',
      mode = 'v',
      func = require('navigator.codeAction').range_code_action,
      desc = 'lsp range_code_action',
    },
    { key = '<Space>rn', func = require('navigator.rename').rename, desc = 'lsp rename' },
    { key = '<Leader>gi', func = vim.lsp.buf.incoming_calls, desc = 'lsp incoming_calls' },
    { key = '<Leader>go', func = vim.lsp.buf.outgoing_calls, desc = 'lsp outgoing_calls' },
    { key = 'gL', func = require('navigator.diagnostics').show_diagnostics, desc = 'lsp show_diagnostics' },
    { key = 'gG', func = require('navigator.diagnostics').show_buf_diagnostics, desc = 'lsp show_buf_diagnostics' },
    --TODO: toggle diagnostics
    {
        key = ']d',
        func = vim.diagnostic.goto_next,
        desc = 'next diagnostics',
    },
    {
        key = '[d',
        func = vim.diagnostic.goto_prev,
        desc = 'prev diagnostics',
    },
    {
        key = ']O',
        func = vim.diagnostic.set_loclist,
        desc = 'diagnostics set loclist',
    },
    { key = ']r', func = require('navigator.treesitter').goto_next_usage, desc = 'lsp goto_next_usage' },
    { key = '[r', func = require('navigator.treesitter').goto_previous_usage, desc = 'lsp goto_previous_usage' },
    {
        key = '<leader>lf',
        func = vim.lsp.buf.format,
        mode = 'n',
        desc = 'lsp format'
    },
    {
        key = '<leader>lf',
        func = vim.lsp.buf.range_formatting,
        mode = 'v',
        desc = 'lsp range format'
    },
    { key = '<Leader>k', func = require('navigator.dochighlight').hi_symbol, desc = 'lsp hi_symbol' },
    { key = '<leader>wa', func = require('navigator.workspace').add_workspace_folder, desc = 'lsp add_workspace_folder' },
    {
      key = '<leader>wr',
      func = require('navigator.workspace').remove_workspace_folder,
      desc = 'lsp lsp remove_workspace_folder',
    },
    { key = '<leader>wl', func = require('navigator.workspace').list_workspace_folders, desc = 'lsp list_workspace_folders' },
    { key = '<leader>ll', mode = 'n', func = require('navigator.codelens').run_action, desc = 'lsp run code lens action' },
  },

  icons = {
    icons = true, -- set to false to use system default ( if you using a terminal does not have nerd/icon)
    -- Code action
    code_action_icon = '', -- "",

    -- code lens
    code_lens_action_icon = '',

    -- Diagnostics
    diagnostic_head = myicons.lsp.diagnostic_head,   -- default diagnostic head on dialogs
    diagnostic_err =  myicons.lsp.diagnostic_err,    -- severity 1
    diagnostic_warn = myicons.lsp.diagnostic_warn,   --          2
    diagnostic_info = myicons.lsp.diagnostic_info,   --          3
    diagnostic_hint = myicons.lsp.diagnostic_hint,   --          4

    -- used in the diagnostics summary window
    diagnostic_head_severity_1 = '',
    diagnostic_head_severity_2 = '',
    diagnostic_head_severity_3 = 'i',
    diagnostic_head_description = ' ',
    diagnostic_virtual_text = '',
    diagnostic_file = ' ',

    -- Values
    --
    value_changed = '碑',
    value_definition = ':', -- it is easier to see than 🦕
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
      var = ' ',
      method = 'ƒ ',
      ['function'] = ' ',
      parameter = '',
      associated = '',
      namespace = '',
      type = ' ',
      field = '',
      module = '',
      flag = '',
    },
    treesitter_defult = '',
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
      severity_sort = { reverse = false },
    },

    code_action = {
        delay = 6000, -- 5 sec delay
        virtual_text_icon = false,
    },

    diagnostic_scrollbar_sign = false,
    display_diagnostic_qf = false,

    disable_lsp = {"clangd", "rust_analyzer"},

    -- disable auto start of lsp per language
    -- set global default on lspconfig (see lspconfig doc)
    gopls = {
        -- cmd = { "nc", "localhost", "9999" },
      -- cmd = {"socat", "-" ,"tcp:localhost:4444"},
      -- on_attach = require("spike.lsp.go").custom_attach,
      on_attach = require("spike.lsp.go").gopls_onattach,
      settings = {
          flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
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
              analyses = {
                  unreachable = true,
                  nilness = true,
                  unusedparams = true,
                  useany = true,
                  unusedwrite = true,
                  ST1003 = true,
                  undeclaredname = true,
                  fillreturns = true,
                  nonewvars = true,
                  fieldalignment = false,
                  shadow = true,
              },
              codelenses = {
                  generate = true, -- show the `go generate` lens.
                  gc_details = true, -- Show a code lens toggling the display of gc's choices.
                  test = true,
                  tidy = true,
                  vendor = true,
                  regenerate_cgo = true,
                  upgrade_dependency = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              matcher = 'Fuzzy',
              diagnosticsDelay = '500ms',
              symbolMatcher = 'fuzzy',
              ['local'] = get_current_gomod(),
              -- gofumpt = _GO_NVIM_CFG.lsp_gofumpt or false, -- true|false, -- turn on for new repos, gofmpt is good but also create code turmoils
              buildFlags = { '-tags', 'integration' },
          }
      }
    },
    pylsp = {
        settings = {
            pylsp = {
                plugins = {
                    black = { enabled = true},
                    autopep8 = { enabled = false },
                    -- pylint = { enabled = false }, -- disabled in null-ls
                    flake8 = { enabled = false },
                    mccabe = { enabled = false },
                    pycodestyle= { enabled = false},
                    pyflakes = { enabled = false },

                    -- install python-lsp-ruff
                    -- if using mason activate venv from mason package 
                    -- and install inside venv
                    -- select isort and pycodestyle
                    ruff = { enabled = true, select = {"I", "E"}} 
                }
            }
        }
    },
    lua_ls = {
        before_init=require("neodev.lsp").before_init,
    }

    -- FIX: deperecated https://github.com/ray-x/navigator.lua/commit/1b2a0856f4adfffc5c4e785a6779c62759c8c926
    -- ["neodev"] = {
    --   library = {
    --     enabled = true,
    --     runtime = true,
    --     -- plugins = true,
    --     plugins = {"plenary.nvim"},
    --     -- plugins = {"navigator.lua", "guihua.lua", "go.nvim", "plenary.nvim"},
    --     types = true,
    --   },
    --   setup_jsonls = true,
    -- },
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
